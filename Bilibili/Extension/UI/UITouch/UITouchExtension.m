//
//  UITouchExtension.m
//  Extension
//
//  Created by LunarEclipse on 16/6/28.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "UITouchExtension.h"

@implementation UITouch (Extension)

-(CGPoint)touchPoint
{
    return [self locationInView:self.view];
}

@end
