//
//  CustomTabBar.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/7.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "CustomTabBar.h"

@interface ImagePair : NSObject 
@property (nonatomic, strong) UIImage * normalImage;
@property (nonatomic, strong) UIImage * highlightedImage;
@end

@implementation ImagePair
@end


@interface CustomTabBar ()

@property (nonatomic, weak) UITabBarController * tabBarViewController;

@property (nonatomic, copy) NSMutableArray * buttons;
@property (nonatomic, copy) NSMutableDictionary * imagePairs;

@end

@implementation CustomTabBar

#pragma mark Initialization

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _buttons = [NSMutableArray array];
        _imagePairs = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark Override

-(void)didMoveToSuperview
{
    //遍历superview，寻找UITabBarController
    for (UIView *view = self; view; view = view.superview)
    {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UITabBarController class]])
            _tabBarViewController = (UITabBarController *)nextResponder;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSMutableArray * tabBarButtons = [NSMutableArray array];
    if(0 != _imagePairs.allKeys.count)
    {
        //遍历subviews，找到所有的UITabBarButton(一个UITabBarButton代表一个选项卡)
        for (id object in self.subviews)
            if ([object isKindOfClass:NSClassFromString(@"UITabBarButton")])
                [tabBarButtons addObject:object];
        
        if (0 == tabBarButtons.count) return;
        
        //用UIButton创建自定义选项卡
        [_imagePairs enumerateKeysAndObjectsUsingBlock:^(NSNumber * key, ImagePair * imagePair, BOOL * stop) {
            if ([key integerValue] >= self.items.count) return;
            
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = [key integerValue];
            button.frame = ((UIView *)tabBarButtons[[key integerValue]]).frame;
            button.center = CGPointMake(button.center.x, self.bounds.size.height / 2);
            [button setImage:imagePair.normalImage forState:UIControlStateNormal];
            [button setImage:imagePair.highlightedImage forState:UIControlStateHighlighted];
            [button setImage:imagePair.highlightedImage forState:UIControlStateSelected];
            [button addTarget:self action:@selector(buttonClicks:) forControlEvents:UIControlEventTouchUpInside];
            [button addTarget:self action:@selector(buttonClicks:) forControlEvents:UIControlEventTouchUpInside];
            if(0 == [key integerValue]) button.selected = YES;
            
            [self addSubview:button];
            [_buttons addObject:button];
        }];
        
        //从subviews中移除所有的UITabBarButton
        for (UIView * tabBarButton in tabBarButtons)
            [tabBarButton removeFromSuperview];
    }
}

#pragma mark Callback Functions

-(void)buttonClicks:(UIButton *)sender
{
    //高亮被点击的按钮，取消其他高亮
    sender.selected = YES;
    for (UIButton * button in _buttons)
        if(button.tag != sender.tag)
            button.selected = NO;
    
    //页面跳转
    if (_tabBarViewController)
        _tabBarViewController.selectedIndex = sender.tag;
}

#pragma mark Methods

-(void)setTabAtIndex:(NSInteger)index normalImage:(UIImage *)normal highlightedImage:(UIImage *)highlighted
{
    ImagePair * imagePair = [ImagePair new];
    imagePair.normalImage = normal;
    imagePair.highlightedImage = highlighted;
    _imagePairs[@(index)] = imagePair;
    
    [self setNeedsLayout];
}

@end
