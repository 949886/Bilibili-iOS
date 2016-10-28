//
//  BangumiViewController.h
//  Bilibili
//
//  Created by LunarEclipse on 16/10/17.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CommentViewController.h"

@class BangumiModel;

@interface BangumiViewController : CommentViewController

-(instancetype)initWithBangumi:(BangumiModel *)bangumi;
-(instancetype)initWithSeasonID:(NSInteger)sid;

@end
