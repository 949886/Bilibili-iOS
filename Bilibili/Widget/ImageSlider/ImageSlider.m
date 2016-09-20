//
//  ImageSlider.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/7.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "ImageSlider.h"
#import "ImageSliderCell.h"
#import "ImageSliderScroller.h"

#import "extension.h"

/* 将变量的值x限定在[0, N), 大于等于N则=x%N , 小于0则等于N-|x % N| (和溢出截断类似)*/
#define VALUE_RESTRICTION(_value_, _restriction_) \
((_restriction_) > 0) ? (((_value_) >= 0) ? (_value_) % (_restriction_) : (_restriction_) + ((_value_) % (_restriction_))) : 0

@interface ImageSlider ()

@property (nonatomic, strong) ImageSliderScroller * scrollView;
@property (nonatomic, strong) UIPageControl * pageControl;

@property (nonatomic, strong) NSMutableArray * items;
@property (nonatomic, strong) NSMutableArray * cells;

@property (nonatomic, strong) NSTimer * timer;

@property (nonatomic, assign, readonly) NSInteger itemCount;

@property (nonatomic, strong) dispatch_semaphore_t semaphore;

@end

#pragma mark Initialization

@implementation ImageSlider

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
        [self initialize];
    return self;
}

-(instancetype)initWithType:(ImageSliderType)type
{
    self.type = type;
    return [self initWithFrame:CGRectZero];
}

-(void)awakeFromNib
{
    [self initialize];
}

-(void)initialize
{
    self.clipsToBounds = YES;
    
    //Setup ScrollView
    _scrollView = [[ImageSliderScroller alloc]initWithFrame:self.bounds];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _scrollView.pagingEnabled = YES;
    _scrollView.clipsToBounds = NO;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.userInteractionEnabled = YES;
    [self addSubview:_scrollView];
    
    //Setup PageControl
    _pageControl = [UIPageControl new];
    _pageControl.autoresizingMask = UIViewAutoresizingNone;
    _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:1 green:0.33 blue:0.5 alpha:1];
    [self addSubview:_pageControl];
    
    //Initialization
    _scrollAutomatically = YES;
    _scrollInfinitely = YES;
    _scrollInterval = 4;    //默认4秒自动翻页
    
    _items = [NSMutableArray array];
    _cells = [NSMutableArray array];
    
    //Multi-thread
    _semaphore = dispatch_semaphore_create(1);
}

#pragma mark Override

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //未指定imageSize则一张image默认填充整个view
    if (CGSizeEqualToSize(_imageSize, CGSizeZero))
        _imageSize = self.bounds.size;

    NSInteger multiply = (_items.count >= 3 || _items.count == 0) ? _items.count : 3; //ScrollView的contentSize最小为width的3倍
    
    _scrollView.frame = CGRectMake((self.frame.size.width -_imageSize.width) / 2, 0, _imageSize.width, _imageSize.height);
    _scrollView.contentSize = CGSizeMake(_imageSize.width * multiply, _scrollView.frame.size.height);
    _scrollView.contentOffset = CGPointMake(_imageSize.width, 0);
    
    _pageControl.frame = CGRectMake(self.frame.size.width - 8 * _items.count - 15, self.frame.size.height - 15, _items.count * 8, 10);
    _pageControl.numberOfPages = _items.count;
    [self scrollViewDidScroll:_scrollView];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    if(nil == _timer)
        [self setupTimer];
    
    if(!newSuperview)
        _timer = nil;
}

-(void)willRemoveSubview:(UIView *)subview
{
    [self removeTimer];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *child = [super hitTest:point withEvent:event];
    if (child == self) return _scrollView;
    return child;
}

-(void)setImages:(NSArray<NSString *> *)images
{
    if (!images && images.count == 0) return;
    _pageControl.hidden = NO;
    
    //若只有一张图片，则凑到2张并隐藏PageControl
    if (1 == images.count)
    {
        NSMutableArray * array = [NSMutableArray array];
        for (int i = 0; i < 2; ++i)
            [array addObject:images.firstObject];
        _images = array;
        
        _pageControl.hidden = YES;
        _scrollView.scrollEnabled = NO;
        [self deactivate];
    }
    else _images = images;
    
    [_items removeAllObjects];

    [self removeTimer];
    for (NSString * image in _images)
    {
        NSString * url = [[NSBundle mainBundle] pathForResource:image ofType:nil];
        UIImage * image = [UIImage imageWithContentsOfFile:url];
        [_items addObject:image];
    }
    [self setupTimer];
    
    if (_urls.count > 0)
        _urls = [NSArray array];
    
    [self setNeedsLayout];
    [self reloadImages];
}

-(void)setUrls:(NSArray<NSString *> *)urls
{
    if (!urls && urls.count == 0) return;
    _pageControl.hidden = NO;
    
    //同上，若只有一张图片，则凑到2张并隐藏PageControl
    if (1 == urls.count)
    {
        NSMutableArray * array = [NSMutableArray array];
        for (int i = 0; i < 2; ++i)
            [array addObject:urls.firstObject];
        _urls = array;
        
        _pageControl.hidden = YES;
        _scrollView.scrollEnabled = NO;
        [self deactivate];
    }
    else _urls = urls;
    
     [_items removeAllObjects];
    
    //移除计时器，防止滚动出错
    [self removeTimer];
    
    //线程安全
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
        for (NSString * urlString in _urls)
        {
            NSURL * url = [NSURL URLWithString:urlString];
            UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
            if(image != nil)  [_items addObject:image];
            if(_items.count == urls.count)
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf setNeedsLayout];
                    [weakSelf reloadImages];
                    [weakSelf setupTimer];  //重新启动计时器
                    dispatch_semaphore_signal(_semaphore);
                });
        }
    });
    
    
    if (_images.count > 0)
        _images = [NSArray array];
}

-(void)setIndex:(int)index
{
    if (_index >= (int)_items.count) _index = 0;
    if (_index < 0) _index = (int)_items.count - 1;
    [self scrollToIndex:index];
}

-(NSInteger)itemCount
{
    return _urls.count + _images.count;
}

#pragma mark Delegate

/* UIScrollView Delegate */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static BOOL scrollForward = false;
    static BOOL scrollBackward = false;
    

    if (scrollView.contentOffset.x != 0)
    {
        if (!scrollForward && scrollView.contentOffset.x > _imageSize.width * 1.5) scrollForward = true;
        else scrollForward = false;
        if (!scrollBackward && scrollView.contentOffset.x < _imageSize.width * 0.5) scrollBackward = true;
        else scrollBackward = false;
    }
    
    /* 每一次滚动都会在此刷新index和image */
    if (scrollForward || scrollBackward)
    {
        //更改_index，并将ScrollView的contentOffset往后倒退一张图片的宽度（之后根据index重新加载图片以达到无限循环）
        if (scrollForward) {
            _index += 1;
            _scrollView.contentOffset = CGPointMake(_scrollView.contentOffset.x - _imageSize.width, 0);
        }
        if (scrollBackward) {
            _index -= 1;
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x + _imageSize.width, 0);
        }
        if (_index >= (int)_items.count) _index = 0;
        if (_index < 0) _index = (int)_items.count - 1;
        
        //所有cell基于_index重新加载对应图片
        [self reloadImages];
        
        _pageControl.currentPage = _index;
    }
    
    // Cell 复用
    [self updateCellsForReuse];
    
    // preload left and right cell
    int page = _scrollView.contentOffset.x / _imageSize.width + 0.5;
    for (int i = page - 1; i <= page + 1; i++)
    {
        //最少创建3个cell重用
        NSInteger count = (_items.count >= 3 || _items.count == 0) ? _items.count : 3;
        if (i >= 0 && i < count)
        {
            ImageSliderCell *cell = [self cellAtIndex:i];
            if (!cell)
            {
                ImageSliderCell *cell = [self dequeueReusableCell];
                cell.center = CGPointMake(_imageSize.width * (i + 0.5) + _padding * i + _padding / 2, cell.center.y);
                cell.index = i;
                cell.tag = i;
                int index = VALUE_RESTRICTION(i - 1, (int)_items.count);
                if(index < _items.count)
                    cell.image = _items[index];
                [_scrollView addSubview:cell];
            }
            //else if (!cell.image) cell.image = _items[i];
        }
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setupTimer];
}

#pragma mark Callback Function

-(void)automaticScrollCallFunc
{
    if (0 == _items.count) return;
    self.index += 1;
}

-(void)respondToTapGesture:(UITapGestureRecognizer *)recognizer
{
    ImageSliderCell * cell = (ImageSliderCell *)recognizer.view;
    int index = VALUE_RESTRICTION(_index + cell.index - 1, (int)_items.count);
    _didClickSegment(index);
}

#pragma mark Encapsulation

- (void)scrollToIndex:(int)index
{
    int different = index - _index;
    float contentOffset = _scrollView.contentOffset.x + _imageSize.width * different;
    
    //調整滚动偏差
    int deviation = (int)contentOffset % (int)_imageSize.width;
    if (deviation >= _imageSize.width * 0.1)
        contentOffset -= deviation;
    else if (deviation <=  _imageSize.width * 0.1)
        contentOffset += deviation;

    [_scrollView setContentOffset:CGPointMake(contentOffset, 0) animated:YES];
}

-(void)setupTimer
{
    if (_timer == nil && _scrollAutomatically)
    {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:_scrollInterval target:self selector:@selector(automaticScrollCallFunc) userInfo:nil repeats:YES];
        _timer = timer;
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
}

-(void)removeTimer
{
    if (_timer != nil)
    {
        [_timer invalidate];
        _timer = nil;
    }
}


/* Cell 复用 */

- (void)updateCellsForReuse
{
    //若cell边界超出左右cell，则将其移除以供复用
    for (ImageSliderCell *cell in _cells)
    {
        if (cell.superview)
            if (cell.frame.origin.x > _scrollView.contentOffset.x + _imageSize.width * 2||
                cell.frame.origin.x + cell.frame.size.width < _scrollView.contentOffset.x - _imageSize.width)
            {
                [cell removeFromSuperview];
                cell.index = -1;
                cell.image = nil;
                NSLog(@"%s Cell removed for reuse.", __FUNCTION__);
            }
    }
}

-(ImageSliderCell *)dequeueReusableCell
{
    //若cells中存在未被加入superview的cell，则返回该cell复用
    ImageSliderCell *cell = nil;
    for (cell in _cells)
        if (!cell.superview)
            return cell;

    //若找不到可以复用的cell，则创建新cell
    cell = [ImageSliderCell new];
    cell.frame = CGRectMake(0, 0, _imageSize.width, _imageSize.height);
    cell.index = -1;
    [_cells addObject:cell];
    
    //创建Cell的点击事件
    UITapGestureRecognizer * tapRecognizer = [UITapGestureRecognizer new];
    [tapRecognizer addTarget:self action:@selector(respondToTapGesture:)];
    [cell addGestureRecognizer:tapRecognizer];
    
    return cell;
}

-(ImageSliderCell *)cellAtIndex:(NSInteger)index
{
    for(ImageSliderCell * cell in _cells)
        if(cell.index == index)
            return cell;
    return nil;
}

-(void)reloadImages
{
    for (int i = 0; i < _cells.count; ++i)
    {
        ImageSliderCell * cell = [self cellAtIndex:i];
        int index = VALUE_RESTRICTION(_index + i - 1, (int)_items.count);
        if(index < _items.count)
            cell.image = _items[index];
    }
}

#pragma mark Methods

-(void)activate
{
    _scrollAutomatically = YES;
    [self setupTimer];
}

-(void)deactivate
{
    _scrollAutomatically = NO;
    [self removeTimer];
}

-(void)handleClickEvent:(void(^)(NSInteger))block
{
    _didClickSegment = block;
}

//TODO: 图片缓存处理

@end
