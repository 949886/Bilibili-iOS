//
//  BilibiliResponse.m
//  Bilibili
//
//  Created by LunarEclipse on 16/8/15.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "BilibiliResponse.h"
#import "BilibiliException.h"



@implementation BilibiliResponse

-(NSString *)description
{
    return [NSString stringWithFormat:@"Code: %ld Message: %@", (long)_code, _message];
}

@end

@implementation CommentResponse

@end

@implementation LoginResponse

// CrossDomain Example:
// http://passport.bilibili.cn/crossDomain?DedeUserID=xxx&DedeUserID__ckMd5=xxx&Expires=604800&SESSDATA=xxx&gourl=xxx
-(NSHTTPCookie *)cookie
{
    if (_code != BILI_S_OK) return nil;
    if (_crossDomain == nil || [_crossDomain isEqualToString:@""]) return nil;
    
    NSString * cookieValue = [NSString string];
    
    //Parse crossDomain.
    NSString * string = _crossDomain;
    NSArray * patterns = @[@"DedeUserID=[^&]+&", @"DedeUserID__ckMd5=[^&]+&", @"SESSDATA=[^&]+&"];
    for (NSString * pattern in patterns)
    {
        NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern: pattern options:NSRegularExpressionCaseInsensitive error:nil];
        NSArray * matchs = [regex matchesInString:string options:NSMatchingReportCompletion range:NSMakeRange(0, string.length)];
        for (NSTextCheckingResult * match in matchs)
        {
            NSString * result = [string substringWithRange:NSMakeRange(match.range.location, match.range.length - 1)];
            cookieValue = [cookieValue stringByAppendingString:[NSString stringWithFormat:@"%@; ", result]];
        }
    }
    
    //New cookie.
    NSDictionary * properties = @{NSHTTPCookieName : @"account",
                                  NSHTTPCookieValue : cookieValue,
                                  NSHTTPCookieDomain : @"bilibili.com",
                                  NSHTTPCookieOriginURL : @"bilibili.com",
                                  NSHTTPCookieMaximumAge : [@([self expiresIn]) stringValue],
                                  NSHTTPCookieVersion : @"1" };
    NSHTTPCookie * cookie = [NSHTTPCookie cookieWithProperties:properties];
    
    return cookie;
}

-(NSInteger)expiresIn
{
    if (_code != BILI_S_OK) return 0;
    if (_crossDomain == nil || [_crossDomain isEqualToString:@""]) return 0;
    
    NSString * result;
    
    NSString * string = _crossDomain;
    NSString * pattern = @"Expires=[^&]+&";
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern: pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray * matchs = [regex matchesInString:string options:NSMatchingReportCompletion range:NSMakeRange(0, string.length)];
    for (NSTextCheckingResult * match in matchs)
        result = [string substringWithRange:NSMakeRange(match.range.location + 8, match.range.length - 9)];

    return [result integerValue];
}

-(NSInteger)uid
{
    if (_code != BILI_S_OK) return 0;
    if (_crossDomain == nil || [_crossDomain isEqualToString:@""]) return 0;
    
    NSString * result;
    
    NSString * string = _crossDomain;
    NSString * pattern = @"DedeUserID=[^&]+&";
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern: pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray * matchs = [regex matchesInString:string options:NSMatchingReportCompletion range:NSMakeRange(0, string.length)];
    for (NSTextCheckingResult * match in matchs)
        result = [string substringWithRange:NSMakeRange(match.range.location + 11, match.range.length - 12)];
    
    return [result integerValue];
}

@end
