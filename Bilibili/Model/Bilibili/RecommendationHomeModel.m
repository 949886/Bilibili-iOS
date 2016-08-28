//
//  RecommendationHomeModel.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/6.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "RecommendationHomeModel.h"

@implementation RecommendationHomeModel

+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"segments" : @"data"};
}

+(NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"segments" : [RecommendationSegment class]};
}

-(void)setSegments:(NSArray<RecommendationSegment *> *)segments
{
    //不知为何服务器偶尔会返回空数据，需要删除 || type == av 会返回bilibili周刊，不在首页显示，需要删除
    NSMutableArray * array = [NSMutableArray array];
    for (RecommendationSegment * segment in segments)
        if (segment.elements.count != 0 && ![segment.type isEqualToString:@"av"])
            [array addObject:segment];
    
    _segments = array;
}

@end

@implementation RecommendationSegment

+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"live_count" : @"ext.live_count",
             @"elements" : @"body",
             @"banners" : @"banner.top",
             @"banners" : @"banner.bottom"};
}

+(NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"elements" : [RecommendationElement class],
             @"banners" : [BannerModel class]};
}

-(NSArray<VideoModel *> *)videos
{
    if ([_type isEqualToString:@"topic"] ||
        [_type isEqualToString:@"bangumi"] ||
        [_type isEqualToString:@"live"])
        return nil;
    
    NSMutableArray * videos = [NSMutableArray array];
    
    for (RecommendationElement * element in _elements)
    {
        VideoModel * video = [VideoModel new];
        video.aid = element.param;
        video.title = element.title;
        video.pic = element.cover;
        
        VideoStateModel * videoState = [VideoStateModel new];
        videoState.view = element.play;
        videoState.danmaku = element.danmaku;
        video.stat = videoState;
        
        [videos addObject:video];
    }
    
    return videos;
}


-(NSArray<VideoModel *> *)lives
{
    if ([_type isEqualToString:@"live"])
    {
        NSMutableArray * lives = [NSMutableArray array];
        for (RecommendationElement * element in _elements)
        {
            LiveModel * live = [LiveModel new];
            live.room_id = [element.param integerValue];
            live.title = element.title;
            live.online = element.online;
            
            WebImage * webImage = [WebImage new];
            webImage.src = element.cover;
            live.cover = webImage;
            
            UserModel * user = [UserModel new];
            user.name = element.name;
            user.face = element.face;
            live.owner = user;
            
            [lives addObject:live];
        }
        return lives;
    }

    return nil;
}

-(NSArray<BangumiModel *> *)bangumis
{
    if ([_type isEqualToString:@"bangumi"])
    {
        NSMutableArray * bangumis = [NSMutableArray array];
        for (RecommendationElement * element in _elements)
        {
            BangumiModel * bangumi = [BangumiModel new];
            bangumi.title = element.title;
            bangumi.bangumi_id = element.param;
            bangumi.newest_ep_index = [NSString stringWithFormat:@"%ld", (long)element.index];
            bangumi.pub_time = element.mtime;
            
            [bangumis addObject:bangumi];
        }
        return bangumis;
    }
    
    return nil;
}

-(NSArray<TopicModel *> *)topics
{
    if ([_type isEqualToString:@"topic"])
    {
        NSMutableArray * topics = [NSMutableArray array];
        for (RecommendationElement * element in _elements)
        {
            if(topics.count >= 2) return topics;
            TopicModel * topic = [TopicModel new];
            topic.title = element.title;
            topic.cover = element.cover;
            topic.url = element.param;
            
            [topics addObject:topic];
        }
        return topics;
    }
    
    return nil;
}

@end

@implementation RecommendationElement

+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"_goto" : @"goto"};
}

@end
