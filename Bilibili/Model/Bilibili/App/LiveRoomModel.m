//
//  LiveRoomInfoModel.m
//  Bilibili
//
//  Created by LunarEclipse on 16/10/10.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "LiveRoomModel.h"

@implementation LiveRoomModel

+(NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"toplist" : [LiveRoomToplist class],
             @"recommend" : [LiveRoomRecommend class],
             @"hot_word" : [LiveRoomHotWord class],
             @"roomgifts" : [LiveRoomGifts class],
             @"ignore_gift" : [LiveRoomIgnoreGift class],
             @"activity_gift" : [LiveRoomActivityGift class]};
}

@end


@implementation LiveRoomMeta

+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"_typeid" : @"typeid",
             @"tagIds" : @"tag_ids.0",
             @"desc" : @"description"};
}

+(NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"tags" : [NSString class]};
}

@end


@implementation LiveRoomSchedule

@end


@implementation LiveRoomHotWord

+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"ID" : @"id"};
}

@end


@implementation LiveRoomRecommend

@end


@implementation LiveRoomToplist

@end


@implementation LiveRoomGifts

+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"ID" : @"id"};
}

@end


@implementation LiveRoomIgnoreGift

+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"ID" : @"id"};
}

@end


@implementation LiveRoomActivityGift

+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"ID" : @"id"};
}

@end
