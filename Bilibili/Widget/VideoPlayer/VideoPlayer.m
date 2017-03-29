//
//  VideoPlayer.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/4.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "VideoPlayer.h"
#import "VideoPlayerStateView.h"
#import "VideoPlayerController.h"

@import YYKit;
@import AVFoundation;

typedef NS_ENUM(NSInteger, VideoPlayerGestureType)
{
    VideoPlayerGestureNone = 0,
    VideoPlayerGestureChangePlaybackTime,
    VideoPlayerGestureChangeBrightness,
    VideoPlayerGestureChangeVolume
};

@interface VideoPlayer ()

@property (nonatomic, assign) VideoPlayerGestureType gestureType;

@property (nonatomic, assign) BOOL isBuffering;
@property (nonatomic, assign) BOOL isShowingState;

@property (nonatomic, strong) UISlider * volumeSlider;
@property (nonatomic, strong) VideoPlayerStateView * videoPlayerStateView;

@end

@implementation VideoPlayer

#pragma mark Initialization

@synthesize player = _player;

- (instancetype)init
{
    if (self = [super init])
        [self initializeVideoPlayer];
    return self;
}

-(instancetype)initWithURL:(NSString *)url
{
    if (self = [self init])
    {
        [self initializeVideoPlayer];
        self.url = url;
    }
    return self;
}

+(instancetype)videoPlayerWithURL:(NSString *)url
{
    return [[VideoPlayer alloc]initWithURL:url];
}

-(void)initializeVideoPlayer
{
    _videoPlayerStateView = [VideoPlayerStateView defaultView];
    
    [self createGestureRecognizer];
    
    //Volume
    MPVolumeView * volumeView = [MPVolumeView new];
    for (UIView* view in volumeView.subviews)
        if ([view isKindOfClass:UISlider.class])
        {
            _volumeSlider = (UISlider*)view;
            break;
        }
    
    [IJKFFMoviePlayerController setLogLevel:k_IJK_LOG_SILENT];
}

//-(void)dealloc
//{
//    [_player.view removeFromSuperview];
//    [_player shutdown];
//    self.player = nil;
//}

#pragma mark Override

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self initializeVideoPlayer];
}

-(void)didMoveToSuperview
{
    [super didMoveToSuperview];
    [self registerObserver];
}

-(void)removeFromSuperview
{
    [super removeFromSuperview];
    [self unregisterObserver];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [super touchesEnded:touches withEvent:event];
    
    if (_onClick) _onClick(self);
}

#pragma mark Should Override

-(UIView *)playerContainer
{
    return nil;
}

#pragma mark Methods

-(void)play
{
    [_player play];
    [[NSNotificationCenter defaultCenter] postNotificationName:VideoPlayerPlayNotification object:self];
}

-(void)pause
{
    [_player pause];
    [[NSNotificationCenter defaultCenter] postNotificationName:VideoPlayerPauseNotification object:self];
}

-(void)stop
{
    [_player stop];
    [[NSNotificationCenter defaultCenter] postNotificationName:VideoPlayerStopNotification object:self];
}

-(void)shutdown
{
    [_player shutdown];
    [[NSNotificationCenter defaultCenter] postNotificationName:VideoPlayerShutdownNotification object:self];
}

-(void)showInView:(UIView *)view
{
    if (!view) return;
    
    if (self.superview)
        [self removeFromSuperview];
    
    self.frame = view.bounds;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [view addSubview:self];
    
    if (!_player.isPreparedToPlay) {
        _isShowingState = YES;
        _videoPlayerStateView.frame = self.bounds;
        [self addSubview:_videoPlayerStateView];
    }
}

-(void)hideWidgets:(BOOL)hideWidgets animated:(BOOL)isAnimated
{
    //To be overrided.
}

-(void)log:(NSString *)text
{
    if (_player.isPlaying) return;
    [_videoPlayerStateView log:text];
}

#pragma mark Getter & Setter

-(void)setUrl:(NSString *)url
{
    _url = url;
    
    if (_player)
    {
        [_player.view removeFromSuperview];
        [_player shutdown];
        self.player = nil;
    }
    
    [self setupPlayer];
}

-(void)setPlayerView:(UIView *)playerView
{
    _playerView = playerView;
    
    if (_playerView.superview)
        [_playerView removeFromSuperview];
    
    [self setupPlayerView];
}

-(void)setHideWidgets:(BOOL)hideWidgets
{
    _hideWidgets = hideWidgets;
    
    [self hideWidgets:hideWidgets animated:YES];
}

-(BOOL)isPreparedToPlay
{
    if(_player == nil) return NO;
    return _player.isPreparedToPlay;
}

#pragma mark Delegate

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
//{
//    if(_playerItem.status == AVPlayerItemStatusReadyToPlay)
//    {
//        
//    }
//}

/* UIGestureRecognizerDelegate */

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark Encapsulation

-(void)setupPlayer
{
//    IJKFFOptions * options = [IJKFFOptions optionsByDefault];
//    [options setPlayerOptionValue:@"1" forKey:@"videotoolbox"];
//    
//    IJKFFMoviePlayerController * player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:_url withOptions:options];
//    player.scalingMode = IJKMPMovieScalingModeAspectFit;
//    player.shouldAutoplay = _shouldAutoplay;
//    [player prepareToPlay];
//    self.player = player;
    
    self.playerView = [PlayerView playerViewWithURL:_url];
    self.player = self.playerView.player;
    self.player.shouldAutoplay = _shouldAutoplay;
    self.player.view.frame = self.playerView.bounds;
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.playerView addSubview:self.player.view];
    
    [self setupPlayerView];
    
    [self log:@"播放器准备完毕..."];
}

-(void)setupPlayerView
{
    UIView * playerContainer = [self playerContainer];
    if (playerContainer)
    {
        [playerContainer addSubview:self.playerView];
        self.playerView.frame = playerContainer.bounds;
    }
    else
    {
        [self addSubview:self.playerView];
        self.playerView.frame = self.bounds;
    }
    
    self.playerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

-(void)createGestureRecognizer
{
    //Double click.
    UITapGestureRecognizer * tapRecognizer = [UITapGestureRecognizer new];
    tapRecognizer.numberOfTapsRequired = 2;
    [tapRecognizer addTarget:self action:@selector(respondToTapGesture:)];
    [self addGestureRecognizer:tapRecognizer];
    
    //Pan
    UIPanGestureRecognizer * panRecognizer = [UIPanGestureRecognizer new];
    [panRecognizer addTarget:self action:@selector(respondToPanGesture:)];
    [self addGestureRecognizer:panRecognizer];
}

-(void)registerObserver
{
    //监听耳机设备
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(monitorEarphone:) name:AVAudioSessionRouteChangeNotification object:nil];
    
    //监听IJKPlayer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onIJKMPMoviePlayerLoadStateChanged:) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:nil];
}

-(void)unregisterObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)onBufferingStart
{
    //To be overrided...
    [[NSNotificationCenter defaultCenter] postNotificationName:VideoPlayerStartBufferingNotification object:self];
}

-(void)onBufferingEnd
{
    //To be overrided...
    [[NSNotificationCenter defaultCenter] postNotificationName:VideoPlayerEndBufferingNotification object:self];
}

#pragma mark Callback

-(void)monitorEarphone:(NSNotification *)notification
{
    NSInteger event = [notification.userInfo[AVAudioSessionRouteChangeReasonKey] integerValue];
    switch (event)
    {
        case AVAudioSessionRouteChangeReasonNewDeviceAvailable:
            break;
        case AVAudioSessionRouteChangeReasonOldDeviceUnavailable:
            if ([self.player isPlaying])
                [self.player pause];
            break;
        default: break;
    }
}

-(void)onIJKMPMoviePlayerLoadStateChanged:(NSNotification *)notification
{
    IJKFFMoviePlayerController * player = (IJKFFMoviePlayerController *)notification.object;
#ifdef DEBUG
    NSLog(@"%@", @(player.loadState));
#endif
    
    //Buffering...
    if (player.loadState == IJKMPMovieLoadStateStalled) //4
    {
        if(!_isBuffering) {
            _isBuffering = YES;
            [self onBufferingStart];
        }
    }
    
    //Is Ready to play...
    if (player.loadState == (IJKMPMovieLoadStatePlayable | IJKMPMovieLoadStatePlaythroughOK)) {
        [self log:@"准备播放..."];
        
        if (_isShowingState) {
            _isShowingState = NO;
            [_videoPlayerStateView removeFromSuperview];
            [self play];
        }
        
        if (_isBuffering) {
            _isBuffering = NO;
            [self onBufferingEnd];
        }
    }
}

-(void)respondToTapGesture:(UITapGestureRecognizer *)recognizer
{
    if ([self.player isPlaying])
        [self pause];
    else [self play];
}

-(void)respondToPanGesture:(UIPanGestureRecognizer *)recognizer
{
    CGPoint velocity = [recognizer velocityInView:recognizer.view];
    
    if (fabs(velocity.x) > fabs(velocity.y))
        [self respondToHorizontalPanGesture:recognizer];
    else [self respondToVerticalPanGesture:recognizer];
    
}

-(void)respondToHorizontalPanGesture:(UIPanGestureRecognizer *)recognizer
{
    //To be override...
}

-(void)respondToVerticalPanGesture:(UIPanGestureRecognizer *)recognizer
{
    CGPoint velocity = [recognizer velocityInView:recognizer.view];
    CGPoint point = [recognizer locationInView:recognizer.view];

    switch (recognizer.state)
    {
        case UIGestureRecognizerStateBegan:
            if (point.x < self.center.x)
                _gestureType = VideoPlayerGestureChangeBrightness;
            else _gestureType = VideoPlayerGestureChangeVolume;
            break;
        case UIGestureRecognizerStateChanged:
            if (_gestureType == VideoPlayerGestureChangeBrightness)
                [UIScreen mainScreen].brightness -= velocity.y * 0.00005;
            if (_gestureType == VideoPlayerGestureChangeVolume)
                _volumeSlider.value -= velocity.y * 0.00005;
            break;
        case UIGestureRecognizerStateEnded:
            _gestureType = VideoPlayerGestureNone;
            break;
        default: break;
    }
}

@end
