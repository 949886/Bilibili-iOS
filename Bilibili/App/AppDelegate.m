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
#import "BilibiliDanmakuParser.h"

#import "Downloader.h"

#import "YYFPSLabel.h"

@import YYKit;
@import SDWebImage;
@import AFNetworking;

void handleException(NSException * exception);

@interface AppDelegate () <NSURLSessionDataDelegate>

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
    [LaunchAD show];                        //显示广告，无则显示2233的bilibili干杯动画
    
    
    //Setup FPS Monitor
    
#ifdef DEBUG
    YYFPSLabel *fps = [YYFPSLabel new];
    fps.left = 25;
    fps.bottom = _window.bottom - 75;
    [_window addSubview:fps];
#endif
    
    //Setup Exception Handler
    NSSetUncaughtExceptionHandler(handleException);
    
//    [BilibiliVideoAPI getVideoURLWithAID:5976369 page:1 quality:VideoQuarityLow success:^(NSString * url) {
//        [[Downloader downloader] download:url progress:nil success:nil failure:nil];
//    } failure:^{
//        
//    }];

    return YES;
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest * __nullable))completionHandler
{
    NSString * redirectedURL = response.allHeaderFields[@"Location"];
    NSLog(@"%@", redirectedURL);
    completionHandler(task.currentRequest);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSHTTPURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler;
{
    //传入NSURLSessionResponceAllow:允许连接 NSURLSessionResponceCancel:拒绝
    NSLog(@"%@", @"aaaaaaaaaaaaaaaaa");
    completionHandler(NSURLSessionResponseAllow);
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
    [exception name];
    [exception reason];
    [exception callStackSymbols];
}
