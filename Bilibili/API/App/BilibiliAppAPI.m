//
//  BilibiliAppAPI.m
//  Bilibili
//
//  Created by LunarEclipse on 16/8/27.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "BilibiliAppAPI.h"

#import "BilibiliRequest.h"
#import "URLConstants.h"
#import "Auth.h"

@implementation BilibiliAppAPI

//[API]http://live.bilibili.com/AppIndex/home?device=phone&platform=ios&scale=2
+(void)getLiveHomeWithSuccess:(SuccessBlock(LiveHomeModel))success
                      failure:(FailureBlock)failure
{
    NSDictionary * parameters = @{@"device" : @"phone",
                                  @"platform" : @"ios",
                                  @"scale" : @2};
    
    [BilibiliRequest GET:BILIBILI_LIVE_HOME parameters:parameters clazz:[LiveHomeModel class] progress:nil success:success failure:failure];
}

//[API.iPhone] http://app.bilibili.com/x/v2/show?build=3430
//[API.iPad]   https://app.bilibili.com/x/show?plat=2
+(void)getRecommendHomeWithDevice:(NSInteger)option  //0 is iPhone, 1 is iPad
                          success:(SuccessBlock(NSArray<RecommendSegment *>))success
                          failure:(FailureBlock)failure
{
    NSDictionary * parameters = option ? @{@"plat" : @2} : @{@"build" : @3430};
    NSString * url = option ? BILIBILI_IPAD_RECOMMEND_HOME : BILIBILI_IPHONE_RECOMMEND_HOME;
    [BilibiliRequest GET:url parameters:parameters clazz:[RecommendSegment class] progress:nil success:success failure:failure];
}

//[API.iPhone]http://bangumi.bilibili.com/api/app_index_page_v4?device=phone
//[API.iPad]http://bangumi.bilibili.com/api/app_index_page
+(void)getBangumiHomeWithDevice:(NSInteger)option
                        success:(SuccessBlock(BangumiHomeModel))success
                        failure:(FailureBlock)failure
{
    NSDictionary * parameters = @{@"device" : @"phone"};
    NSString * url = option ? BILIBILI_IPAD_BANGUMI_HOME : BILIBILI_IPHONE_BANGUMI_HOME;
    [BilibiliRequest GET:url parameters:parameters clazz:[BangumiHomeModel class] progress:nil success:success failure:failure];
}

//[API]http://bangumi.bilibili.com/api/bangumi_recommend?appkey=c1b107428d337928&build=3710&cursor=1472724000279&device=phone&pagesize=10&platform=ios&sign=2faeb1b2f0385cd74a66742196ce024e
+(void)getBangumiRecommendWithCursor:(u_int64_t)cursor
                            pageSize:(NSInteger)pageSize
                             success:(SuccessBlock(NSArray<BangumiRecommendModel *>))success
                             failure:(FailureBlock)failure
{
    NSMutableDictionary * parameters = @{@"appkey" : APP_KEY,
                                  @"build" : @(3710),
                                  @"cursor" : @(cursor),
                                  @"device" : @"phone",
                                  @"pagesize" : @(pageSize),
                                  @"platform" : PLATFORM}.mutableCopy;
    parameters[@"sign"] = [Auth generateSign:parameters];
    
    [BilibiliRequest GET:BILIBILI_IPHONE_BANGUMI_RECOMMEND parameters:parameters clazz:[BangumiRecommendModel class] progress:nil success:success failure:failure];
}

//+(void)getRecommendationHomepageBannerWithSuccess:(void(^ _Nullable)(NSArray<BannerModel *> * _Nullable))success failure:(void(^ _Nullable)(void))failure
//{
//    NSDictionary * parameters = @{@"screen" : @"xxhdpi",
//                                  @"build" : @"402003",};
//    
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    [manager GET:BILIBILI_BANNER parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSArray * results = responseObject[@"list"];
//        
//        NSMutableArray<BannerModel *> * banners = [NSMutableArray array];
//        for (NSDictionary * dict in results) {
//            BannerModel * banner = [BannerModel modelWithDictionary:dict];
//            if(banner) [banners addObject:banner];
//        }
//        
//        IfSuccess(banners);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@", error);
//        if(failure) failure();
//    }];
//}


@end
