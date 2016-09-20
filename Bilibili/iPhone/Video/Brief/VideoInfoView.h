//
//  VideoInfoView.h
//  Bilibili
//
//  Created by LunarEclipse on 16/9/18.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ExButton.h"

@interface VideoInfoView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *danmakuCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *desctiptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *shareCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *coinCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriateCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *portraitImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *submitTimeLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ownerContainterHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagsContainerHeight;

@end
