//
//  NSDateExtension.m
//  Extension
//
//  Created by LunarEclipse on 16/6/28.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "NSDateExtension.h"

@implementation NSDate (Extension)

+(NSDate *)parse:(NSString *)date format:(NSString *)format
{
    return [self parse:date format:format locale:@"en_US"];
}

+(NSDate *)parse:(NSString *)date format:(NSString *)format locale: (NSString *)locale
{
    NSDateFormatter * formatter = [NSDateFormatter new];
    formatter.dateFormat = format;
    formatter.locale = [NSLocale localeWithLocaleIdentifier:locale];
    return [formatter dateFromString:date];
}

+(NSString *)format:(NSDate *)date format:(NSString *)format
{
    return [self format:date format:format locale:@"en_US"];
}

+(NSString *)format:(NSDate *)date format:(NSString *)format locale: (NSString *)locale
{
    NSDateFormatter * formatter = [NSDateFormatter new];
    formatter.dateFormat = format;
    formatter.locale = [NSLocale localeWithLocaleIdentifier:locale];
    return [formatter stringFromDate:date];
}

@end
