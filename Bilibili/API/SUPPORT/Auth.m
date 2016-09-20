//
//  Auth.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/23.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "Auth.h"

#import <CommonCrypto/CommonDigest.h>

@implementation Auth

+(NSString *)generateSign:(NSDictionary *)parameters
{
    NSMutableDictionary * copy = parameters.mutableCopy;
    
    //将dict的values转换成字符串值以进行排序
    [copy enumerateKeysAndObjectsUsingBlock:^(NSString * key, id obj, BOOL * stop) {
        copy[key] = [NSString stringWithFormat:@"%@", obj];
    }];
    
    //获得排序后的参数
    NSArray * sortedKeys = [copy.allKeys sortedArrayUsingSelector:@selector(compare:)];
    NSString * plaintext = [NSString string];
    for (NSString * key in sortedKeys)
        plaintext = [plaintext stringByAppendingFormat:@"%@=%@&", key, copy[key]];
    plaintext = [[plaintext substringToIndex:plaintext.length - 1] stringByAppendingString:APP_SECRET];
    if (plaintext == nil || plaintext.length == 0) return @"";
    const char * cstring = plaintext.UTF8String;
    
    //获得MD5加密的C字符串
    unsigned char crypto[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cstring, (unsigned int)strlen(cstring), crypto);
    
    //CString → NSStirng
    NSString * sign = [NSString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; ++i)
        sign = [sign stringByAppendingFormat:@"%2x", crypto[i]];
    sign = [sign stringByReplacingOccurrencesOfString:@" " withString:@"0"];
    
    return sign;
}

@end
