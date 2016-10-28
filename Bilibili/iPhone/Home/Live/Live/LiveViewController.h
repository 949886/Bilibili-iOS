//
//  LiveViewController.h
//  Bilibili
//
//  Created by LunarEclipse on 16/10/10.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LiveModel.h"

@interface LiveViewController : UIViewController <UINavigationControllerDelegate>

-(instancetype)initWithLive:(LiveModel *)live;

@end
