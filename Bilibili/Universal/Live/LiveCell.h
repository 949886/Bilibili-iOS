//
//  LiveCell.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/6.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ExLabel.h"
#import "GradientImageView.h"

@class LiveModel;

@interface LiveCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet GradientImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIImageView *portraitImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet ExLabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewersLabel;

-(void)setup:(LiveModel *)live;

@end
