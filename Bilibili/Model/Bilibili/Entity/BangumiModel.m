//
//  BangumiModel.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/3.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "BangumiModel.h"


@implementation BangumiModel

+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"favourites" : @[@"favourites", @"favorites", @"follow"],
             @"watching_count" : @[@"watching_count", @"watchingCount"]};
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"episodes" : [EpisodeModel class],
             @"actor" : [ActorModel class],
             @"seasons" : [BangumiModel class],
             @"tags" : [TagModel class]};
}

@end


@implementation BangumiUserSeason

@end


@implementation BangumiBpRank

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"list" : [SimpleUserModel class]};
}

@end
