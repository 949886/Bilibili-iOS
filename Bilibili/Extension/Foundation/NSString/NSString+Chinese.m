//
//  NSString+Chinese.m
//  Bilibili
//
//  Created by LunarEclipse on 16/9/10.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "NSString+Chinese.h"

@implementation NSString (Chinese)

+(NSString *)integer2Chinese:(NSInteger)integer
{
    return [self integer2Chinese:integer precision:1];
}

+(NSString *)integer2Chinese:(NSInteger)integer precision:(int)precision
{
    float number = integer;
    
    while(number >= 10)
        number /= 10;
    
    if (integer >= 10000)
        return [NSString stringWithFormat:@"%.*f万", precision, number];
    if (integer >= 100000000)
        return [NSString stringWithFormat:@"%.*f亿", precision, number];
    
    return [NSString stringWithFormat:@"%ld", (long)integer];
}

@end
