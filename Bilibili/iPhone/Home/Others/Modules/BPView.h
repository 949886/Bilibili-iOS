//
//  BPView.h
//  Bilibili
//
//  Created by LunarEclipse on 16/10/17.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BangumiModel;

@interface BPView : UIView

@property (weak, nonatomic) IBOutlet UILabel *sponsersLabel;
@property (weak, nonatomic) IBOutlet UILabel *sponsersWeeklyLabel;

@property (weak, nonatomic) IBOutlet UIImageView *sponser1;
@property (weak, nonatomic) IBOutlet UIImageView *sponser2;
@property (weak, nonatomic) IBOutlet UIImageView *sponser3;
@property (weak, nonatomic) IBOutlet UIImageView *sponser4;

+ (instancetype)defaultBPView;

-(void)setup:(BangumiModel *)bangumi;

@end
