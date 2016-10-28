//
//  EpisodesCollectionViewCell.h
//  Bilibili
//
//  Created by LunarEclipse on 16/10/21.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EpisodeModel.h"

@interface EpisodesCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *episodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) EpisodeModel * episode;

-(void)setup:(EpisodeModel *)episode;

@end
