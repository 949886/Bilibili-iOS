//
//  BilibiliAPI.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/2.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "BilibiliAPI.h"

#import "APPConstants.h"
#import "URLConstants.h"

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

#pragma mark - API

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@import YYKit;
@import AFNetworking;

@implementation BilibiliAPI

+ (id)forwardingTargetForSelector:(SEL)aSelector
{
    if ([[BilibiliVideoAPI class] respondsToSelector:aSelector])
        return [BilibiliVideoAPI class];
    if ([[BilibiliUserAPI class] respondsToSelector:aSelector])
        return [BilibiliUserAPI class];
    return nil;
}

#pragma mark GET

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
                                  @"ts" : LIVE_TS};
    
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
                     success:(void(^ _Nullable)(RecommendationHomeModel * _Nullable))success
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
                                         @"ts" : TS}.mutableCopy;
    if (0 == option) parameters[@"warm"] = @1;
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        RecommendationHomeModel * result = [RecommendationHomeModel modelWithDictionary:responseObject];
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
                                         @"ts" : TS}.mutableCopy;
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

#pragma mark POST

+(void)commentVideo:(NSString * _Nonnull)ID content:(NSString * _Nonnull)text
            success:(void (^ _Nullable)(BilibiliResult * _Nullable))success
            failure:(void (^ _Nullable)(void))failure
{
    NSDictionary * parameters = @{@"_device" : @"ios",
                                  @"_hwid" : @"4d70e86e50b6bfe8",
                                  @"_ulv" : @"10000",
                                  @"access_key" : ACCESS_KEY,
                                  @"appkey" : APP_KEY,
                                  @"appver" : @"101220",
                                  @"message" : text,
                                  @"oid" : ID,
                                  @"plat" : @"5",
                                  @"platform" : PLATFORM,
                                  @"sign" : SIGN,
                                  @"type" : @"1"};
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager POST:BILIBILI_ADD_REPLY parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BilibiliResult * result = [BilibiliResult modelWithDictionary:responseObject];
        IfSuccess(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        if(failure) failure();
    }];
}



+(void)addFavoriteVideo:(NSString * _Nonnull)ID
                 success:(void(^ _Nullable)(BilibiliResult * _Nullable))success
                 failure:(void(^ _Nullable)(void))failure
{
    NSDictionary * parameters = @{@"_device" : @"ios",
                                  @"_hwid" : @"4d70e86e50b6bfe8",
                                  @"_ulv" : @"10000",
                                  @"access_key" : ACCESS_KEY,
                                  @"appkey" : APP_KEY,
                                  @"appver" : @"3430",
                                  @"build" : @"3430",
                                  @"aid" : ID,
                                  @"platform" : PLATFORM,
                                  @"sign" : SIGN,
                                  @"type" : @"json"};
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager POST:BILIBILI_ADD_FAVOURIATE_VIDEO parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BilibiliResult * result = [BilibiliResult modelWithDictionary:responseObject];;
        if(result.data.favoured) NSLog(@"[BilibiliAPI.addFavoriteVideo]已经收藏过了");
        
        IfSuccess(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        if(failure) failure();
    }];
}

+(void)deleteFavoriteVideo:(NSString * _Nonnull)ID
                 success:(void(^ _Nullable)(BilibiliResult * _Nullable))success
                 failure:(void(^ _Nullable)(void))failure
{
    NSDictionary * parameters = @{@"_device" : @"ios",
                                  @"_hwid" : @"4d70e86e50b6bfe8",
                                  @"_ulv" : @"10000",
                                  @"access_key" : ACCESS_KEY,
                                  @"appkey" : APP_KEY,
                                  @"appver" : @"3430",
                                  @"build" : @"3430",
                                  @"aid" : ID,
                                  @"platform" : PLATFORM,
                                  @"sign" : SIGN,
                                  @"type" : @"json"};
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager POST:BILIBILI_DELETE_FAVOURIATE_VIDEO parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BilibiliResult * result = [BilibiliResult modelWithDictionary:responseObject];
        if(!result.data.favoured) NSLog(@"[BilibiliAPI.addFavoriteVideo]还未收藏");
        IfSuccess(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        if(failure) failure();
    }];
}

@end
#pragma clang diagnostic pop



#pragma mark - Feedback

@implementation BilibiliResult : NSObject

@end

@implementation BilibiliData

@end
