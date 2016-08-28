//
//  BilibiliUserAPI.m
//  Bilibili
//
//  Created by LunarEclipse on 16/8/15.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "BilibiliUserAPI.h"

#import "BilibiliRequest.h"
#import "URLConstants.h"

@implementation BilibiliUserAPI

+(void)getUserWithID:(NSString * _Nonnull)uid
        success:(void (^ _Nullable)(UserModel * _Nonnull user, BilibiliResponse * _Nonnull response))success
        failure:(void (^ _Nullable)(BilibiliResponse * _Nonnull response, NSError * _Nonnull error))failure
{
        NSDictionary * parameters = @{@"mid" : uid};
        [self getUserWithParameters:parameters success:success failure:failure];
}

+(void)getUserWithName:(NSString * _Nonnull)name
        success:(void (^ _Nullable)(UserModel * _Nonnull user, BilibiliResponse * _Nonnull response))success
        failure:(void (^ _Nullable)(BilibiliResponse * _Nonnull response, NSError * _Nonnull error))failure
{
        NSDictionary * parameters = @{@"user" : name};
        [self getUserWithParameters:parameters success:success failure:failure];
}

/*private*/
+(void)getUserWithParameters:(NSDictionary *)parameters
        success:(void (^ _Nullable)(UserModel * _Nonnull user, BilibiliResponse * _Nonnull response))success
        failure:(void (^ _Nullable)(BilibiliResponse * _Nonnull response, NSError * _Nonnull error))failure
{
    [BilibiliRequest GET:BILIBILI_USER_INFO parameters:parameters clazz:[UserModel class] progress:nil success:success failure:failure];
}

@end
