//
//  BilibiliResponse.h
//  Bilibili
//
//  Created by LunarEclipse on 16/8/15.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SuccessBlock(_ENTITY_) \
void (^ _Nullable)(_ENTITY_ * _Nonnull object, BilibiliResponse * _Nonnull response)

@class BilibiliResponse;
typedef void (^ _Nullable SuccessBlock)(BilibiliResponse * _Nonnull response);
typedef void (^ _Nullable FailureBlock)(BilibiliResponse * _Nullable response, NSError * _Nullable error);


@interface BilibiliResponse : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy, nullable) NSString * message;
@property (nonatomic, strong, nullable) NSURLSessionDataTask * task;

@end


@interface CommentResponse : NSObject

@property (nonatomic, assign) BOOL need_captcha;
@property (nonatomic, copy, nullable) NSString * url;
@property (nonatomic, assign) NSInteger rpid;
@property (nonatomic, copy, nullable) NSString * rpid_str;

@end


@interface LoginResponse : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy, nullable) NSString * crossDomain;

@property (nonatomic, readonly, nullable) NSHTTPCookie * cookie;
@property (nonatomic, readonly) NSInteger expiresIn;
@property (nonatomic, readonly) NSInteger uid;

@end

