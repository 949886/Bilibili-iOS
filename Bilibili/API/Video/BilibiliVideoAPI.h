//
//  BilibiliVideoAPI.h
//  Bilibili
//
//  Created by LunarEclipse on 16/8/23.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "models.h"

typedef NS_ENUM(NSInteger, VideoQuarityOptions)
{
    VideoQuarityLow = 0,    //流畅
    VideoQuarityNormal,     //高清
    VideoQuarityHigh        //超清(不支持)
};

@interface BilibiliVideoAPI : NSObject

+(void)getVideoURLWithAID:(NSInteger)aid
                     page:(NSInteger)page /* 分p，从1开始 */
                  quality:(VideoQuarityOptions)quality
                  success:(void(^ _Nullable)(NSString * _Nullable url))success
                  failure:(void(^ _Nullable)(void))failure;

+(void)getAVInfoWithAID:(NSInteger)aid
                success:(void(^ _Nullable)(JJAVModel * _Nullable video))success
                failure:(void(^ _Nullable)(void))failure;

@end
