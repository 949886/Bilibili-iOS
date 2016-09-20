//
//  Auth.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/23.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

#define APP_KEY @"c1b107428d337928"
#define APP_SECRET @"ea85624dfcf12d7cc7b2b3a94fac1f2c"
#define PLATFORM  @"ios"
#define DEVICE ([[UIDevice currentDevice].model isEqualToString:@"iPad"] ? @"pad" : @"phone")

@interface Auth : NSObject

/**
 *  B站8月份对视频地址API更换了签名加密算法（其他API未受影响），即无法使用该算法得出视频地址的sign。
 *  How: https://github.com/rg3/youtube-dl/issues/10375
 *
 *  Algorithm:
 *  sign = MD5(sortedQueryParameters + appSecret)
 *  E.G. sortedQueryParameters:  a=xxx&appkey=xxx&b=xxx&c=xxx
 */

+(NSString *)generateSign:(NSDictionary *)parameters;

@end
