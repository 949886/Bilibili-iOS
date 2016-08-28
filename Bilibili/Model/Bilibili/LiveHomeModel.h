//
//  LiveHomeModel.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/5.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BannerModel, LiveHomeEntranceIcon, LiveHomePartition, LiveHomeRecommendData, WebImage;

@interface LiveHomeModel : NSObject

@property (nonatomic, copy) NSArray<BannerModel *> * banners;                   //广告条幅
@property (nonatomic, copy) NSArray<LiveHomeEntranceIcon *> * entranceIcons;    //滚动条幅下各种入口的图标
@property (nonatomic, copy) NSArray<LiveHomePartition *> * partitions;          //直播分区

@property (nonatomic, strong) LiveHomeRecommendData * recommendData;


@end


@interface LiveHomeEntranceIcon : NSObject

@property (nonatomic, copy) NSString * ID;
@property (nonatomic, copy) NSString * name;

@property (nonatomic, strong) WebImage * entrance_icon;

@end


@class LiveHomePartitionInfo, LiveModel;

@interface LiveHomePartition : NSObject

@property (nonatomic, strong) LiveHomePartitionInfo * info; //分区信息
@property (nonatomic, copy) NSArray<LiveModel *> * lives;   //推荐的直播

@end


@interface LiveHomePartitionInfo : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger count;  //观看人数

@property (nonatomic, copy) NSString * name;    //分区名字
@property (nonatomic, copy) NSString * area;

@property (nonatomic, strong) WebImage * sub_icon;  //图标信息

@end


@class LiveHomeRecommendBanner, LiveOwner;

@interface LiveHomeRecommendData : NSObject

@property (nonatomic, strong) NSArray<LiveModel *> *lives;
@property (nonatomic, strong) NSArray<LiveHomeRecommendBanner *> *banner_data;
@property (nonatomic, strong) LiveHomePartitionInfo * partition;

@end


@interface LiveHomeRecommendBanner : NSObject

@property (nonatomic, assign) NSInteger room_id;
@property (nonatomic, copy) NSString *accept_quality;
@property (nonatomic, strong) LiveOwner *owner;
@property (nonatomic, assign) NSInteger check_version;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger area_id;
@property (nonatomic, copy) NSString *playurl;
@property (nonatomic, strong) WebImage *cover;
@property (nonatomic, assign) NSInteger is_tv;
@property (nonatomic, assign) NSInteger online;
@property (nonatomic, assign) NSInteger broadcast_type;

@end


@interface LiveOwner : NSObject

@property (nonatomic, copy) NSString *face;
@property (nonatomic, assign) NSInteger mid;
@property (nonatomic, copy) NSString *name;

@end

