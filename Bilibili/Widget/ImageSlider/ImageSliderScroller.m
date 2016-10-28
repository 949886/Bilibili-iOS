//
//  ImageSliderScroller.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/14.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "ImageSliderScroller.h"

@implementation ImageSliderScroller

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView * view = self;
    for (UIView *subView in self.subviews)
    {
        CGPoint p = [subView convertPoint:point fromView:self];
        if (CGRectContainsPoint(subView.bounds, p))
            view = subView;
    }
    return view;
}

@end
