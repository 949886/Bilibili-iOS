//
//  ImageUtility.h
//  Bilibili
//
//  Created by LunarEclipse on 16/9/17.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageUtility : NSObject

+(void)blur:(UIImageView *)imageView;
+(void)blur:(UIImageView *)imageView scale:(NSInteger)scale;

@end
