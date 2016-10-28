//
//  UIViewExtension.h
//  Extension
//
//  Created by LunarEclipse on 16/6/27.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, readonly) UINavigationController * navigationController;

- (void)printViewHierarchy;
- (void)traverseSubviews:(void (^)(UIView * view))block;

- (UIImage *)captureImage;
- (void)captureImageToAlbum;

@end
