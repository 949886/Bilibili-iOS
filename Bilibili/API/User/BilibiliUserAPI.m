//
//  BilibiliUserAPI.m
//  Bilibili
//
//  Created by LunarEclipse on 16/8/15.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "BilibiliUserAPI.h"

#import "BilibiliRequest.h"
#import "BilibiliURL.h"

#import "AFNetworking.h"

@implementation BilibiliUserAPI


//[POST]http://space.bilibili.com/ajax/member/GetInfo
+(void)getUserWithID:(NSInteger)uid
             success:(SuccessBlock(UserModel))success
             failure:(FailureBlock)failure
{
    NSDictionary * parameters = @{@"mid" : @(uid),
                                  @"_" : @((u_int64_t)([NSDate date].timeIntervalSince1970 * 1000))};
    NSLog(@"%@", parameters[@"_"]);
    NSDictionary * headers = @{@"Referer" : [NSString stringWithFormat:@"http://space.bilibili.com/%@/", @(uid)]};
    [BilibiliRequest POST:BILIBILI_USER_INFO parameters:parameters extraHeaders:headers clazz:[UserModel class] progress:nil success:success failure:failure];
}

//[API]http://api.bilibili.cn/userinfo?mid=17281 (此API已死)
//[API]http://api.bilibili.cn/userinfo?user=月蝕LunarEclipse (此API已死)
//+(void)getUserWithParameters:(NSDictionary *)parameters
//                     success:(SuccessBlock(UserModel))success
//                     failure:(FailureBlock)failure
//{
//    [BilibiliRequest GET:@"http://api.bilibili.cn/userinfo" parameters:parameters clazz:[UserModel class] progress:nil success:success failure:failure];
//}

//[API]
+(void)loginWithUsername:(NSString * _Nonnull)username
                password:(NSString * _Nonnull)password
                 success:(SuccessBlock(LoginResponse))success
                 failure:(FailureBlock)failure;
{
    NSDictionary * parameters = @{@"userid" : username,
                                  @"pwd" : password,
                                  @"keep" : @0};
    
    [BilibiliRequest POST:BILIBILI_LOGIN parameters:parameters clazz:[LoginResponse class] progress:nil success:^(LoginResponse * object, BilibiliResponse * response) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:object.cookie];
        if(success) success(object, response);
    } failure:failure];
}

@end
