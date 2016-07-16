//
//  UIScreenExtension.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/5.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "UIScreenExtension.h"

@implementation UIScreen (Extension)

-(CGRect)fixedBounds
{
    CGSize screenSize = [self fixedScreenSize];
    return CGRectMake(0, 0, screenSize.width, screenSize.height);
}

-(CGSize)fixedScreenSize
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if ([UIDevice currentDevice].systemVersion.doubleValue < 8 &&
        UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation))
        return CGSizeMake(screenSize.height, screenSize.width);
    return screenSize;
}

@end
