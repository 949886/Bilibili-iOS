//
//  CustomTabBar.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/7.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTabBar : UITabBar

@property (nonatomic, assign) BOOL hideButtomText;

-(void)setTabAtIndex:(NSInteger)index normalImage:(UIImage *)normal highlightedImage:(UIImage *)highlighted;

@end
