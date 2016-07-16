//
//  LaunchAD.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/5.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "LaunchAD.h"
#import "extension.h"

@implementation LaunchAD

+(void)show
{
    [self defaultSplashAnimation];
}

+(void)defaultSplashAnimation
{
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView * adView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].fixedBounds];
    [keyWindow addSubview:adView];
    
    UIImage * image;
    BOOL isIPad = [[UIDevice currentDevice].model isEqualToString:@"iPad"];
    if(isIPad) image = [UIImage imageNamed:@"bilibili_splash_ipad_bg"];
    else image = [UIImage imageNamed:@"bilibili_splash_iphone_bg"];
    UIImageView * backgroundImage = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].fixedBounds];
    backgroundImage.image = image;
    [adView addSubview:backgroundImage];
    
    UIImageView * splash = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bilibili_splash_default"]];
    splash.contentMode = UIViewContentModeScaleAspectFit;
    splash.frame = CGRectMake(0, 0, 50, 50);
    splash.center = CGPointMake(keyWindow.bounds.size.width / 2, keyWindow.bounds.size.height / 3);
    splash.alpha = 0;
    [adView addSubview:splash];
    
    float scale = [UIScreen mainScreen].bounds.size.width / 50;
    if (isIPad) scale /= 2.5;
    [UIView animateWithDuration:0.75 delay:0 options:0 animations:^{
        splash.transform = CGAffineTransformMakeScale(scale, scale);
        splash.alpha = 1;
    } completion:^(BOOL finished) {
        //渐隐并消失
        [UIView animateWithDuration:0.25 delay:1 options:0 animations:^{
            adView.alpha = 0;
        } completion:^(BOOL finished) {
            [adView removeFromSuperview];
        }];
    }];
}


@end
