//
//  SeasonsCollectionView.h
//  Bilibili
//
//  Created by LunarEclipse on 16/10/20.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SeasonsCollectionViewCell.h"

@class BangumiModel;

@interface SeasonsCollectionView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSArray<BangumiModel *> * seasons;
@property (nonatomic, strong) BangumiModel * currentSeason; //其实只需要currentSeason中的season_id

@property (nonatomic, copy) void(^onCellSelected)(SeasonsCollectionViewCell * cell);

@end
