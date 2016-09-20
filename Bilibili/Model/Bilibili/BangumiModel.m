//
//  BangumiModel.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/3.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "BangumiModel.h"
#import "EpisodeModel.h"

@implementation BangumiModel

+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"favourites" : @[@"favourites", @"favorites"],
             @"watching_count" : @[@"watching_count", @"watchingCount"]};
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"episodes" : [EpisodeModel class],
//             @"actor" : [ActorModel class],
             @"seasons" : [BangumiModel class],
             };
}

@end
