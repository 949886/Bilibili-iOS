//
//  TabBarController.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/7.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "TabBarController.h"
#import "CustomTabBar.h"
#import "extension.h"
#import "YYKit.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CustomTabBar * tabBar = [CustomTabBar new];
    
    if (IS_IPAD)
    {
        [tabBar setTabAtIndex:0 normalImage:[UIImage imageNamed:@"hd_home_home_tab"] highlightedImage:[UIImage imageNamed:@"hd_home_home_tab_s"]];
        [tabBar setTabAtIndex:1 normalImage:[UIImage imageNamed:@"hd_home_attention_tab"] highlightedImage:[UIImage imageNamed:@"hd_home_attention_tab_s"]];
        [tabBar setTabAtIndex:2 normalImage:[UIImage imageNamed:@"hd_home_search_tab"] highlightedImage:[UIImage imageNamed:@"hd_home_search_tab_s"]];
        [tabBar setTabAtIndex:3 normalImage:[UIImage imageNamed:@"hd_home_mine_tab"] highlightedImage:[UIImage imageNamed:@"hd_home_mine_tab_s"]];
    }
    
    if (IS_IPHONE)
    {
        [tabBar setTabAtIndex:0 normalImage:[UIImage imageNamed:@"home_home_tab"] highlightedImage:[UIImage imageNamed:@"home_home_tab_s"]];
        [tabBar setTabAtIndex:1 normalImage:[UIImage imageNamed:@"home_category_tab"] highlightedImage:[UIImage imageNamed:@"home_category_tab_s"]];
        [tabBar setTabAtIndex:2 normalImage:[UIImage imageNamed:@"home_attention_tab"] highlightedImage:[UIImage imageNamed:@"home_attention_tab_s"]];
        [tabBar setTabAtIndex:3 normalImage:[UIImage imageNamed:@"home_discovery_tab"] highlightedImage:[UIImage imageNamed:@"home_discovery_tab_s"]];
        [tabBar setTabAtIndex:4 normalImage:[UIImage imageNamed:@"home_mine_tab"] highlightedImage:[UIImage imageNamed:@"home_mine_tab_s"]];
    }
    
    [self setValue:tabBar forKey:@"tabBar"];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    if (IS_IPAD)
    {
        self.tabBar.height = 60;
        self.tabBar.bottom = self.view.bottom;
    }
}


@end
