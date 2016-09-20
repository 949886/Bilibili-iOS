//
//  BangumiHomeHeader.h
//  Bilibili
//
//  Created by LunarEclipse on 16/9/9.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageSlider.h"
#import "ExButton.h"

@interface BangumiHomeHeader : UIView

@property (weak, nonatomic) IBOutlet ImageSlider * imageSlider;
@property (weak, nonatomic) IBOutlet ExButton * unfinishedBangumiButton;
@property (weak, nonatomic) IBOutlet ExButton * finishedBangumiButton;
@property (weak, nonatomic) IBOutlet ExButton * tianchaoBangumiButton;
@property (weak, nonatomic) IBOutlet ExButton * extraButton;
@property (weak, nonatomic) IBOutlet ExButton * followingBangumiButton;
@property (weak, nonatomic) IBOutlet UIButton * bangumiListButton;
@property (weak, nonatomic) IBOutlet UIButton * categoryButton;

@end
