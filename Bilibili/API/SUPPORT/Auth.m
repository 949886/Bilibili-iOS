//
//  Auth.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/23.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "Auth.h"

#import <CommonCrypto/CommonDigest.h>

#define APP_KEY @"c1b107428d337928"
#define APP_SECRET @"ea85624dfcf12d7cc7b2b3a94fac1f2c"

@implementation Auth

+(NSString *)generateSign:(NSDictionary *)parameters
{
    //获得排序后的参数 (E.G. a=user&b=pwd&c=json)
    NSArray * sortedKeys = [parameters keysSortedByValueUsingSelector:@selector(compare:)];
    NSString * plaintext = [NSString string];
    for (NSString * key in sortedKeys)
        plaintext = [plaintext stringByAppendingFormat:@"%@=%@&", key, parameters[key]];
    if (plaintext == nil || plaintext.length == 0) return @"";
    const char * cstring = [plaintext substringToIndex:plaintext.length - 1].UTF8String;
    
    //获得MD5加密的C字符串
    unsigned char crypto[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cstring, (unsigned int)strlen(cstring), crypto);
    
    //CString → NSStirng
    NSString * sign = [NSString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; ++i)
        sign = [sign stringByAppendingFormat:@"%2x", crypto[i]];
    
    return sign;
}

@end
