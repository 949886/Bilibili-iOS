//
//  ExButton.h
//  Bilibili
//
//  Created by LunarEclipse on 16/9/6.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TextLayout)
{
    TextLayoutTop,
    TextLayoutBottom,
    TextLayoutLeft,
    TextLayoutRight
};

@interface ExButton : UIButton

@property (nonatomic, assign) TextLayout textLayout;
@property (nonatomic, assign) float spacing;

-(void)setTextLayout:(TextLayout)textLayout spacing:(float)spacing;

@end
