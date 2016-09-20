//
//  VideoModel.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/3.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserModel.h"
#import "PageModel.h"
#import "BangumiModel.h"

@class VideoStateModel, VideoRights;

@interface VideoModel : NSObject

@property (nonatomic, copy) NSString * aid;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * desc;        //description
@property (nonatomic, copy) NSString * pic;         //封面图片URL
@property (nonatomic, copy) NSString * tname;

@property (nonatomic, assign) NSInteger pubdate;    //发布时间戳（自1970-1-1 00:00:00 GMT以来的秒数）
@property (nonatomic, assign) NSInteger copyright;
@property (nonatomic, assign) NSInteger tid;

@property (nonatomic, strong) VideoStateModel * stat;   //视频信息（总播放数、弹幕数、收藏数、硬币数等）
@property (nonatomic, strong) BangumiModel * season;    //番剧信息（番组名、集数、是否完结等）
@property (nonatomic, strong) UserModel * owner;        //发布者
@property (nonatomic, strong) VideoRights * rights;       //权限（是否允许承包、下载等）

@property (nonatomic, copy) NSArray<PageModel *> * pages; //分P信息（包含同一番组的各集aid, cid, 名字等。非番组则只包含一个元素，表示自己。）
@property (nonatomic, copy) NSArray<VideoModel *> * relates; //相关视频（只返回title, owner, pic, aid, stat）
@property (nonatomic, copy) NSArray<NSString *> * tags;

@end


@interface VideoStateModel : NSObject

@property (nonatomic, assign) NSInteger view;
@property (nonatomic, assign) NSInteger danmaku;
@property (nonatomic, assign) NSInteger favorite;
@property (nonatomic, assign) NSInteger reply;
@property (nonatomic, assign) NSInteger coin;
@property (nonatomic, assign) NSInteger share;

@property (nonatomic, assign) NSInteger now_rank;
@property (nonatomic, assign) NSInteger his_rank;

@end


@interface VideoRights : NSObject

@property (nonatomic, assign) BOOL movie;
@property (nonatomic, assign) BOOL elec;
@property (nonatomic, assign) BOOL pay;
@property (nonatomic, assign) BOOL download;
@property (nonatomic, assign) BOOL bp;

@end
