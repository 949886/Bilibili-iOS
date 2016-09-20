//
//  DiscoverViewController.m
//  Bilibili
//
//  Created by LunarEclipse on 16/9/2.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "DiscoverViewController.h"
#import "DiscoverTitleView.h"

@import YYKit;

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    DiscoverTitleView * titleView = [[[NSBundle mainBundle] loadNibNamed:@"DiscoverTitleView" owner:nil options:nil] firstObject];
    self.titleView = titleView;
    titleView.backgroundColor = [UIColor orangeColor];
    [titleView.aSwitch addTarget:self action:@selector(onClick) forControlEvents:UIControlEventValueChanged];
}

-(void)onClick
{
    [UIView animateWithDuration:2 animations:^{
        self.titleView.height += 50;
    }];
}

@end
