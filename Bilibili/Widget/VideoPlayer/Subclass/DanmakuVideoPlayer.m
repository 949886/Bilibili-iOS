//
//  DanmakuVideoPlayer.m
//  Bilibili
//
//  Created by LunarEclipse on 16/10/11.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "DanmakuVideoPlayer.h"

@implementation DanmakuVideoPlayer

-(void)setDanmakuView:(DanmakuView *)danmakuView
{
    _danmakuView = danmakuView;
    
    if(danmakuView.superview)
    {
        [danmakuView unregisterVideoPlayerObserver];
        [danmakuView removeFromSuperview];
    }
    
    _danmakuView.frame = self.player.view.bounds;
    _danmakuView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_danmakuView registerVideoPlayerObserver:self];
    [self.player.view addSubview:_danmakuView];
}

-(void)onBufferingStart
{
    [_danmakuView pause];
}

-(void)onBufferingEnd
{
    [_danmakuView resume];
}

@end


@implementation DanmakuView (VideoPlayerDelegater)

-(void)registerVideoPlayerObserver:(VideoPlayer *)player
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onVideoPlayerPlay:) name:VideoPlayerPlayNotification object:player];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onVideoPlayerPause:) name:VideoPlayerPauseNotification object:player];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onVideoPlayerEnterFullScreen:) name:VideoPlayerEnterWindowNotification object:player];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onVideoPlayerEnterWindow:) name:VideoPlayerEnterFullscreenNotification object:player];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onVideoPlayerStartBuffering:) name:VideoPlayerStartBufferingNotification object:player];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onVideoPlayerEndBuffering:) name:VideoPlayerEndBufferingNotification object:player];
}

-(void)unregisterVideoPlayerObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)onVideoPlayerPlay:(NSNotification *)notification
{
    if (self.isPaused)
        [self resume];
    else [self start];
}

-(void)onVideoPlayerPause:(NSNotification *)notification
{
    [self pause];
}

-(void)onVideoPlayerEnterFullScreen:(NSNotification *)notification
{
    [self removeAllVisiableDanmakus];
}

-(void)onVideoPlayerEnterWindow:(NSNotification *)notification
{
    [self removeAllVisiableDanmakus];
}

-(void)onVideoPlayerStartBuffering:(NSNotification *)notification
{
    [self pause];
}

-(void)onVideoPlayerEndBuffering:(NSNotification *)notification
{
    [self resume];
}

@end

