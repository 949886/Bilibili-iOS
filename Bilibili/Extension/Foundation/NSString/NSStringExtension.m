//
//  NSStringExtension.m
//  String
//
//  Created by LunarEclipse on 16/6/8.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "NSStringExtension.h"

@implementation NSString (Extension)

- (NSString *)substringWithStart:(NSString *)start End:(NSString *)end
{
    if(start && ![self containsString:start]) return nil;
    if(end && ![self containsString:end]) return nil;
    
    NSString * result;
    NSScanner * scanner = [NSScanner scannerWithString:self];
    if(nil != start) {
        [scanner scanUpToString:start intoString:&result];
        [scanner scanString:start intoString:&result];
    }
    if(nil == end) end = @"\0";
    [scanner scanUpToString:end intoString:&result];
    
    return result;
}

@end
