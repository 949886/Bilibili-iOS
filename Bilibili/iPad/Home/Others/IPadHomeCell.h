//
//  IPadHomeCell.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/10.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SegmentView.h"

@class SegmentView;

@interface IPadHomeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *segmentIcon;
@property (weak, nonatomic) IBOutlet UILabel *segmentTitle;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (weak, nonatomic) IBOutlet UIButton *moreInfoButton;

@property (weak, nonatomic) IBOutlet UIView *symbolContainter;
@property (weak, nonatomic) IBOutlet UIView *refreshContainter;
@property (weak, nonatomic) IBOutlet UIView *moreInfoContainer;
@property (weak, nonatomic) IBOutlet UIView *headerContainer;
@property (weak, nonatomic) IBOutlet UIView *collectionViewContainer;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moreInfoConstraint;

@property (nonatomic, weak) SegmentView * segmentView;

-(void)setup:(RecommendationSegment *)model;

@end
