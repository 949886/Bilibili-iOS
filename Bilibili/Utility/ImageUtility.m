//
//  ImageUtility.m
//  Bilibili
//
//  Created by LunarEclipse on 16/9/17.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "ImageUtility.h"

@import CoreImage;
@import OpenGLES;

@implementation ImageUtility

+(void)blur:(UIImageView *)imageView
{
    [self blur:imageView scale:50];
    
}

+(void)blur:(UIImageView *)imageView scale:(NSInteger)scale
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        CIFilter * blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
        CIImage * ciImage = [[CIImage alloc] initWithImage:imageView.image];
        [blurFilter setValue:ciImage forKey:kCIInputImageKey];
        [blurFilter setValue:@(scale) forKey:@"inputRadius"];
        EAGLContext * eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        CIContext *context = [CIContext contextWithEAGLContext:eaglContext options:@{kCIContextWorkingColorSpace:[NSNull null]}];
        CIImage * output = [blurFilter valueForKey:kCIOutputImageKey];
        CGImageRef cgImage = [context createCGImage:output fromRect:[ciImage extent]];
        UIImage * bluredImage = [UIImage imageWithCGImage:cgImage];
        CGImageRelease(cgImage);
        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = bluredImage;
        });
    });
}

@end
