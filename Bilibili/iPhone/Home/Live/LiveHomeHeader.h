//
//  LiveHomeHeader.h
//  Bilibili
//
//  Created by LunarEclipse on 16/9/6.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageSlider.h"
#import "ExButton.h"

@interface LiveHomeHeader : UIView

@property (weak, nonatomic) IBOutlet ImageSlider * imageSlider;
@property (weak, nonatomic) IBOutlet ExButton *followButton;
@property (weak, nonatomic) IBOutlet ExButton *liveCenterButton;
@property (weak, nonatomic) IBOutlet ExButton *searchButton;
@property (weak, nonatomic) IBOutlet ExButton *categoryButton;

@end
