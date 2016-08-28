//
//  BilibiliResponse.h
//  Bilibili
//
//  Created by LunarEclipse on 16/8/15.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#define SuccessBlock(_ENTITY_) \
void (^ _Nullable)(_ENTITY_ * _Nonnull object, BilibiliResponse * _Nonnull response)
#define FailureBlock \
void (^ _Nullable)(BilibiliResponse * _Nullable response, NSError * _Nullable error)

#import <Foundation/Foundation.h>

@interface BilibiliResponse : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString * message;

@property (nonatomic, strong) NSURLSessionDataTask * task;

@end
