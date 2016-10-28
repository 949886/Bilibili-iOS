//
//  DeviceManager.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/4.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "DeviceManager.h"

#define IPAD_STORYBOARD @"iPad"
#define IPHONE_STORYBOARD @"iPhone"

@implementation DeviceManager

- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}

+ (instancetype)instance
{
    static DeviceManager *  _instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

/* 根据设备选择加载的Storyboard, 并返回其根控制器 */
-(UIViewController *)rootViewController
{
    UIViewController * viewController;
    UIStoryboard * mainStoryboard;
    
    NSString * deviceName = [UIDevice currentDevice].model;
    if ([deviceName isEqualToString:@"iPad"])
        mainStoryboard = [UIStoryboard storyboardWithName:IPAD_STORYBOARD bundle:nil];
    else mainStoryboard = [UIStoryboard storyboardWithName:IPHONE_STORYBOARD bundle:nil];
    
    viewController = [mainStoryboard instantiateInitialViewController];
    return viewController;
}

-(UIInterfaceOrientationMask)defaultOrientation
{
    NSString * deviceName = [UIDevice currentDevice].model;
    if ([deviceName isEqualToString:@"iPad"])
    {
        if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation))
            return UIInterfaceOrientationMaskLandscapeLeft;
        return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
    }
    else return UIInterfaceOrientationMaskPortrait;
//    else return UIInterfaceOrientationMaskAllButUpsideDown;
}

@end
