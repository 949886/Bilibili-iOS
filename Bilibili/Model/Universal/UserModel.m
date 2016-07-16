//
//  UserModel.m
//  Weibo
//
//  Created by LunarEclipse on 16/6/29.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "UserModel.h"
#import "YYKit.h"

@implementation UserModel

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"_friend" : @"friend", @"_description" : @"description"};
}

+ (NSDictionary *)modelPropertyContainerGenericClass
{
    return @{@"attentions" : [NSNumber class]};
}

- (NSString *)description
{
    return [self modelDescription];
}

@end


@implementation LevelModel

@end
