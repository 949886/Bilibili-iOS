//
//  BangumiModel.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/3.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EpisodeModel, ActorModel, ActivityModel, TagModel;

@interface BangumiModel : NSObject

@property (nonatomic, copy) NSString * title;           //一般和bangumi_title相同
@property (nonatomic, copy) NSString * season_id;       //系列id
@property (nonatomic, copy) NSString * season_title;    //标题（E.G. TV, SP, OVA, 第一季, 第二季等）
@property (nonatomic, copy) NSString * bangumi_id;      //番组id
@property (nonatomic, copy) NSString * bangumi_title;   //番组名字
@property (nonatomic, copy) NSString * brief;           //简介
@property (nonatomic, copy) NSString * evaluate;        //描述
@property (nonatomic, copy) NSString * staff;
@property (nonatomic, copy) NSString * cover;           //封面URL
@property (nonatomic, copy) NSString * squareCover;     //正方形封面URL
@property (nonatomic, copy) NSString * pub_time;
@property (nonatomic, copy) NSString * area;            //出版地区
@property (nonatomic, copy) NSString * share_url;
@property (nonatomic, copy) NSString * copyright;

@property (nonatomic, assign) NSInteger favourites;
@property (nonatomic, assign) NSInteger coins;
@property (nonatomic, assign) NSInteger play_count;
@property (nonatomic, assign) NSInteger danmaku_count;
@property (nonatomic, assign) NSInteger watching_count;
@property (nonatomic, assign) NSInteger total_count;     //总集数
@property (nonatomic, assign) NSInteger newest_ep_index; //最新一集为第几集
@property (nonatomic, assign) NSInteger newest_ep_id;    //最新一集的episode_id

@property (nonatomic, assign) NSInteger weekday;        //每周几播出(星期天为0)
@property (nonatomic, assign) NSInteger arealimit;

@property (nonatomic, assign) BOOL is_finished;         //是否完结
@property (nonatomic, assign) BOOL allow_download;
@property (nonatomic, assign) BOOL allow_bp;            //是否允许承包

@property (nonatomic, strong) ActivityModel * activity; //相关活动

@property (nonatomic, copy) NSArray<EpisodeModel *> * episodes; //剧集信息
@property (nonatomic, copy) NSArray<ActorModel *> * actor;      //主要角色
@property (nonatomic, copy) NSArray<BangumiModel *> * seasons;  //相关番剧（一般只有自己，但比如「RE:0」及一些完结番会有一个TV还有一个SP）

@end
