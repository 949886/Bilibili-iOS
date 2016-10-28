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
    return @{@"latestUpdate" : @[@"latestUpdate.list", @"serializing"],
             @"updateCount" : @"latestUpdate.updateCount",
             @"banners" : @[@"banners", @"ad.head"]};
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


@implementation PreviousBangumis

+(NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"list" : [BangumiModel class]};
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


@implementation BangumiSegment

+(NSArray *)v4BangumiSegments:(BangumiHomeModel *)bangumiHome
{
    BangumiSegment * segment1 = [BangumiSegment new];
    segment1.index = 0;
    segment1.title = NSLocalizedString(@"home_bangumi_segment1_title", nil);
    segment1.moreInfo = NSLocalizedString(@"home_bangumi_segment1_moreinfo", nil);
    segment1.bangumis = bangumiHome.latestUpdate;
    
    BangumiSegment * segment2 = [BangumiSegment new];
    segment2.index = 1;
    segment2.title = NSLocalizedString(@"home_bangumi_segment2_title", nil);
    segment2.moreInfo = NSLocalizedString(@"home_bangumi_segment2_moreinfo", nil);
    segment2.bangumis = bangumiHome.previous.list;
    
    BangumiSegment * segment3 = [BangumiSegment new];
    segment3.index = 2;
    segment3.title = NSLocalizedString(@"home_bangumi_segment3_title", nil);
    segment3.moreInfo = NSLocalizedString(@"home_bangumi_segment3_moreinfo", nil);
    segment3.isRecommend = YES;
    
    NSArray * segments = @[segment1, segment2, segment3];
    return segments;
}

@end

