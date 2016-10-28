//
//  BangumiHeaderController.h
//  Bilibili
//
//  Created by LunarEclipse on 16/10/17.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BangumiModel.h"
#import "EpisodeModel.h"

@interface BangumiHeaderController : UIViewController

@property (nonatomic, strong) BangumiModel * bangumi;

@property (nonatomic, copy) void(^ onSeasonSelected)(BangumiModel *);
@property (nonatomic, copy) void(^ onEpisodeSelected)(EpisodeModel *);

@end
