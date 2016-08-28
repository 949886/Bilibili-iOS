//
//  UIImageExtension.m
//  Extension
//
//  Created by LunarEclipse on 16/6/27.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "UIImageExtension.h"

@implementation UIImage (Extension)

- (UIImage *)centerStretchableImage
{
    return [self stretchableImageWithLeftCapWidth:self.size.width * 0.5 topCapHeight:self.size.height * 0.5];
}

@end
