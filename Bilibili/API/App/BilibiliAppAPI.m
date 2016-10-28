//
//  BilibiliAppAPI.m
//  Bilibili
//
//  Created by LunarEclipse on 16/8/27.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "BilibiliAppAPI.h"

#import "BilibiliRequest.h"
#import "BilibiliURL.h"
#import "BilibiliAuth.h"

@implementation BilibiliAppAPI

//[GET]http://live.bilibili.com/AppIndex/home?device=phone&platform=ios&scale=2
+(void)getLiveHomeWithSuccess:(SuccessBlock(LiveHomeModel))success
                      failure:(FailureBlock)failure
{
    NSDictionary * parameters = @{@"device" : DEVICE,
                                  @"platform" : PLATFORM,
                                  @"scale" : @2};
    
    [BilibiliRequest GET:BILIBILI_LIVE_HOME parameters:parameters clazz:[LiveHomeModel class] progress:nil success:success failure:failure];
}

//[GET]http://live.bilibili.com/AppRoom/index?platform=ios&room_id=34756
+(void)getLiveRoomIndexWithRoomID:(NSInteger)roomID
                          success:(SuccessBlock(LiveRoomModel))success
                          failure:(FailureBlock)failure;
{
    NSDictionary * parameters = @{@"device" : DEVICE,
                                  @"platform" : PLATFORM,
                                  @"room_id" : @(roomID),
                                  @"scale" : @2};
    
    [BilibiliRequest GET:BILIBILI_LIVE_ROOM_INDEX parameters:parameters clazz:[LiveRoomModel class] progress:nil success:success failure:failure];
}

+(void)getLiveRoomMessagesWithRoomID:(NSInteger)roomID
                             success:(SuccessBlock(LiveMessagesModel))success
                             failure:(FailureBlock)failure
{
    NSMutableDictionary * parameters = @{@"actionKey" : @"appkey",
                                         @"appkey" : APP_KEY,
                                         @"build" : @(3940),
                                         @"device" : DEVICE,
                                         @"mobi_app" : MOBI_APP,
                                         @"platform" : PLATFORM,
                                         @"room_id" : @(roomID),
                                         @"ts" : TS}.mutableCopy;
    parameters[@"sign"] = [BilibiliAuth generateSign:parameters];
    [BilibiliRequest GET:BILIBILI_LIVE_ROOM_MESSAGE parameters:parameters clazz:[LiveMessagesModel class] progress:nil success:success failure:failure];
}

//[GET.iPhone] http://app.bilibili.com/x/v2/show?build=3430
//[GET.iPad]   https://app.bilibili.com/x/show?plat=2
+(void)getRecommendHomeWithDevice:(NSInteger)option  //0 is iPhone, 1 is iPad
                          success:(SuccessBlock(NSArray<RecommendSegment *>))success
                          failure:(FailureBlock)failure
{
    NSDictionary * parameters = option ? @{@"plat" : @2} : @{@"build" : @3430};
    NSString * url = option ? BILIBILI_IPAD_RECOMMEND_HOME : BILIBILI_IPHONE_RECOMMEND_HOME;
    [BilibiliRequest GET:url parameters:parameters clazz:[RecommendSegment class] progress:nil success:success failure:failure];
}

//[GET.iPhone]http://bangumi.bilibili.com/api/app_index_page_v4?device=phone
//[GET.iPad]http://bangumi.bilibili.com/api/app_index_page
+(void)getBangumiHomeWithDevice:(NSInteger)option
                        success:(SuccessBlock(BangumiHomeModel))success
                        failure:(FailureBlock)failure
{
    NSDictionary * parameters = @{@"device" : @"phone"};
    NSString * url = option ? BILIBILI_IPAD_BANGUMI_HOME : BILIBILI_IPHONE_BANGUMI_HOME;
    [BilibiliRequest GET:url parameters:parameters clazz:[BangumiHomeModel class] progress:nil success:success failure:failure];
}

//[GET]http://bangumi.bilibili.com/api/bangumi_recommend?appkey=c1b107428d337928&build=3710&cursor=1472724000279&device=phone&pagesize=10&platform=ios&sign=2faeb1b2f0385cd74a66742196ce024e
+(void)getBangumiRecommendWithCursor:(u_int64_t)cursor
                            pageSize:(NSInteger)pageSize
                             success:(SuccessBlock(NSArray<BangumiRecommendModel *>))success
                             failure:(FailureBlock)failure
{
    NSMutableDictionary * parameters = @{@"appkey" : APP_KEY,
                                  @"build" : @(3710),
                                  @"cursor" : @(cursor),
                                  @"device" : DEVICE,
                                  @"pagesize" : @(pageSize),
                                  @"platform" : PLATFORM}.mutableCopy;
    parameters[@"sign"] = [BilibiliAuth generateSign:parameters];
    
    [BilibiliRequest GET:BILIBILI_IPHONE_BANGUMI_RECOMMEND parameters:parameters clazz:[BangumiRecommendModel class] progress:nil success:success failure:failure];
}

//[GET]http://bangumi.bilibili.com/api/season_v4?actionKey=appkey&appkey=xxx&build=3910&device=phone&mobi_app=iphone&platform=ios&season_id=5070&sign=xxx&ts=1476875934&type=bangumi
+(void)getBangumiInfoWithSid:(NSInteger)seasonID
                     success:(SuccessBlock(BangumiModel))success
                     failure:(FailureBlock)failure
{
    NSMutableDictionary * parameters = @{@"actionKey" : @"appkey",
                                         @"appkey" : APP_KEY,
                                         @"build" : @(3910),
                                         @"device" : DEVICE,
                                         @"mobi_app" : MOBI_APP,
                                         @"platform" : PLATFORM,
                                         @"season_id" : @(seasonID),
                                         @"ts" : TS,
                                         @"type" : @"bangumi"}.mutableCopy;
    parameters[@"sign"] = [BilibiliAuth generateSign:parameters];
    [BilibiliRequest GET:BILIBILI_IPHONE_BANGUMI_INFO parameters:parameters clazz:[BangumiModel class] progress:nil success:success failure:failure];
}

//[GET]http://bangumi.bilibili.com/api/season/recommend/5532.json?season_id=5532
+(void)getRelativeBangumisWithSid:(NSInteger)seasonID
                          success:(SuccessBlock(RelativeBangumisModel))success
                          failure:(FailureBlock)failure
{
    NSString * url = [NSString stringWithFormat:BILIBILI_IPHONE_BANGUMI_RELATIVE, @(seasonID)];
    [BilibiliRequest GET:url parameters:nil clazz:[RelativeBangumisModel class] progress:nil success:success failure:failure];
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
