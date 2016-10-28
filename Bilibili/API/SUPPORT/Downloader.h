//
//  Downloader.h
//  Bilibili
//
//  Created by LunarEclipse on 16/8/23.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ _Nullable DownloadProgressBlock)(NSProgress * _Nonnull progress);
typedef void (^ _Nullable DownloadSuccessBlock)(NSURLSessionDataTask * _Nonnull response, NSURL * _Nonnull url);
typedef void (^ _Nullable DownloadFailureBlock)(NSURLSessionDataTask * _Nonnull response, NSError * _Nonnull error);

@interface Downloader : NSObject <NSURLSessionDataDelegate>

+ (instancetype _Nonnull)downloader;

- (void)download:(NSString * _Nonnull)urlString
             tag:(NSString * _Nonnull)tag
        progress:(DownloadProgressBlock)progress
         success:(DownloadSuccessBlock)success
         failure:(DownloadFailureBlock)failure;

- (void)resume;
- (void)suspend;

@end
