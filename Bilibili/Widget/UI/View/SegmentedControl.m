//
//  SegmentedControl.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/8.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "SegmentedControl.h"

#pragma mark - Segment

@interface Segment : UIView

@property (nonatomic, copy) NSString * title;
@property (nonatomic, strong) UIColor * titleColor;
@property (nonatomic, strong) UIButton * button;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, weak) SegmentedControl * segmentedControl;

//@property (nonatomic, copy, nullable) void(^didClickSegment)(NSInteger);

@end


@implementation Segment

- (instancetype)init
{
    if (self = [super initWithFrame:CGRectZero])
    {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = self.bounds;
        _button.userInteractionEnabled = YES;
        _button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonClicks:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
    }
    return self;
}

-(void)setTitle:(NSString *)title
{
    [_button setTitle:title forState:UIControlStateNormal];
}

-(void)setSelected:(BOOL)selected
{
    if(selected) [_button setTitleColor:_titleColor forState:UIControlStateNormal];
    else [_button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

-(void)buttonClicks:(UIButton *)sender
{
    if(nil == self.segmentedControl) return;
    
    self.segmentedControl.index = self.tag;
    
//    for (Segment * segment in [self.segmentedControl valueForKey:@"segments"])
//    {
//        if(segment.tag == self.segmentedControl.index)
//            segment.selected = YES;
//        else segment.selected = NO;
//    }
    
//    if(self.didClickSegment) self.didClickSegment(self.tag);
    if(self.segmentedControl.didClickSegment)
        self.segmentedControl.didClickSegment(self.tag);
}

@end


/*==========================SegmentedControl==============================*/


#pragma mark - SegmentedControl

@interface SegmentedControl ()

@property (nonatomic, assign) SegmentedControlType type;
@property (nonatomic, copy) NSMutableArray<Segment *> * segments;

/* Type Underline */
@property (nonatomic, strong) UIView * underline;

@end

@implementation SegmentedControl

#pragma mark Initialization

-(instancetype)initWithType:(SegmentedControlType)type
{
    if (self = [super initWithFrame:CGRectZero])
    {
        _type = type;
        _background = [UIView new];
        _scrollView = [UIScrollView new];
        _scrollView.scrollEnabled = NO;
        
        [self addSubview:_background];
        [self addSubview:_scrollView];

        _items = [NSMutableArray new];
        _segments = [NSMutableArray new];
        [self addObserver:self forKeyPath:@"_items.@count" options:1 context:NULL]; //监听items变化
        
        _color = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        _font = [UIFont systemFontOfSize:15];

        _underline = [UIView new];
        [self addSubview:_underline];
        
    }
    return self;
}


-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"_items.@count" context:NULL];
}

#pragma mark Override

-(void)layoutSubviews
{
    _background.frame = self.bounds;
    _scrollView.frame = self.bounds;
    _scrollView.contentSize = self.bounds.size;
    if(0 == _items.count) return;
    
    //Adjust segments' frame
    float segmentWidth = self.bounds.size.width / _items.count;
    
    for (int i = 0; i < _segments.count; ++i)
    {
        _segments[i].frame = CGRectMake(segmentWidth * i, 0, segmentWidth, self.bounds.size.height);
        _segments[i].titleColor = _color;
        _segments[i].button.titleLabel.font = _font;
    }
    
    //Move underline.
    if (_type == SegmentedControlTypeUnderlined)
    {
        _underline.backgroundColor = _color;
        
        CGRect rect = CGRectMake(segmentWidth * _index, self.bounds.size.height - 2, segmentWidth, 2);
        if(CGRectIsEmpty(_underline.frame))
            _underline.frame = rect;
        else
        {
            //监听动画过程
            CADisplayLink * link = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkCallback)];
            [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
            
            //开始动画
            [UIView animateWithDuration:0.4 animations:^{
                _underline.frame = rect;
            } completion:^(BOOL finished) {
                //结束监听
                [link removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
            }];
        }
    }
}

-(void)didMoveToSuperview
{
    [super didMoveToSuperview];
    //高亮第初始化默认被选中的
    if(_index < _segments.count)
        _segments[_index].selected = YES;
}


-(void)setIndex:(NSInteger)index
{
    _index = index;
    [self setNeedsLayout];
}

@synthesize items = _items;

- (NSMutableArray *)items;
{
    return [self mutableArrayValueForKey:@"_items"];
}

-(void)setItems:(NSMutableArray *)items
{
    _items = items;
    [self refreshSegments];
}

#pragma mark Delegate

/* 监听items的count，若数组被修改则该方法会被回调，并刷新SegmentedControl */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    [self refreshSegments];
}


#pragma mark Callback Function

-(void)displayLinkCallback
{
    CALayer * layer = _underline.layer.presentationLayer;
    float segmentWidth = self.bounds.size.width / _items.count;
    int i = (layer.frame.origin.x + segmentWidth * 0.5) / segmentWidth;
    if(i < _segments.count)
    {
        for (Segment * segment in _segments)
            segment.selected = NO;
        _segments[i].selected = YES;
    }
//    NSLog(@"%f", layer.frame.origin.x);
}

#pragma mark Encapsulation


-(void)refreshSegments
{
    //若items中的元素数小于segments中的元素数，则移除多余的segment
    if (_segments.count > _items.count)
        for (int i = (int)_items.count; i < _segments.count; ++i)
        {
            [_segments[i] removeFromSuperview];
            [_segments removeObjectAtIndex:i];
        }
    
    for (int i = 0; i < _items.count; ++i)
    {
        NSString * item = _items[i];
        if (i < _segments.count)
        {   //若title发生了改变，更改segment的title
            if (_segments[i].title != item)
                _segments[i].title = item;
        } //若items中的元素数大于segments中的元素数，创建新的segment
        else [self createSegment:item atIndex:i];
    }
    
    [self setNeedsLayout];
}

-(void)createSegment:(NSString *)title atIndex:(NSInteger)index
{
    Segment * segment = [Segment new];
    segment.tag = index;
    segment.title = title;
    segment.titleColor = self.color;
    segment.segmentedControl = self;
    [_segments insertObject:segment atIndex:index];
    [_scrollView addSubview:segment];
}


#pragma mark Methods

-(void)handleEventWithBlock:(void(^)(NSInteger))block;
{
    self.didClickSegment = block;
}

@end
