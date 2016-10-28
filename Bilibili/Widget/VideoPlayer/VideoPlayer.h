//
//  VideoPlayer.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/4.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

/* 基于IJKPlayer */

@class VideoPlayerController;

@import UIKit;
@import VideoToolbox;
@import IJKMediaFramework;

@interface VideoPlayer : UIView

@property (nonatomic, copy) NSString * url;
@property (nonatomic, assign) BOOL hideWidgets;
@property (nonatomic, assign) BOOL shouldAutoplay;

@property (nonatomic, assign, readonly) BOOL isPreparedToPlay;

@property (nonatomic, weak) VideoPlayerController * controller;
@property (nonatomic, strong) IJKFFMoviePlayerController * player;

@property (nonatomic, weak) IBOutlet UIView *playerView;

@property (nonatomic, copy) void (^onClick)(VideoPlayer *);

-(instancetype)initWithURL:(NSString *)url;
+(instancetype)videoPlayerWithURL:(NSString *)url;

-(void)showInView:(UIView *)view;

-(void)play;
-(void)pause;
-(void)stop;

-(void)hideWidgets:(BOOL)hideWidgets animated:(BOOL)isAnimated;
-(void)log:(NSString *)text;    //在小电视页面写入加载状态


/* To be overrided */

-(void)onBufferingStart;
-(void)onBufferingEnd;

@end


#pragma mark Notification

static NSString * const VideoPlayerPlayNotification = @"VideoPlayerPlayNotification";
static NSString * const VideoPlayerPauseNotification = @"VideoPlayerPauseNotification";
static NSString * const VideoPlayerStopNotification = @"VideoPlayerStopNotification";
static NSString * const VideoPlayerShutdownNotification = @"VideoPlayerShutdownNotification";
static NSString * const VideoPlayerEnterWindowNotification = @"VideoPlayerEnterWindowNotification";
static NSString * const VideoPlayerEnterFullscreenNotification = @"VideoPlayerEnterFullscreenNotification";
static NSString * const VideoPlayerPlayTimeChangeNotification = @"VideoPlayerPlayTimeChangeNotification";
static NSString * const VideoPlayerStartBufferingNotification = @"VideoPlayerStartBufferingNotification";
static NSString * const VideoPlayerEndBufferingNotification = @"VideoPlayerEndBufferingNotification";
