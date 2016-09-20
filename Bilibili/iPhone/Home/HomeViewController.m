//
//  HomeViewController.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/16.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "HomeViewController.h"

#import "LiveHomeViewController.h"
#import "RecHomeViewController.h"
#import "BangumiHomeViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) LiveHomeViewController * liveHomeViewController;
@property (nonatomic, strong) RecHomeViewController * recHomeViewController;
@property (nonatomic, strong) BangumiHomeViewController * bangumiHomeViewController;

@end

@implementation HomeViewController

#pragma mark Override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Setup tabs
    self.tabs = @[@"直播", @"推荐", @"番剧"];
    
    //Add Live & Recommend & Bangumi ViewController.
    _liveHomeViewController = [LiveHomeViewController new];
    _recHomeViewController = [RecHomeViewController new];
    _bangumiHomeViewController = [BangumiHomeViewController new];
    
    self.viewControllers = @[_liveHomeViewController, _recHomeViewController, _bangumiHomeViewController];
}

@end
