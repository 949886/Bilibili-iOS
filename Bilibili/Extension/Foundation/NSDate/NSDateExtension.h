//
//  NSDateExtension.h
//  Extension
//
//  Created by LunarEclipse on 16/6/28.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

+(NSDate *)parse:(NSString *)date format:(NSString *)format;
+(NSDate *)parse:(NSString *)date format:(NSString *)format locale: (NSString *)locale;
+(NSString *)format:(NSDate *)date format:(NSString *)format;
+(NSString *)format:(NSDate *)date format:(NSString *)format locale: (NSString *)locale;

@end
