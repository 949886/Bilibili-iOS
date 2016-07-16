//
//  VideoCell.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/11.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "ExLabel.h"

@interface VideoCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet ExLabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *danmakuCountLabel;


@end
