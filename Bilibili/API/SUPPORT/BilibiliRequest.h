//
//  HTTP.h
//  Bilibili
//
//  Created by LunarEclipse on 16/8/15.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BilibiliResponse.h"

@interface BilibiliRequest<T> : NSObject

/* Common way */

+ (void)GET:(NSString * _Nonnull)urlString
 parameters:(id _Nullable)parameters
      clazz:(Class _Nonnull)clazz
   progress:(void (^ _Nullable)(NSProgress * _Nonnull))downloadProgress
    success:(void (^ _Nullable)(T _Nullable object, BilibiliResponse * _Nonnull response))success
    failure:(void (^ _Nullable)(BilibiliResponse * _Nullable response, NSError * _Nullable error))failure;

+ (void)GET:(NSString * _Nonnull)urlString
 parameters:(id _Nullable)parameters
extraHeaders:(NSDictionary * _Nullable)headers
      clazz:(Class _Nonnull)clazz
   progress:(void (^ _Nullable)(NSProgress * _Nonnull))downloadProgress
    success:(void (^ _Nullable)(T _Nullable object, BilibiliResponse * _Nonnull response))success
    failure:(void (^ _Nullable)(BilibiliResponse * _Nullable response, NSError * _Nullable error))failure;

+ (void)POST:(NSString * _Nonnull)urlString
  parameters:(id _Nullable)parameters
       clazz:(Class _Nonnull)clazz
    progress:(void (^ _Nullable)(NSProgress * _Nullable uploadProgress))uploadProgress
     success:(void (^ _Nullable)(T _Nullable object, BilibiliResponse * _Nonnull response))success
     failure:(void (^ _Nullable)(BilibiliResponse * _Nullable response, NSError * _Nullable error))failure;

+ (void)POST:(NSString * _Nonnull)urlString
  parameters:(id _Nullable)parameters
 extraHeaders:(NSDictionary * _Nullable)headers
       clazz:(Class _Nonnull)clazz
    progress:(void (^ _Nullable)(NSProgress * _Nullable uploadProgress))uploadProgress
     success:(void (^ _Nullable)(T _Nullable object, BilibiliResponse * _Nonnull response))success
     failure:(void (^ _Nullable)(BilibiliResponse * _Nullable response, NSError * _Nullable error))failure;


/* Simple way (Only hava response code and message) */

+ (void)POST:(NSString * _Nonnull)urlString
  parameters:(id _Nullable)parameters
    progress:(void (^ _Nullable)(NSProgress * _Nullable uploadProgress))uploadProgress
     success:(void (^ _Nullable)(BilibiliResponse * _Nonnull response))success
     failure:(void (^ _Nullable)(BilibiliResponse * _Nullable response, NSError * _Nullable error))failure;

@end
