//
//  ExLabel.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/14.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

/* 顶端对齐 */

typedef NS_ENUM(NSInteger, VerticalAlignment)
{
    VerticalAlignmentMiddle = 0,
    VerticalAlignmentTop,
    VerticalAlignmentBottom,
};

@interface ExLabel : UILabel

@property (nonatomic) VerticalAlignment verticalAlignment;

@end
