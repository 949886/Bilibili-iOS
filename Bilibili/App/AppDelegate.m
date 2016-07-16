//
//  AppDelegate.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/2.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "AppDelegate.h"

#import "LaunchAD.h"
#import "DeviceManager.h"
#import "NetworkManager.h"

#import "BilibiliAPI.h"
#import "BilibiliDanmakuParser.h"

#import "YYKit.h"
#import "YYFPSLabel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.rootViewController = [DeviceManager instance].rootViewController;
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    
    
    [[NetworkManager instance] activate];   //开始监控网络
    [LaunchAD show];                        //显示广告，无则显示2233的bilibili干杯动画
    
//    [BilibiliAPI getBangumiHomepageDataWithDevice:0 success:nil failure:nil];
//    [BilibiliDanmakuParser parse];
    
#if DEBUG
    YYFPSLabel *fps = [YYFPSLabel new];
    fps.left = 25;
    fps.bottom = _window.bottom - 75;
    [_window addSubview:fps];
#endif
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

@end



