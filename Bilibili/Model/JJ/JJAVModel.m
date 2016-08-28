//
//  JJAVModel.m
//  Bilibili
//
//  Created by LunarEclipse on 16/8/24.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "JJAVModel.h"

@import YYKit;

@implementation JJAVModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"list" : [JJList class]};
}

@end

@implementation JJList

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"aid" : @"AV",
             @"cid" : @"CID",
             @"page" : @"P",
             @"title" : @"Title",
             @"mp3Url" : @"Mp3Url",
             @"mp3Length" : @"Mp3Length",
             @"mp3Click" : @"Mp3Click",
             @"mp4Length" : @"Mp4Length",
             @"mp4Url" : @"Mp4Url",
             @"mp4Click" : @"Mp4Click",};
}

@end
