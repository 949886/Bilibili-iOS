//
//  NSString+Chinese.h
//  Bilibili
//
//  Created by LunarEclipse on 16/9/10.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Chinese)

+(NSString *)integer2Chinese:(NSInteger)integer;
+(NSString *)integer2Chinese:(NSInteger)integer precision:(int)precision;

@end
