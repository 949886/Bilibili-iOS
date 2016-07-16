//
//  LiveHomeModel.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/5.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "LiveHomeModel.h"
#import "BannerModel.h"
#import "LiveModel.h"

@implementation LiveHomeModel

+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"banners" : @"banner"};
}

+(NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"banner" : [BannerModel class],
             @"entranceIcons" : [LiveHomeEntranceIcon class],
             @"partitions" : [LiveHomePartition class]};
}

@end


@implementation LiveHomeEntranceIcon

+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"ID" : @"id"};
}

@end


@implementation LiveHomePartition

+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"info" : @"partition"};
}

+(NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"lives" : [LiveModel class]};
}

@end


@implementation LiveHomePartitionInfo

+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"ID" : @"id"};
}

@end
