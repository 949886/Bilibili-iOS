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

+(void)getUserWithID:(NSInteger)uid
             success:(SuccessBlock(UserModel))success
             failure:(FailureBlock)failure;

//+(void)getUserWithName:(NSString * _Nonnull)name /* DEAD API */
//               success:(SuccessBlock(UserModel))success
//               failure:(FailureBlock)failure;

+(void)loginWithUsername:(NSString * _Nonnull)username
                password:(NSString * _Nonnull)password
                 success:(SuccessBlock(LoginResponse))success
                 failure:(FailureBlock)failure;

@end
