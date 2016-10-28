//
//  LiveMessageModel.m
//  Bilibili
//
//  Created by LunarEclipse on 16/10/25.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "LiveMessageModel.h"

@implementation LiveMessagesModel

+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"messages" : @"room"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"messages" : [LiveMessageModel class]};
}

@end


@implementation LiveMessageModel

+ (NSDictionary *)objectClassInArray
{
    return @{@"user_level" : [NSString class],
             @"title" : [NSString class],
             @"medal" : [NSString class]};
}

@end

