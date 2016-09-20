//
//  TabsController.m
//  Bilibili
//
//  Created by LunarEclipse on 16/9/7.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "TabsController.h"

@import YYKit;
@import MJRefresh;
@import ReactiveCocoa;

@interface TabsController ()

@end

@implementation TabsController

#pragma mark Override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化scrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:self.contentView.bounds];
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.contentView addSubview:_scrollView];
    
    //初始化titleView
    SegmentedControl * segmentedControl = [[SegmentedControl alloc]initWithType:SegmentedControlTypeUnderlined];
    segmentedControl.frame = CGRectMake(0, 0, 200, 32);
    segmentedControl.centerX = [UIScreen mainScreen].bounds.size.width * 0.5;
    segmentedControl.index = 0;
    segmentedControl.color = [UIColor whiteColor];
    segmentedControl.font = [UIFont fontWithName:@"AvenirNext-UltraLight" size:16];
    self.segmentedControl = segmentedControl;
    [self setTitleView:segmentedControl];
    
    [segmentedControl handleEventWithBlock:^(NSInteger index) { //监听点击
        [_scrollView setContentOffset:CGPointMake(index * _scrollView.width, 0) animated:YES];
    }];
    
    //监听ScrollView滚动
    [[_scrollView rac_valuesForKeyPath:@"contentOffset" observer:nil]subscribeNext:^(id x) {
        int page = _scrollView.contentOffset.x / _scrollView.width + 0.5;
        if(page >= _segmentedControl.items.count) return;
        if(page != _segmentedControl.index)
            _segmentedControl.index = page;
    }];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //Setup scrollView
    _scrollView.contentSize = CGSizeMake(_scrollView.width * _viewControllers.count, _scrollView.height);
    _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    //Adjust position.
    for (int i = 0; i < _viewControllers.count; ++i)
        _viewControllers[i].view.left = _scrollView.width * i;
}

#pragma mark Getter & Setter

-(void)setViewControllers:(NSArray<UIViewController *> *)viewControllers
{
    _viewControllers = viewControllers;
    
    for (UIViewController * viewController in viewControllers)
        [self addViewToScrollView:viewController];
}

-(void)setTabs:(NSArray<NSString *> *)tabs
{
    _segmentedControl.items = tabs.mutableCopy;
}

#pragma mark Encapsulation

- (void)addViewToScrollView:(UIViewController *)controller
{
    controller.view.frame = _scrollView.bounds;
    controller.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_scrollView addSubview:controller.view];
}

@end
