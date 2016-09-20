//
//  RootViewController.m
//  Bilibili
//
//  Created by LunarEclipse on 16/9/2.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "RootViewController.h"

@import YYKit;
@import ReactiveCocoa;

@interface RootViewController ()

@property (weak, nonatomic) IBOutlet UIView *titleContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeightConstraint;

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.navigationController)
        self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark Delegate

/* UINavigationController */
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //若NavigationController的当前Controller是RootViewController则隐藏导航栏
    BOOL isHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isHomePage animated:YES];
}

#pragma mark Setter

-(void)setTitleName:(NSString *)titleName
{
    UILabel * label = [[UILabel alloc] initWithFrame:_titleContainer.bounds];
    label.text = titleName;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self setTitleView:label];
}

-(void)setTitleView:(UIView *)titleView
{
    if (_titleView != nil) [_titleView removeFromSuperview];
    _titleView = titleView;
    
    [_titleContainer addSubview:titleView];
    _titleHeightConstraint.constant = titleView.frame.size.height;
    
    //根据titleView的高度动态更新titleContainer高度
    [titleView rac_observeKeyPath:@"bounds" options:NSKeyValueObservingOptionNew observer:nil block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
        _titleHeightConstraint.constant = _titleView.frame.size.height;
    }];
}

@end
