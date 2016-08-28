//
//  BangumiHomeModel.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/6.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "BangumiHomeModel.h"
#import "BangumiModel.h"
#import "BannerModel.h"
#import "TagModel.h"

@implementation BangumiHomeModel

+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"latestUpdate" : @"latestUpdate.list",
             @"updateCount" : @"latestUpdate.updateCount"};
}

+(NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"latestUpdate" : [BangumiModel class],
             @"ends" : [BangumiModel class],
             @"banners" : [BannerModel class],
             @"categories" : [IPadBangumiCategory class],
             @"recommendCategory" : [TagModel class]};
}

@end

@implementation IPadBangumiCategory

+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"list" : @"list.list"};
}

+(NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"list" : [BangumiModel class]};
}

@end
