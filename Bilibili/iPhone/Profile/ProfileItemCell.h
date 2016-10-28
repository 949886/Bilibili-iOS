//
//  ProfileItemCell.h
//  Bilibili
//
//  Created by LunarEclipse on 16/10/13.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileItemCell : UICollectionViewCell

@property (nonatomic, assign) Class goto_;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *badgeLabel;

@end

@interface ProfileItemSeparator : UICollectionReusableView
/* 背景为灰色的view */
@end

@interface ProfileItemLayout : UICollectionViewFlowLayout
/* 绘制分割线的布局 */
@end
