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
((_value_) >= 0) ? (_value_) % (_restriction_) : (_restriction_) + ((_value_) % (_restriction_))

@interface ImageSlider ()

@property (nonatomic, strong) ImageSliderScroller * scrollView;
@property (nonatomic, strong) UIPageControl * pageControl;

@property (nonatomic, strong) NSMutableArray * items;
@property (nonatomic, strong) NSMutableArray * cells;

@property (nonatomic, strong) NSTimer * timer;

@property (nonatomic, assign, readonly) NSInteger itemCount;

@end

#pragma mark Initialization

@implementation ImageSlider

-(instancetype)initWithType:(ImageSliderType)type
{
    if (self = [super initWithFrame:CGRectZero])
    {
        self.type = type;
        self.clipsToBounds = YES;
        
        //Setup ScrollView
        _scrollView = [[ImageSliderScroller alloc]initWithFrame:CGRectZero];
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        _scrollView.pagingEnabled = YES;
        _scrollView.clipsToBounds = NO;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.userInteractionEnabled = YES;
        [self addSubview:_scrollView];
        
        //Setup PageControl
        _pageControl = [UIPageControl new];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:1 green:0.33 blue:0.5 alpha:1];
        [self addSubview:_pageControl];
        
        //Initialization
        _scrollAutomatically = YES;
        _scrollInfinitely = YES;
        _scrollInterval = 2.5;
        
        _items = [NSMutableArray array];
        _cells = [NSMutableArray array];
    }
    return self;
}

#pragma mark Override

-(void)layoutSubviews
{
    //未指定imageSize则一张image默认填充整个view
    if (CGSizeEqualToSize(_imageSize, CGSizeZero))
        _imageSize = self.bounds.size;

    _scrollView.frame = CGRectMake((self.frame.size.width -_imageSize.width) / 2, 0, _imageSize.width, _imageSize.height);
    _scrollView.contentSize = CGSizeMake(_imageSize.width * _items.count, _scrollView.frame.size.height);
    _scrollView.contentOffset = CGPointMake(_imageSize.width, 0);
    
    _pageControl.frame = CGRectMake(self.frame.size.width - 15 * _items.count - 10, self.frame.size.height - 30, _pageControl.numberOfPages * 15, 20);
    _pageControl.numberOfPages = _items.count;
    
    [self scrollViewDidScroll:_scrollView];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
//    if(nil == _timer)
//        [self setupTimer];
    
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
    
    //图片数必须>=3
    if (1 == images.count || 2 == images.count)
    {
        NSMutableArray * array = [NSMutableArray array];
        if (1 == images.count) //若只有一张图片，则凑到三张
            for (int i = 0; i < 2; ++i)
                [array addObject:images.firstObject];
        if (2 == images.count) //若只有两张图片，则凑到四张
            [array addObjectsFromArray:images];
        _images = array;
    }
    else _images = images;
    
    for (NSString * image in images)
    {
        NSString * url = [[NSBundle mainBundle] pathForResource:image ofType:nil];
        UIImage * image = [UIImage imageWithContentsOfFile:url];
        [_items addObject:image];
    }
    
    if (_urls.count > 0)
        _urls = [NSArray array];
    
    [self setNeedsLayout];
}

-(void)setUrls:(NSArray<NSString *> *)urls
{
    if (!urls && urls.count == 0) return;
    
    //同上，图片数必须>=3
    if (1 == urls.count || 2 == urls.count)
    {
        NSMutableArray * array = [NSMutableArray array];
        if (1 == urls.count)
            for (int i = 0; i < 2; ++i)
                [array addObject:urls.firstObject];
        if (2 == urls.count)
            [array addObjectsFromArray:urls];
        _urls = array;
    }
    else _urls = urls;
    
    for (NSString * urlString in urls)
    {
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSURL * url = [NSURL URLWithString:urlString];
            UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
            [_items addObject:image];
            if(_items.count == urls.count)
                [weakSelf setNeedsLayout];
        });
    }
    
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
    

    if (scrollView.contentOffset.x != 0) {
        if (!scrollForward && scrollView.contentOffset.x > _imageSize.width * 1.5) scrollForward = true;
        else scrollForward = false;
        if (!scrollBackward && scrollView.contentOffset.x < _imageSize.width * 0.5) scrollBackward = true;
        else scrollBackward = false;
    }
    
    
    /* 每一次滚动都会在此刷新index和image */
    if (scrollForward || scrollBackward)
    {
        //更改_index，并将ScrollView往后倒退一张图片的宽度（之后根据index重新加载图片以达到无限循环）
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
        for (int i = 0; i < _items.count; ++i)
        {
            ImageSliderCell * cell = [self cellAtIndex:i];
            int index = VALUE_RESTRICTION(_index + i - 1, (int)_items.count);
            cell.image = _items[index];
        }
        
        _pageControl.currentPage = _index;
    }
    
    /* Cell 复用 */
    [self updateCellsForReuse];
    
    // preload left and right cell
    int page = _scrollView.contentOffset.x / _imageSize.width + 0.5;
    for (int i = page - 1; i <= page + 1; i++)
    {
        if (i >= 0 && i < _items.count)
        {
            ImageSliderCell *cell = [self cellAtIndex:i];
            if (!cell)
            {
                ImageSliderCell *cell = [self dequeueReusableCell];
                cell.center = CGPointMake(_imageSize.width * (i + 0.5) + _padding * i + _padding / 2, cell.center.y);
                cell.index = i;
                cell.tag = i;
                cell.image = _items[VALUE_RESTRICTION(i - 1, (int)_items.count)];
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
    
    //避免偏差
    int deviation = (int)contentOffset % (int)_imageSize.width;
    if (deviation >= 0.1 * _imageSize.width)
        contentOffset -= deviation;
    else if (deviation <= -0.1 * _imageSize.width)
        contentOffset += deviation;

    [_scrollView setContentOffset:CGPointMake(contentOffset, 0) animated:YES];
}

-(void)setupTimer
{
    if (_scrollAutomatically)
    {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:_scrollInterval target:self selector:@selector(automaticScrollCallFunc) userInfo:nil repeats:YES];
        _timer = timer;
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
}

-(void)removeTimer
{
    if (_scrollAutomatically)
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

#pragma mark Methods

-(void)activate
{
    if (nil == _timer)
        [self setupTimer];
}

-(void)deactivate
{
    if (nil != _timer)
        [self removeTimer];
}

-(void)handleEventWithBlock:(void(^)(NSInteger))block
{
    _didClickSegment = block;
}

//TODO: 图片缓存处理

@end
