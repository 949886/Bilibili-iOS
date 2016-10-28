//
//  VideoPlayerController.h
//  Bilibili
//
//  Created by LunarEclipse on 16/9/23.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VideoPlayer.h"

@class DanmakuView;

typedef NS_ENUM(NSInteger, VideoPlayerType)
{
    VideoPlayerDefault,
    VideoPlayerLive
};

@interface VideoPlayerController : UIViewController

@property (nonatomic, readonly) VideoPlayer * player;

@property (nonatomic, strong) DanmakuView * danmakuView;

@property (nonatomic, assign) BOOL fullscreen;

-(instancetype)initWithType:(VideoPlayerType)type;

-(void)showInView:(UIView *)view;
-(void)showInFullScreen;

@end
