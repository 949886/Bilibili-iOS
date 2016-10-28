//
//  BilibiliAPI.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/2.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "BilibiliAPI.h"

#import "BilibiliURL.h"

#import "BilibiliAppAPI.h"
#import "BilibiliUserAPI.h"
#import "BilibiliVideoAPI.h"

//Execute callback block
#define IfSuccess(_result_) \
int integer_code = [responseObject[@"code"] intValue]; \
NSString * string_message = (NSString *)responseObject[@"message"]; \
if (integer_code != 0) { \
    NSLog(@"Request failed, code=%d, message=\"%@\"", integer_code, string_message); \
    if(failure) failure(); \
} \
else {if(success) success(_result_);}

#define PLATFORM  @"ios"
#define DEVICE ([[UIDevice currentDevice].model isEqualToString:@"iPad"] ? @"pad" : @"phone")

/* TEST */

#define APP_KEY @"86385cdc024c0f6c"
#define ACCESS_KEY @"bb414b00fc0465fdd879e3ac09f80be8"
#define SIGN @"6e459ab22503751d6083cca0e712474b"

#define LIVE_APP_KEY @"27eb53fc9058f8c3"
#define LIVE_ACCESS_KEY @"99d02371222f07c14779faf9193c7bdf"
#define LIVE_SIGN @"54b5fe76ce29f5f4052941a61a158a21"

#pragma mark - API

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@import YYKit;
@import AFNetworking;

@implementation BilibiliAPI

+ (id)forwardingTargetForSelector:(SEL)aSelector
{
    if ([[BilibiliAppAPI class] respondsToSelector:aSelector])
        return [BilibiliAppAPI class];
    if ([[BilibiliUserAPI class] respondsToSelector:aSelector])
        return [BilibiliUserAPI class];
    if ([[BilibiliVideoAPI class] respondsToSelector:aSelector])
        return [BilibiliVideoAPI class];
    return nil;
}

#pragma mark DEPRECATED

/* 应用数据 */

+(void)getLiveHomepageDataWithSuccess:(void(^ _Nullable)(LiveHomeModel * _Nullable))success failure:(void(^ _Nullable)(void))failure
{
    NSDictionary * parameters = @{@"access_key" : LIVE_ACCESS_KEY,
                                  @"appkey" : LIVE_APP_KEY,
                                  @"actionKey" : @"appkey",
                                  @"build" : @"3430",
                                  @"device" : @"phone",
                                  @"mobi_app" : @"iphone",
                                  @"platform" : PLATFORM,
                                  @"scale" : @2,
                                  @"sign" : LIVE_SIGN,
                                  @"ts" : @1467671646};
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:BILIBILI_LIVE_HOME parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LiveHomeModel * liveHomeData = [LiveHomeModel modelWithDictionary:responseObject[@"data"]];
        IfSuccess(liveHomeData);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        if(failure) failure();
    }];
}


+(void)getRecommendationHomepageDataWithDevice:(NSInteger)option
                     success:(void(^ _Nullable)(RecommendHomeModel * _Nullable))success
                     failure:(void(^ _Nullable)(void))failure
{
    NSString * url = option ? BILIBILI_IPAD_RECOMMEND_HOME : BILIBILI_IPHONE_RECOMMEND_HOME;
    NSMutableDictionary * parameters = @{@"access_key" : ACCESS_KEY,
                                         @"appkey" : APP_KEY,
                                         @"actionKey" : @"appkey",
                                         @"build" : @"3430",
                                         @"channel" : @"appstore",
                                         @"device" : DEVICE,
                                         @"mobi_app" : @"iphone",
                                         @"platform" : PLATFORM,
                                         @"plat" : [NSNumber numberWithInteger:option + 1],
                                         @"sign" : SIGN,
                                         @"ts" : @1467671646}.mutableCopy;
    if (0 == option) parameters[@"warm"] = @1;
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        RecommendHomeModel * result = [RecommendHomeModel modelWithDictionary:responseObject];
        if (0 == option)
        {
            IfSuccess(result);
        }

        //若为iPad，额外加载Banner数据
        if (1 == option)
        {
            [self getRecommendationHomepageBannerWithSuccess:^(NSArray<BannerModel *> * banners) {
                result.banners = banners;
                IfSuccess(result);
            } failure:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        if(failure) failure();
    }];

}

+(void)getRecommendationHomepageBannerWithSuccess:(void(^ _Nullable)(NSArray<BannerModel *> * _Nullable))success failure:(void(^ _Nullable)(void))failure
{
    NSDictionary * parameters = @{@"screen" : @"xxhdpi",
                                  @"build" : @"402003",};
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:BILIBILI_BANNER parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray * results = responseObject[@"list"];
        
        NSMutableArray<BannerModel *> * banners = [NSMutableArray array];
        for (NSDictionary * dict in results) {
            BannerModel * banner = [BannerModel modelWithDictionary:dict];
            if(banner) [banners addObject:banner];
        }
        
        IfSuccess(banners);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        if(failure) failure();
    }];
}

+(void)getBangumiHomepageDataWithDevice:(NSInteger)option //0 is iPhone, 1 is iPad
                                success:(void(^ _Nullable)(BangumiHomeModel * _Nullable))success
                                failure:(void(^ _Nullable)(void))failure
{
    NSString * url = option ? BILIBILI_IPAD_BANGUMI_HOME : BILIBILI_IPHONE_BANGUMI_HOME;
    NSMutableDictionary * parameters = @{@"appkey" : APP_KEY,
                                         @"actionKey" : @"appkey",
                                         @"build" : @"101220",
                                         @"device" : DEVICE,
                                         @"mobi_app" : @"iphone",
                                         @"platform" : PLATFORM,
                                         @"sign" : SIGN,
                                         @"ts" : @1467671646}.mutableCopy;
    if (0 == option){
        parameters[@"access_key"] = ACCESS_KEY;
        parameters[@"build"] = @"3430";
    }
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BangumiHomeModel * result = [BangumiHomeModel modelWithDictionary:responseObject[@"result"]];
        IfSuccess(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        if(failure) failure();
    }];
}

@end

#pragma clang diagnostic pop



#pragma mark - Feedback(DEPRECATED)

@implementation BilibiliResult : NSObject

@end

@implementation BilibiliData

@end
