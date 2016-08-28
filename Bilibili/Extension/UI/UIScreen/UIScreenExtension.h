//
//  UIScreenExtension.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/5.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (Extension)

/* iOS7及以前版本[UIScreen mainScreen].bounds属性不会随着屏幕的旋转而改变 */
-(CGRect)fixedBounds;
-(CGSize)fixedScreenSize;

@end
