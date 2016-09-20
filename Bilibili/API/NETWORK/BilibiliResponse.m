//
//  BilibiliResponse.m
//  Bilibili
//
//  Created by LunarEclipse on 16/8/15.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "BilibiliResponse.h"

@implementation BilibiliResponse

-(NSString *)description
{
    return [NSString stringWithFormat:@"Code: %ld Message: %@", _code, _message];
}

@end
