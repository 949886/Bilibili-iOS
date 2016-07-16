//
//  DeviceOrientation.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/4.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "DeviceOrientation.h"
#import "DeviceManager.h"

@implementation UIViewController (Orientation)

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [DeviceManager instance].supportedOrientations;
}

@end
