//
//  TabsController.h
//  Bilibili
//
//  Created by LunarEclipse on 16/9/7.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RootViewController.h"

#import "SegmentedControl.h"


@interface TabsController : RootViewController

@property (nonatomic, copy) NSArray<UIViewController *> * viewControllers;
@property (nonatomic, copy) NSArray<NSString *> * tabs;

@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) SegmentedControl * segmentedControl;

@end
