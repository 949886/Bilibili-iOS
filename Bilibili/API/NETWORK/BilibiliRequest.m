//
//  HTTP.m
//  Bilibili
//
//  Created by LunarEclipse on 16/8/15.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <objc/message.h>

#import "BilibiliRequest.h"

//Execute callback block
#define IfSuccess(_result_) \
int integer_code = [responseObject[@"code"] intValue]; \
NSString * string_message = (NSString *)responseObject[@"message"]; \
if (integer_code != 0) { \
NSLog(@"Request failed, code=%d, message=\"%@\"", integer_code, string_message); \
if(failure) failure(); \
} \
else {if(success) success(_result_);}


@import YYKit;
@import AFNetworking;

@implementation BilibiliRequest

+ (void)GET:(NSString * _Nonnull)urlString
 parameters:(id _Nullable)parameters
      clazz:(Class _Nonnull)clazz
   progress:(void (^ _Nullable)(NSProgress * _Nonnull))downloadProgress
    success:(void (^ _Nullable)(id object, BilibiliResponse * _Nonnull response))success
    failure:(void (^ _Nullable)(BilibiliResponse * _Nullable response, NSError * _Nullable))failure

{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * task, id responseObject) {
        BilibiliResponse * response = [BilibiliResponse new];
        response.code = [responseObject[@"code"] integerValue];
        response.message = responseObject[@"message"];
        response.task = task;
        
        if(response.code != 0){
            if(failure) failure(response, nil);
            return;
        }
        
        id data = responseObject[@"data"];
        if (data == nil) data = responseObject[@"result"];
        if (data == nil) data = responseObject;
        
        if ([data isKindOfClass:[NSDictionary class]]) {
            id (* msgSend)(id, SEL, NSDictionary *) = (id (*)(id, SEL, NSDictionary *))objc_msgSend;
            id result = msgSend(clazz, @selector(modelWithDictionary:), data);
            if(success) success(result, response);
        }
        else if ([data isKindOfClass:[NSArray class]]) {
            NSArray * result = [NSArray modelArrayWithClass:clazz json:data];
            if(success) success(result, response);
        }
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        if(failure) failure(nil, error);
    }];
}

+ (void)POST:(NSString * _Nonnull)urlString
  parameters:(id _Nullable)parameters
    progress:(void (^ _Nullable)(NSProgress * _Nullable uploadProgress))uploadProgress
     success:(void (^ _Nullable)(BilibiliResponse * _Nonnull response))success
     failure:(void (^ _Nullable)(BilibiliResponse * _Nonnull response, NSError * _Nonnull error))failure
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask * task, id responseObject) {
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        
    }];
}

@end
