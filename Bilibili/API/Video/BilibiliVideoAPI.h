//
//  BilibiliVideoAPI.h
//  Bilibili
//
//  Created by LunarEclipse on 16/8/23.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BilibiliRequest.h"

#import "models.h"
#import "BilibiliEnumeration.h"


@interface BilibiliVideoAPI : NSObject

#pragma mark GET

+(void)getVideoInfoWithAID:(NSInteger)aid
                   success:(SuccessBlock(VideoModel))success
                   failure:(FailureBlock)failure;


+(void)getPlayURLWithCid:(NSInteger)cid
                 quality:(VideoQuarityOptions)quality
                 success:(SuccessBlock(PlayURLModel))success
                 failure:(FailureBlock)failure;

//未实现
+(void)getDanmakuWithAid:(NSInteger)aid
                    page:(NSInteger)page /* 分p，从1开始 */
                 success:(void(^ _Nullable)(NSString * _Nullable xml))success
                 failure:(void(^ _Nullable)(void))failure;

+(void)getDanmakuWithCid:(NSInteger)cid
                 success:(void(^ _Nullable)(NSString * _Nullable xml))success
                 failure:(void(^ _Nullable)(void))failure;

+(void)getCommentsWithAid:(NSInteger)aid
                    page:(NSInteger)page
                pageSize:(NSInteger)pageSize
                 success:(SuccessBlock(CommentsModel))success
                 failure:(FailureBlock)failure;

#pragma mark POST

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

#pragma mark BILIBILJJ

+(void)getAVInfoWithAID:(NSInteger)aid
                success:(void(^ _Nullable)(JJAVModel * _Nullable video))success
                failure:(void(^ _Nullable)(void))failure;

+(void)getVideoURLWithAID:(NSInteger)aid
                     page:(NSInteger)page /* 分p，从1开始 */
                  success:(void(^ _Nullable)(NSString * _Nullable url))success
                  failure:(void(^ _Nullable)(void))failure;

@end
