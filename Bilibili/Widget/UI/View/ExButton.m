//
//  ExButton.m
//  Bilibili
//
//  Created by LunarEclipse on 16/9/6.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "ExButton.h"

@implementation ExButton

-(void)setTextLayout:(TextLayout)textLayout
{
    [self setTextLayout:textLayout spacing:0];
}

-(void)setTextLayout:(TextLayout)textLayout spacing:(float)spacing
{
    _textLayout = textLayout;
    _spacing = spacing;
    
    [self layoutText];
}

-(void)layoutText
{
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
    {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else
    {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和_spacing得到imageEdgeInsets和labelEdgeInsets的值
    switch (_textLayout)
    {
        case TextLayoutTop:
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight - _spacing / 2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight - _spacing / 2.0, -imageWith, 0, 0);
            break;
        case TextLayoutBottom:
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight - _spacing / 2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight - _spacing / 2.0, 0);
            break;
        case TextLayoutLeft:
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + _spacing / 2.0, 0, -labelWidth - _spacing / 2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith - _spacing / 2.0, 0, imageWith + _spacing / 2.0);
            break;
        case TextLayoutRight:
            imageEdgeInsets = UIEdgeInsetsMake(0, -_spacing / 2.0, 0, _spacing / 2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, _spacing / 2.0, 0, -_spacing / 2.0);
            break;
    }
    
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

@end
