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

+(void)getLiveHomeWithSuccess:(SuccessBlock(LiveHomeModel))success
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

@end
