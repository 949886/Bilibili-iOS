//
//  VideoModel.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/3.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "VideoModel.h"
#import "PageModel.h"

@implementation VideoModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"pages" : [PageModel class],
             @"relates" : [VideoModel class],
             @"tags" : [NSString class] };
}

@end

@implementation VideoStateModel

@end
