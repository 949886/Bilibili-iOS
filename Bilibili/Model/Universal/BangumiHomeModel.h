//
//  BangumiHomeModel.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/6.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BangumiLatestUpdate, IPadBangumiCategory;
@class BangumiModel, BannerModel, TagModel;

@interface BangumiHomeModel : NSObject

@property (nonatomic, copy) NSArray<BangumiModel *> * latestUpdate; //新番连载
@property (nonatomic, copy) NSString * updateCount;                 //今天更新数

/* iPhone */
@property (nonatomic, copy) NSArray<BangumiModel *> * ends;         //完结新番
@property (nonatomic, copy) NSArray<BannerModel *> * banners;       //广告条幅

/* iPad */
@property (nonatomic, copy) NSArray<IPadBangumiCategory *> * categories;    //分区视频
@property (nonatomic, copy) NSArray<TagModel *> * recommendCategory;        //分区推荐

@end


@interface IPadBangumiCategory : NSObject

@property (nonatomic, strong) TagModel * category;
@property (nonatomic, copy) NSArray<BangumiModel *> * list; //视频list

@end
