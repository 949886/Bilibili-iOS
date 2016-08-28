//
//  BilibiliUserAPI.h
//  Bilibili
//
//  Created by LunarEclipse on 16/8/15.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BilibiliResponse.h"
#import "models.h"


@interface BilibiliUserAPI : NSObject

+(void)getUserWithID:(NSString * _Nonnull)uid
        success:(void (^ _Nullable)(UserModel * _Nonnull user, BilibiliResponse * _Nonnull response))success
        failure:(void (^ _Nullable)(BilibiliResponse * _Nonnull response, NSError * _Nonnull error))failure;

+(void)getUserWithName:(NSString * _Nonnull)name
        success:(void (^ _Nullable)(UserModel * _Nonnull user, BilibiliResponse * _Nonnull response))success
        failure:(void (^ _Nullable)(BilibiliResponse * _Nonnull response, NSError * _Nonnull error))failure;

@end
