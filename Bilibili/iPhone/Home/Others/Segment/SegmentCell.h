//
//  SegmentCell.h
//  Bilibili
//
//  Created by LunarEclipse on 16/9/4.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LiveHomeModel.h"
#import "RecommendHomeModel.h"

typedef NS_ENUM(NSInteger, SegmentCellType)
{
    SegmentCellNone = 0,
    SegmentCellLive,
    SegmentCellRecommend,
    SegmentCellBangumi,
    SegmentCellCategory,
    SegmentCellTopic
};


@interface SegmentCell : UITableViewCell <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *moreInfoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rankImageView;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeight;

@property (nonatomic, assign) SegmentCellType type;
@property (nonatomic, copy) NSArray * data;

- (void)setupLive:(LiveHomePartition *)partition;
- (void)setupRecommend:(RecommendSegment *)segment;
- (void)setupBangumi:(BangumiSegment *)segment;

@end
