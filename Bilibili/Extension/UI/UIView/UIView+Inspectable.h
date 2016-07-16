//
//  UIView+Inspectable.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/11.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Inspectable)

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable UIColor * borderColor;

@end
