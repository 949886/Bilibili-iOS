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

#import "HomeViewController.h"
#import "CategoriesViewController.h"
#import "AttentionViewController.h"
#import "DiscoverViewController.h"
#import "ProfileViewController.h"

#import "RootNavigationController.h"

#define ROOT @"RootViewController"
#define Image(NAME) [UIImage imageNamed:NAME]

@import YYKit;

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CustomTabBar * tabBar = [CustomTabBar new];
    
    if (IS_IPAD)
    {
        [tabBar setTabAtIndex:0 normalImage:Image(@"hd_home_home_tab") highlightedImage:Image(@"hd_home_home_tab_s")];
        [tabBar setTabAtIndex:1 normalImage:Image(@"hd_home_attention_tab") highlightedImage:Image(@"hd_home_attention_tab_s")];
        [tabBar setTabAtIndex:2 normalImage:Image(@"hd_home_search_tab") highlightedImage:Image(@"hd_home_search_tab_s")];
        [tabBar setTabAtIndex:3 normalImage:Image(@"hd_home_mine_tab") highlightedImage:Image(@"hd_home_mine_tab_s")];
    }
    
    if (IS_IPHONE)
    {
        [tabBar setTabAtIndex:0 normalImage:Image(@"home_home_tab") highlightedImage:Image(@"home_home_tab_s")];
        [tabBar setTabAtIndex:1 normalImage:Image(@"home_category_tab") highlightedImage:Image(@"home_category_tab_s")];
        [tabBar setTabAtIndex:2 normalImage:Image(@"home_attention_tab") highlightedImage:Image(@"home_attention_tab_s")];
        [tabBar setTabAtIndex:3 normalImage:Image(@"home_discovery_tab") highlightedImage:Image(@"home_discovery_tab_s")];
        [tabBar setTabAtIndex:4 normalImage:Image(@"home_mine_tab") highlightedImage:Image(@"home_mine_tab_s")];
        
        HomeViewController * home = [[HomeViewController alloc] initWithNibName:ROOT bundle:nil];
        CategoriesViewController * categories = [[CategoriesViewController alloc] initWithNibName:ROOT bundle:nil];
        AttentionViewController * attention = [[AttentionViewController alloc] initWithNibName:ROOT bundle:nil];
        DiscoverViewController * discover = [[DiscoverViewController alloc] initWithNibName:ROOT bundle:nil];
        ProfileViewController * profile = [[ProfileViewController alloc] initWithNibName:ROOT bundle:nil];
        
        UINavigationController * homeNav = [[RootNavigationController alloc] initWithRootViewController:home];
        UINavigationController * categoriesNav = [[RootNavigationController alloc] initWithRootViewController:categories];
        UINavigationController * attentionNav = [[RootNavigationController alloc] initWithRootViewController:attention];
        UINavigationController * discoverNav = [[RootNavigationController alloc] initWithRootViewController:discover];
        UINavigationController * profileNav = [[RootNavigationController alloc] initWithRootViewController:profile];
        
        NSArray * viewControllers = @[homeNav, categoriesNav, attentionNav, discoverNav, profileNav];
        [self setViewControllers:viewControllers];
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
