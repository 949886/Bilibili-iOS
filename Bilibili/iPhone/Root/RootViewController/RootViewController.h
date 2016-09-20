//
//  RootViewController.h
//  Bilibili
//
//  Created by LunarEclipse on 16/9/2.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UINavigationControllerDelegate>

@property (weak, nonatomic) UIView *titleView;
@property (nonatomic, copy) NSString * titleName;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@end
