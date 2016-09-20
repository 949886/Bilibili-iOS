//
//  BilibiliVideoAPI.m
//  Bilibili
//
//  Created by LunarEclipse on 16/8/23.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "BilibiliVideoAPI.h"

#import "URLConstants.h"
#import "Auth.h"

@import YYKit;
@import AFNetworking;

@implementation BilibiliVideoAPI

//[API]http://app.bilibili.com/x/v2/view?aid=6024746&appkey=c1b107428d337928&build=3600&device=phone&mobi_app=iphone&platform=ios&ts=1472409128&sign=fe95c6be47d5ccddfd8d0cfcdbd05779
+(void)getVideoInfoWithAID:(NSInteger)aid
                   success:(SuccessBlock(VideoModel))success
                   failure:(FailureBlock)failure;
{
    NSMutableDictionary * parameters = @{@"aid" : @(aid),
                                         @"appkey" : APP_KEY,
                                         @"build" : @(3600),
                                         @"device" : @"phone",
                                         @"mobi_app" : @"iphone",
                                         @"platform" : PLATFORM}.mutableCopy;
    parameters[@"sign"] = [Auth generateSign:parameters];
    
    [BilibiliRequest GET:BILIBILI_VIDEO_INFO parameters:parameters clazz:[VideoModel class] progress:nil success:success failure:failure];
}

+(void)getAVInfoWithAID:(NSInteger)aid
                success:(void(^ _Nullable)(JJAVModel * _Nullable video))success
                failure:(void(^ _Nullable)(void))failure
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    
    NSString * url = [NSString stringWithFormat:@"%@%ld", BILIBILIJJ_AV2CID, (long)aid];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * task, id responseObject) {
        JJAVModel * videoModel = [JJAVModel modelWithDictionary:responseObject];
        if (videoModel.code == 0 && success)
            success(videoModel);
        else if(failure) failure();
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
#ifdef DEBUG
        if (error) NSLog(@"%@", error);
#endif
    }];
}

+(void)getVideoURLWithAID:(NSInteger)aid
                     page:(NSInteger)page
                  quality:(VideoQuarityOptions)quality
                  success:(void(^ _Nullable)(NSString * _Nullable url))success
                  failure:(void(^ _Nullable)(void))failure
{
    switch (quality)
    {
        case VideoQuarityLow:
            [self getLowQualityVideoURLWithAID:aid page:page success:success failure:failure];
            break;
        case VideoQuarityNormal:
            [self getNormalQualityVideoURLWithAID:aid page:page success:success failure:failure];
            break;
        default: break;
    }
}

+ (void)getLowQualityVideoURLWithAID:(NSInteger)aid
                                page:(NSInteger)page
                             success:(void(^ _Nullable)(NSString * _Nullable url))success
                             failure:(void(^ _Nullable)(void))failure
{
    NSDictionary * parameters = @{@"aid" : @(aid),
                                  @"page" : @(page)};
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:BILIBILI_VIDEO_PLAYURL_M parameters:parameters progress:nil success:^(NSURLSessionDataTask * task, id responseObject) {
        MPlayURLModel * mplayurl = [MPlayURLModel modelWithDictionary:responseObject];
        if(mplayurl.code != 0);
        else if(success) success(mplayurl.src);
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        if(failure) failure();
    }];
}

+ (void)getNormalQualityVideoURLWithAID:(NSInteger)aid
                                   page:(NSInteger)page
                                success:(void(^ _Nullable)(NSString * _Nullable url))success
                                failure:(void(^ _Nullable)(void))failure
{
    [self getAVInfoWithAID:aid success:^(JJAVModel * video) {
        //Get unredirected url
        NSString * jjurl = nil;
        if ((page - 1) < video.list.count)
            jjurl = video.list[page - 1].mp4Url;
        
        //Redirect to real playurl.
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        [manager HEAD:jjurl parameters:nil success:^(NSURLSessionDataTask * task) {
            if(success) success(task.currentRequest.URL.absoluteString);
        } failure:^(NSURLSessionDataTask * task, NSError * error) {
            if (failure) failure();
        }];
        
    } failure:failure];
}

@end
