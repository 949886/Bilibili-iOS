//
//  BannerModel.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/5.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "BannerModel.h"
#import "WebImage.h"

@implementation BannerModel

+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"url" : @"weburl",
             @"url" : @"link",
             @"imageurl" : @"imageurl",
             @"imageurl" : @"img",
             @"_description" : @"description"};
}

+(NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"image_list" : [WebImage class]};
}

@end
