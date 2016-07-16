//
//  UIView+Inspectable.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/11.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "UIView+Inspectable.h"


@implementation UIView (Inspectable)

-(CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

-(void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}

-(CGFloat)borderWidth
{
    return self.layer.borderWidth;
}

-(void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

-(UIColor *)borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

-(void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

@end
