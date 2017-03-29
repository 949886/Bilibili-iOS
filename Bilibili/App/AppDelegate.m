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
#import "BilibiliVideoAPI.h"

#import "Downloader.h"

#import "YYFPSLabel.h"

@import YYKit;
@import JSPatch;
@import SDWebImage;

void handleException(NSException * exception);

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark Delegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Setup Key-window.
    _window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.rootViewController = [DeviceManager instance].rootViewController;
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    
    //Setup Network Mornitor
    [[NetworkManager instance] activate];   //开始监控网络
    
    //显示广告，无则显示2233的bilibili干杯动画
    [LaunchAD show];
    
    //Setup JSPatch Engine
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [JPEngine startEngine];
        NSArray * array = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"JS" ofType:@"plist"]];
        for (NSString * js in array)
        {
            NSString *sourcePath = [[NSBundle mainBundle] pathForResource:js ofType:nil];
            NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
            [JPEngine evaluateScript:script];
        }
    });
    
    //Setup FPS Monitor
#ifdef DEBUG
    YYFPSLabel *fps = [YYFPSLabel new];
    fps.left = 25;
    fps.bottom = _window.bottom - 75;
    [_window addSubview:fps];
#endif
    
    //Setup Exception Handler
    NSSetUncaughtExceptionHandler(handleException);
    
#ifdef DEBUG
    NSLog(@"%@", [NSBundle mainBundle].bundlePath);
#endif
    
    return YES;
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error
{
    
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

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    //SDWebImage Setting.
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return NO;
}

@end


void handleException(NSException * exception)
{
//    [exception name];
//    [exception reason];
//    [exception callStackSymbols];
}
