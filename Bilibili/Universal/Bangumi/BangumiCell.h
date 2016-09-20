//
//  BangumiCell.h
//  Bilibili
//
//  Created by LunarEclipse on 16/9/10.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GradientImageView.h"
#import "ExLabel.h"

@interface BangumiCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet GradientImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *viewersLabel;
@property (weak, nonatomic) IBOutlet ExLabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *episodeLabel;

@end
