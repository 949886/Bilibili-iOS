//
//  UIImageView+Inspectable.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/11.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "UIImageView+Inspectable.h"

@implementation UIImageView (Inspectable)

-(NSInteger)renderingMode
{
    return self.image.renderingMode;
}

-(void)setRenderingMode:(NSInteger)renderingMode
{
    self.image =  [self.image imageWithRenderingMode:renderingMode];
}

@end
