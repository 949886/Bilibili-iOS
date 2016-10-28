//
//  LiveRoomInfoModel.h
//  Bilibili
//
//  Created by LunarEclipse on 16/10/10.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WebImage.h"
#import "UserModel.h"

@class LiveRoomMeta, LiveRoomSchedule, LiveRoomCoinType, LiveRoomHotWord, LiveRoomToplist, LiveRoomRecommend;
@class LiveRoomGifts, LiveRoomActivityGift, LiveRoomIgnoreGift;

@interface LiveRoomModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *uname;
@property (nonatomic, copy) NSString *prepare;
@property (nonatomic, copy) NSString *cmt;
@property (nonatomic, copy) NSString *create_at;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *face;
@property (nonatomic, copy) NSString *m_face;
@property (nonatomic, copy) NSString *status;

@property (nonatomic, assign) NSInteger cmt_port;
@property (nonatomic, assign) NSInteger isadmin;
@property (nonatomic, assign) NSInteger room_id;
@property (nonatomic, assign) NSInteger cmt_port_goim;
@property (nonatomic, assign) NSInteger activity_id;
@property (nonatomic, assign) NSInteger opentime;
@property (nonatomic, assign) NSInteger sch_id;
@property (nonatomic, assign) NSInteger check_version;
@property (nonatomic, assign) NSInteger create;
@property (nonatomic, assign) NSInteger broadcast_type;
@property (nonatomic, assign) NSInteger online;
@property (nonatomic, assign) NSInteger area_id;
@property (nonatomic, assign) NSInteger mid;
@property (nonatomic, assign) NSInteger background_id;
@property (nonatomic, assign) NSInteger msg_length;
@property (nonatomic, assign) NSInteger attention;
@property (nonatomic, assign) NSInteger master_level;
@property (nonatomic, assign) NSInteger is_attention;
@property (nonatomic, assign) NSInteger master_level_color;

@property (nonatomic, assign) BOOL isvip;

@property (nonatomic, strong) LiveRoomMeta *meta;
@property (nonatomic, strong) LiveRoomSchedule *schedule;

@property (nonatomic, strong) NSArray<LiveRoomToplist *> *toplist;
@property (nonatomic, strong) NSArray<LiveRoomRecommend *> *recommend;
@property (nonatomic, strong) NSArray<LiveRoomHotWord *> *hot_word;
@property (nonatomic, strong) NSArray<LiveRoomGifts *> *roomgifts;
@property (nonatomic, strong) NSArray<LiveRoomIgnoreGift *> *ignore_gift;
@property (nonatomic, strong) NSArray<LiveRoomActivityGift *> *activity_gift;

@end


@interface LiveRoomMeta : NSObject

@property (nonatomic, assign) NSInteger aid;
@property (nonatomic, assign) NSInteger tagIds;
@property (nonatomic, assign) NSInteger _typeid;

@property (nonatomic, copy) NSString *check_status;
@property (nonatomic, copy) NSString * desc;
@property (nonatomic, copy) NSString *cover;

@property (nonatomic, strong) NSArray<NSString *> *tag;

@end


@interface LiveRoomSchedule : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *start_at;
@property (nonatomic, copy) NSString *status;

@property (nonatomic, assign) NSInteger stream_id;
@property (nonatomic, assign) NSInteger mid;
@property (nonatomic, assign) NSInteger start;
@property (nonatomic, assign) NSInteger sch_id;
@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, assign) NSInteger meta_id;
@property (nonatomic, assign) NSInteger pending_meta_id;
@property (nonatomic, assign) NSInteger online;
@property (nonatomic, assign) NSInteger aid;

//@property (nonatomic, strong) NSArray * manager;

@end


@interface LiveRoomCoinType : NSObject

@property (nonatomic, copy) NSString *silver;
@property (nonatomic, copy) NSString *gold;

@end


@interface LiveRoomHotWord : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *words;

@end


@interface LiveRoomToplist : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;

@end


@interface LiveRoomRecommend : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger online;
@property (nonatomic, assign) NSInteger room_id;

@property (nonatomic, strong) UserModel *owner;
@property (nonatomic, strong) WebImage *cover;

@end

@interface LiveRoomGifts : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger price;

@property (nonatomic, copy) NSString *count_set;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *gif_url;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) LiveRoomCoinType *coin_type;

@end


@interface LiveRoomActivityGift : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger num;

@property (nonatomic, copy) NSString *gif_url;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *name;

@end


@interface LiveRoomIgnoreGift : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger num;

@end
