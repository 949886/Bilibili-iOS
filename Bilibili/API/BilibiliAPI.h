//
//  BilibiliAPI.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/2.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "models.h"
#import "BilibiliEnumeration.h"
#import "BilibiliResponse.h"

@class BilibiliResult;

@interface BilibiliAPI : NSObject

#pragma mark - GET

/* 数据接口 */

#pragma mark User

+(void)getUserWithID:(NSInteger)uid
             success:(SuccessBlock(UserModel))success
             failure:(FailureBlock)failure;

//+(void)getUserWithName:(NSString * _Nonnull)name
//               success:(SuccessBlock(UserModel))success
//               failure:(FailureBlock)failure;

+(void)loginWithUsername:(NSString * _Nonnull)username
                password:(NSString * _Nonnull)password
                 success:(SuccessBlock(LoginResponse))success
                 failure:(FailureBlock)failure;

#pragma mark Video

+(void)getVideoInfoWithAID:(NSInteger)aid
                   success:(SuccessBlock(VideoModel))success
                   failure:(FailureBlock)failure;

/**
 *  获取视频播放url的接口
 *
 *  @param cid     视频cid
 *  @param vid     若需不限速必须传入此参数以及type，若视频为一般视频传av号，若为番剧传番剧号sid
 *  @param type    BilibiliVideoTypeNormal: 一般视频 BilibiliVideoTypeBangumi:番剧
 *  @param quality 清晰度
 */
+(void)getPlayURLWithCid:(NSInteger)cid
                     vid:(NSInteger)vid
               videoType:(BilibiliVideoType)type
                 quality:(VideoQuarityOptions)quality
                 success:(SuccessBlock(PlayURLModel))success
                 failure:(FailureBlock)failure;

+(void)getDanmakuWithCid:(NSInteger)cid
                 success:(void(^ _Nullable)(NSString * _Nullable xml))success
                 failure:(void(^ _Nullable)(void))failure;

+(void)getCommentsWithAid:(NSInteger)aid
                     page:(NSInteger)page
                 pageSize:(NSInteger)pageSize
                  success:(SuccessBlock(CommentsModel))success
                  failure:(FailureBlock)failure;


#pragma mark Home

/* 应用数据 */

+(void)getLiveHomeWithSuccess:(SuccessBlock(LiveHomeModel))success
                      failure:(FailureBlock)failure;

+(void)getLiveRoomIndexWithRoomID:(NSInteger)roomID
                          success:(SuccessBlock(LiveRoomModel))success
                          failure:(FailureBlock)failure;

+(void)getLiveRoomMessagesWithRoomID:(NSInteger)roomID
                             success:(SuccessBlock(LiveMessagesModel))success
                             failure:(FailureBlock)failure;

+(void)getRecommendHomeWithDevice:(NSInteger)option //0 is iPhone, 1 is iPad
                          success:(SuccessBlock(NSArray<RecommendSegment *>))success
                          failure:(FailureBlock)failure;

+(void)getBangumiHomeWithDevice:(NSInteger)option //0 is iPhone, 1 is iPad
                        success:(SuccessBlock(BangumiHomeModel))success
                        failure:(FailureBlock)failure;

+(void)getBangumiRecommendWithCursor:(u_int64_t)cursor
                            pageSize:(NSInteger)pageSize
                             success:(SuccessBlock(NSArray<BangumiRecommendModel *>))success
                             failure:(FailureBlock)failure;

+(void)getBangumiInfoWithSid:(NSInteger)seasonID
                     success:(SuccessBlock(BangumiModel))success
                     failure:(FailureBlock)failure;

+(void)getRelativeBangumisWithSid:(NSInteger)seasonID
                          success:(SuccessBlock(RelativeBangumisModel))success
                          failure:(FailureBlock)failure;

#pragma mark - POST

/* 以下POST方法需要登录，需要登录，需要登录 (重要的事情说三遍) */

+(void)commentVideo:(NSInteger)aid
            content:(NSString * _Nonnull)text
            success:(SuccessBlock)success
            failure:(FailureBlock)failure;

+(void)sendDanmaku:(NSString * _Nonnull)text
          videoCid:(NSInteger)cid
              time:(NSTimeInterval)time
              type:(NSUInteger)type
          fontSize:(NSUInteger)fontSize
          hexColor:(NSUInteger)hexColor
           success:(SuccessBlock)success
           failure:(FailureBlock)failure;

+(void)addFavoriteVideo:(NSInteger)aid
                success:(SuccessBlock)success
                failure:(FailureBlock)failure;

+(void)deleteFavoriteVideo:(NSInteger)aid
                   success:(SuccessBlock)success
                   failure:(FailureBlock)failure;


#pragma mark - BILIBILIJJ

+(void)getAVInfoWithAID:(NSInteger)aid
                success:(void(^ _Nullable)(JJAVModel * _Nullable video))success
                failure:(void(^ _Nullable)(void))failure;

+(void)getVideoURLWithAID:(NSInteger)aid
                     page:(NSInteger)page /* 分p，从1开始 */
                  success:(void(^ _Nullable)(NSString * _Nullable url))success
                  failure:(void(^ _Nullable)(void))failure;

#pragma mark - DEPRECATED

+(void)getLiveHomepageDataWithSuccess:(void(^ _Nullable)(LiveHomeModel * _Nullable))success failure:(void(^ _Nullable)(void))failure;
+(void)getRecommendationHomepageDataWithDevice:(NSInteger)option //0 is iPhone, 1 is iPad
                                       success:(void(^ _Nullable)(RecommendHomeModel * _Nullable))success
                                       failure:(void(^ _Nullable)(void))failure;
+(void)getBangumiHomepageDataWithDevice:(NSInteger)option //0 is iPhone, 1 is iPad
                                success:(void(^ _Nullable)(BangumiHomeModel * _Nullable))success
                                failure:(void(^ _Nullable)(void))failure;

@end


#pragma mark - Feedback (DEPRECATED)

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
