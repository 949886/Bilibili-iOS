//
//  BilibiliAppAPI.h
//  Bilibili
//
//  Created by LunarEclipse on 16/8/27.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BilibiliResponse.h"
#import "models.h"

@interface BilibiliAppAPI : NSObject

#pragma mark Live

+(void)getLiveHomeWithSuccess:(SuccessBlock(LiveHomeModel))success
                      failure:(FailureBlock)failure;

+(void)getLiveRoomIndexWithRoomID:(NSInteger)roomID
                          success:(SuccessBlock(LiveRoomModel))success
                          failure:(FailureBlock)failure;

+(void)getLiveRoomMessagesWithRoomID:(NSInteger)roomID
                             success:(SuccessBlock(LiveMessagesModel))success
                             failure:(FailureBlock)failure;

#pragma mark Recommendation

+(void)getRecommendHomeWithDevice:(NSInteger)option //0 is iPhone, 1 is iPad
                          success:(SuccessBlock(NSArray<RecommendSegment *>))success
                          failure:(FailureBlock)failure;

#pragma mark Bangumi

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

@end
