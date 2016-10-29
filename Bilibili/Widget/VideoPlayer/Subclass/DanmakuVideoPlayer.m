//
//  DanmakuVideoPlayer.m
//  Bilibili
//
//  Created by LunarEclipse on 16/10/11.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "DanmakuVideoPlayer.h"

#define NC [NSNotificationCenter defaultCenter]

@implementation DanmakuVideoPlayer

-(void)setDanmakuView:(DanmakuView *)danmakuView
{
    _danmakuView = danmakuView;
    
    if(danmakuView.superview == nil)
    {
        _danmakuView.frame = self.player.view.bounds;
        _danmakuView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.player.view addSubview:_danmakuView];
    }
    
    [danmakuView unregisterVideoPlayerObserver];
    //        [danmakuView removeFromSuperview];
    [_danmakuView registerVideoPlayerObserver:self];
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
    [NC addObserver:self selector:@selector(onVideoPlayerPlay:) name:VideoPlayerPlayNotification object:player];
    [NC addObserver:self selector:@selector(onVideoPlayerPause:) name:VideoPlayerPauseNotification object:player];
    [NC addObserver:self selector:@selector(onVideoPlayerEnterWindow:) name:VideoPlayerEnterWindowNotification object:player];
    [NC addObserver:self selector:@selector(onVideoPlayerEnterFullScreen:) name:VideoPlayerEnterFullscreenNotification object:player];
    [NC addObserver:self selector:@selector(onVideoPlayerStartBuffering:) name:VideoPlayerStartBufferingNotification object:player];
    [NC addObserver:self selector:@selector(onVideoPlayerEndBuffering:) name:VideoPlayerEndBufferingNotification object:player];
    [NC addObserver:self selector:@selector(onVideoPlayerJump:) name:VideoPlayerJumpNotification object:player];
}

-(void)unregisterVideoPlayerObserver
{
    [NC removeObserver:self name:VideoPlayerPlayNotification object:nil];
    [NC removeObserver:self name:VideoPlayerPauseNotification object:nil];
    [NC removeObserver:self name:VideoPlayerEnterWindowNotification object:nil];
    [NC removeObserver:self name:VideoPlayerEnterFullscreenNotification object:nil];
    [NC removeObserver:self name:VideoPlayerStartBufferingNotification object:nil];
    [NC removeObserver:self name:VideoPlayerEndBufferingNotification object:nil];
    [NC removeObserver:self name:VideoPlayerJumpNotification object:nil];
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

-(void)onVideoPlayerJump:(NSNotification *)notification
{
    [self setCurrentTime:[notification.userInfo.allValues.firstObject doubleValue]];
}

@end

