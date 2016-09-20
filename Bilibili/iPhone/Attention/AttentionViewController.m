//
//  AttentionViewController.m
//  Bilibili
//
//  Created by LunarEclipse on 16/9/2.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "AttentionViewController.h"
#import "ConcernedViewController.h"
#import "SubsriptionViewController.h"

@import YYKit;
@import MJRefresh;
@import ReactiveCocoa;

@interface AttentionViewController ()

@property (nonatomic, strong) ConcernedViewController * concernedViewController;
@property (nonatomic, strong) SubsriptionViewController * subsriptionViewController;

@end

@implementation AttentionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Setup tabs
    self.tabs = @[@"追番", @"动态", @"标签"];
    
    //Add view.
    _concernedViewController = [ConcernedViewController new];
    _subsriptionViewController = [SubsriptionViewController new];
    
    self.viewControllers = @[_concernedViewController, _subsriptionViewController];
}

#pragma mark Encapsulation

@end
