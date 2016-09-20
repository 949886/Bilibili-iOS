//
//  VideoCollectionView.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/10.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "BaseSegmentView.h"

#import "RecommendHomeModel.h"

typedef NS_ENUM(NSInteger, SegmentViewType)
{
    SegmentViewLive = 1,
    SegmentViewVideo,
    SegmentViewBangumi,
    SegmentViewCategory,
    SegmentViewTopic
};

@class SegmentData, TagModel;

@interface SegmentView : BaseSegmentView <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, assign) SegmentViewType type;
@property (nonatomic, copy) NSArray * data; //传LiveModel, VideoModel, BangumiModel, TagModel的数组

-(instancetype)initWithType:(SegmentViewType)type;

@end
