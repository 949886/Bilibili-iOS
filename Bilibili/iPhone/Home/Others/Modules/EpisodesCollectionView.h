//
//  EpisodesCollectionView.h
//  Bilibili
//
//  Created by LunarEclipse on 16/10/17.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EpisodesCollectionViewCell.h"

@class EpisodeModel;

@interface EpisodesCollectionView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, assign) NSInteger currentEpisode;    //index of selected episode in array.
@property (nonatomic, strong) NSArray<EpisodeModel *> * episodes;

@property (nonatomic, copy) void(^onCellSelected)(EpisodesCollectionViewCell * cell);

@end
