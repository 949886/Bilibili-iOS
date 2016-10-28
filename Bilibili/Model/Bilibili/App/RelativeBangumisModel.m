//
//  RelativeBangumisModel.m
//  Bilibili
//
//  Created by LunarEclipse on 16/10/22.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "RelativeBangumisModel.h"

@implementation RelativeBangumisModel

+(NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"list" : [BangumiModel class]};
}

@end
