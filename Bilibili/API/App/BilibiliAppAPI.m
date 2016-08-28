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
+(void)getRecommendHomeWithDevice:(NSInteger)option
                          success:(SuccessBlock(NSArray<RecommendationSegment *>))success
                          failure:(FailureBlock)failure
{
    NSDictionary * parameters = option ? @{@"plat" : @2} : @{@"build" : @3430};
    NSString * url = option ? BILIBILI_IPAD_RECOMMEND_HOME : BILIBILI_IPHONE_RECOMMEND_HOME;
    [BilibiliRequest GET:url parameters:parameters clazz:[RecommendationSegment class] progress:nil success:success failure:failure];
}

//[API.iPhone]http://bangumi.bilibili.com/api/app_index_page_v3
//[API.iPad]http://bangumi.bilibili.com/api/app_index_page
+(void)getBangumiHomeWithDevice:(NSInteger)option
                        success:(SuccessBlock(BangumiHomeModel))success
                        failure:(FailureBlock)failure
{
    NSString * url = option ? BILIBILI_IPAD_BANGUMI_HOME : BILIBILI_IPHONE_BANGUMI_HOME;
    [BilibiliRequest GET:url parameters:nil clazz:[BangumiHomeModel class] progress:nil success:success failure:failure];
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
