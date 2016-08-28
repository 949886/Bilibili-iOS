//
//  BilibiliAPI.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/2.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "models.h"
#import "BilibiliResponse.h"


@class BilibiliResult;

@interface BilibiliAPI : NSObject

#pragma mark - GET

/* 数据接口 */

#pragma mark User

+(void)getUserWithID:(NSString * _Nonnull)uid
             success:(SuccessBlock(UserModel))success
             failure:(FailureBlock)failure;

+(void)getUserWithName:(NSString * _Nonnull)name
               success:(SuccessBlock(UserModel))success
               failure:(FailureBlock)failure;

#pragma mark Video

+(void)getVideoURLWithAID:(NSString * _Nonnull)aid  //page default is 1
                  success:(void(^ _Nullable)(NSString * _Nullable url))success
                  failure:(void(^ _Nullable)(void))failure;

+(void)getVideoURLWithAID:(NSString * _Nonnull)aid
                     page:(NSInteger)page   /* 分p，从1开始 */
                  success:(void(^ _Nullable)(NSString * _Nullable url))success
                  failure:(void(^ _Nullable)(void))failure;

+(void)getAVInfoWithAID:(NSString * _Nonnull)aid
                success:(void(^ _Nullable)(JJAVModel * _Nullable video))success
                failure:(void(^ _Nullable)(void))failure;

+(NSString * _Nonnull)getVideoURLWithAID:(int)aid page:(int)page;

#pragma mark Home

/* 应用首页数据 */

+(void)getLiveHomepageDataWithSuccess:(void(^ _Nullable)(LiveHomeModel * _Nullable))success failure:(void(^ _Nullable)(void))failure;
+(void)getRecommendationHomepageDataWithDevice:(NSInteger)option //0 is iPhone, 1 is iPad
                                       success:(void(^ _Nullable)(RecommendationHomeModel * _Nullable))success
                                       failure:(void(^ _Nullable)(void))failure;
+(void)getBangumiHomepageDataWithDevice:(NSInteger)option //0 is iPhone, 1 is iPad
                                success:(void(^ _Nullable)(BangumiHomeModel * _Nullable))success
                                failure:(void(^ _Nullable)(void))failure;


#pragma mark - POST

+(void)commentVideo:(NSString * _Nonnull)ID content:(NSString * _Nonnull)text
            success:(void (^ _Nullable)(BilibiliResult * _Nullable))success
            failure:(void (^ _Nullable)(void))failure;

+(void)addFavoriteVideo:(NSString * _Nonnull)ID
                success:(void(^ _Nullable)(BilibiliResult * _Nullable))success
                failure:(void(^ _Nullable)(void))failure;

+(void)deleteFavoriteVideo:(NSString * _Nonnull)ID
                   success:(void(^ _Nullable)(BilibiliResult * _Nullable))success
                   failure:(void(^ _Nullable)(void))failure;

@end


#pragma mark - Feedback

@class BilibiliData;

@interface BilibiliResult : NSObject

@property (nonatomic, assign) int code;
@property (nonatomic, strong, nullable) BilibiliData * data;

@end


@interface BilibiliData : NSObject

/*CommentVideo Feedback*/
@property (nonatomic, assign) BOOL need_captcha;
@property (nonatomic, copy, nullable) NSString * url;
@property (nonatomic, assign) NSInteger rpid;
@property (nonatomic, copy, nullable) NSString * rpid_str;

/*Add&DeleteFavoriteVideo Feedback*/
@property (nonatomic, assign) BOOL favoured;    //之前是否收藏

@end
