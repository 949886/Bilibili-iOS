//
//  BilibiliAuth.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/23.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

#define APP_KEY @"6f90a59ac58a4123"
#define APP_SECRET @"0bfd84cc3940035173f35e6777508326"
#define PLATFORM  @"ios"
#define DEVICE ([[UIDevice currentDevice].model isEqualToString:@"iPad"] ? @"pad" : @"phone")
#define MOBI_APP ([[UIDevice currentDevice].model isEqualToString:@"iPad"] ? @"ipad" : @"iphone")
#define TS @((int)([NSDate date].timeIntervalSince1970))

@interface BilibiliAuth : NSObject

/**
 *  B站签名验证算法
 *
 *  Algorithm:
 *  sign = MD5(sortedQueryParameters + appSecret)
 *  E.G. sortedQueryParameters:  a=xxx&appkey=xxx&b=xxx&c=xxx
 */

+(NSString *)generateSign:(NSDictionary *)parameters;

@end
