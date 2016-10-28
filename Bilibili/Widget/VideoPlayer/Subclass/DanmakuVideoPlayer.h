//
//  DanmakuVideoPlayer.h
//  Bilibili
//
//  Created by LunarEclipse on 16/10/11.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VideoPlayerController.h"
#import "DanmakuFramework.h"

@interface DanmakuVideoPlayer : VideoPlayer

@property (nonatomic, strong) DanmakuView * danmakuView;

@end

@interface DanmakuView (VideoPlayerDelegater)

-(void)registerVideoPlayerObserver:(VideoPlayer *)player;
-(void)unregisterVideoPlayerObserver;

@end

