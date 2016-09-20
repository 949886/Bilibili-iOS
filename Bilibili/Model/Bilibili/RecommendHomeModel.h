//
//  RecommendHomeModel.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/6.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "models.h"

@class RecommendSegment, RecommendElement;

@interface RecommendHomeModel : NSObject

@property (nonatomic, copy) NSArray<RecommendSegment *> * segments;    //数据部分，每一栏是一个segment

/* iPad只有顶端横幅广告，iPhone的顶端广告在第一个segment的banners属性中 */
@property (nonatomic, copy) NSArray<BannerModel *> * banners;

@end


@interface RecommendSegment : NSObject

@property (nonatomic, copy) NSString * title;       //模块标题
@property (nonatomic, copy) NSString * type;        //Value: recommend, live, bangumi, topic, av, region

@property (nonatomic, copy) NSString * style;       //Value: medium, large。用处不明。
@property (nonatomic, copy) NSString * param;       //如果是分区的话(type=region)，返回分区id，否则为空

@property (nonatomic, assign) NSInteger live_count; //直播总数

@property (nonatomic, copy) NSArray<RecommendElement *> * elements;    //数据部分，每个视频、直播等

/* iPhone才会返回该数据 */
@property (nonatomic, copy) NSArray<BannerModel *> * banners;   //广告条幅(因为iPhone端每个分区下都可能会出现广告)


/* Readonly Properties */
@property (nonatomic, copy, readonly) NSArray<VideoModel *> * videos;
@property (nonatomic, copy, readonly) NSArray<LiveModel *> * lives;
@property (nonatomic, copy, readonly) NSArray<BangumiModel *> * bangumis;
@property (nonatomic, copy, readonly) NSArray<TopicModel *> * topics;

@end


@interface RecommendElement : NSObject

/* 共通属性 */
@property (nonatomic, copy) NSString * title;       //标题（直播、视频、话题等）
@property (nonatomic, copy) NSString * cover;       //封面URL
@property (nonatomic, copy) NSString * param;       //视频:av号 直播:live房间号 番剧:bangumi_id 话题:网页URL

@property (nonatomic, assign) BOOL finish;          //是否完结（直播、话题为0）

/* 视频属性 */
@property (nonatomic, assign) NSInteger play;
@property (nonatomic, assign) NSInteger danmaku;

/* 直播属性 */
@property (nonatomic, copy) NSString * name;        //主播名字
@property (nonatomic, copy) NSString * face;        //头像
@property (nonatomic, assign) NSInteger online;

/* 番剧属性 */
@property (nonatomic, copy) NSString * mtime;       //最新一集时间
@property (nonatomic, copy) NSString * index;      //最新一集是第几集

/* iPhone独有 */
@property (nonatomic, copy) NSString * _goto;       //跳转到哪，基本上为av
@property (nonatomic, copy) NSString * uri;

@end