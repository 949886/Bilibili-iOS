//
//  BangumiHomeModel.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/6.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PreviousBangumis, IPadBangumiCategory;
@class BangumiModel, BannerModel, TagModel;

#pragma mark Models

@interface BangumiHomeModel : NSObject

@property (nonatomic, copy) NSArray<BangumiModel *> * latestUpdate; //新番连载
@property (nonatomic, copy) NSString * updateCount;                 //今天更新数(DEPRECATED V3接口数据)

/* iPhone */
@property (nonatomic, copy) NSArray<BannerModel *> * banners;       //广告条幅
@property (nonatomic, copy) NSArray<BangumiModel *> * ends;         //完结新番(DEPRECATED V3接口)

@property (nonatomic, strong) PreviousBangumis * previous;          //(V4接口数据)

/* iPad */
@property (nonatomic, copy) NSArray<IPadBangumiCategory *> * categories;    //分区视频
@property (nonatomic, copy) NSArray<TagModel *> * recommendCategory;        //分区推荐

@end


@interface PreviousBangumis : NSObject

@property (nonatomic, assign) NSInteger seasion;    //2->春
@property (nonatomic, assign) NSInteger year;

@property (nonatomic, copy) NSArray<BangumiModel *> * list;

@end


@interface IPadBangumiCategory : NSObject

@property (nonatomic, strong) TagModel * category;
@property (nonatomic, copy) NSArray<BangumiModel *> * list; //视频list

@end


#pragma mark Convenience

/* 由于Bangumi首页分区信息不统一，需要该对Bangumi首页分区信息的描述类 */
@interface BangumiSegment : NSObject

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * moreInfo;
@property (nonatomic, assign) BOOL isRecommend;

@property (nonatomic, strong) NSArray * bangumis;

+(NSArray *)v4BangumiSegments:(BangumiHomeModel *)bangumiHome;

@end
