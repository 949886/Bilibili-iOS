//
//  VideoPlayerController.m
//  Bilibili
//
//  Created by LunarEclipse on 16/9/23.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "VideoPlayerController.h"
#import "DanmakuVideoPlayer.h"

@import YYKit;

@interface VideoPlayerController ()

@property (nonatomic, assign) VideoPlayerType type;

@property (nonatomic, strong) VideoPlayer * windowPlayer;
@property (nonatomic, strong) VideoPlayer * fullScreenPlayer;

@property (nonatomic, assign) BOOL notFirstTime;
@property (nonatomic, assign) BOOL hideStatusBar;

@end

@implementation VideoPlayerController

#pragma mark Initialization

-(instancetype)initWithType:(VideoPlayerType)type
{
    if (self = [super initWithNibName:nil bundle:nil])
    {
        _type = type;
        
        __weak typeof(self) weakSelf = self;
        
        switch (type)
        {
            case VideoPlayerDefault:
                _windowPlayer = [[NSBundle mainBundle] loadNibNamed:@"WindowVideoPlayer" owner:nil options:nil].firstObject;
                _fullScreenPlayer = [[NSBundle mainBundle] loadNibNamed:@"FullScreenVideoPlayer" owner:nil options:nil].firstObject;
                break;
            case VideoPlayerLive:
                _windowPlayer = [[NSBundle mainBundle] loadNibNamed:@"WindowLivePlayer" owner:nil options:nil].firstObject;
                _fullScreenPlayer = [[NSBundle mainBundle] loadNibNamed:@"FullScreenLivePlayer" owner:nil options:nil].firstObject;
                break;
        }
        
        _windowPlayer.controller = self;
        _fullScreenPlayer.controller = self;
        _fullScreenPlayer.onClick = ^(VideoPlayer * player){
            weakSelf.hideStatusBar = player.hideWidgets;
            [weakSelf setNeedsStatusBarAppearanceUpdate];
        };
        
        [self.view addSubview:_fullScreenPlayer];
        
//        _windowPlayer.frame = self.view.bounds;
//        _fullScreenPlayer.frame = self.view.bounds;
//
//        _windowPlayer.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//        _fullScreenPlayer.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
    }
    
    return self;
}

-(void)dealloc
{
    
}

#pragma mark Override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
}

- (BOOL)prefersStatusBarHidden
{
    return _hideStatusBar;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

/* 禁用屏幕旋转动画 */
//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
//{
//    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
//    [CATransaction begin];
//    [CATransaction setDisableActions:YES];
//    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
//        // You could make a call to update constraints based on the new orientation here.
//    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
//        [CATransaction commit];
//    }];
//}

#pragma mark Getter & Setter

-(VideoPlayer *)player
{
    if (_fullscreen)
        return _fullScreenPlayer;
    else return _windowPlayer;
}

-(void)setDanmakuView:(DanmakuView *)danmakuView
{
    if ([self.player isKindOfClass:[DanmakuVideoPlayer class]] ) {
        DanmakuVideoPlayer * player = (DanmakuVideoPlayer *)self.player;
        player.danmakuView = danmakuView;
    }
}

-(void)setFullscreen:(BOOL)fullscreen
{
    _fullscreen = fullscreen;
    
    __weak typeof(self) weakSelf = self;
    
    if (_fullscreen)
    {
        [_windowPlayer hideWidgets:YES animated:NO];

        CGRect rect = [UIScreen mainScreen].bounds;
        
        //动画，暂时有闪屏BUG，不采用
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.windowPlayer.playerView.transform = CGAffineTransformMakeRotation(M_PI_2);
            weakSelf.windowPlayer.playerView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
        }completion:^(BOOL finished) {
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self animated:NO completion:^{
                CGRect rect = [UIScreen mainScreen].bounds;
                
                weakSelf.windowPlayer.playerView.transform = CGAffineTransformIdentity;
                weakSelf.view.frame = rect;
                
                weakSelf.fullScreenPlayer.playerView = weakSelf.windowPlayer.playerView;
                weakSelf.fullScreenPlayer.frame = rect;
                weakSelf.fullScreenPlayer.player = weakSelf.windowPlayer.player;
                
                if ([weakSelf.windowPlayer isKindOfClass:[DanmakuVideoPlayer class]] &&
                    [weakSelf.fullScreenPlayer isKindOfClass:[DanmakuVideoPlayer class]]) {
                    DanmakuVideoPlayer * dvpw = (DanmakuVideoPlayer *)weakSelf.windowPlayer;
                    DanmakuVideoPlayer * dvpf = (DanmakuVideoPlayer *)weakSelf.fullScreenPlayer;
                    dvpf.danmakuView = dvpw.danmakuView;
                }
            }];
        }];
  
    }
    else
    {
        self.windowPlayer.playerView = self.fullScreenPlayer.playerView;
        self.windowPlayer.player = self.fullScreenPlayer.player;
        
        if ([weakSelf.windowPlayer isKindOfClass:[DanmakuVideoPlayer class]] &&
            [weakSelf.fullScreenPlayer isKindOfClass:[DanmakuVideoPlayer class]]) {
            DanmakuVideoPlayer * dvpw = (DanmakuVideoPlayer *)weakSelf.windowPlayer;
            DanmakuVideoPlayer * dvpf = (DanmakuVideoPlayer *)weakSelf.fullScreenPlayer;
            dvpw.danmakuView = dvpf.danmakuView;
        }
        
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

#pragma mark Methods

-(void)showInView:(UIView *)view
{
    if (_fullscreen && _notFirstTime)
    {
        [self dismissViewControllerAnimated:NO completion:nil];
        self.fullscreen = NO;
    }
    _notFirstTime = YES;
    
    [_windowPlayer showInView:view];
}

-(void)showInFullScreen
{
    if (!_fullscreen && _notFirstTime)
    {
        self.fullscreen = YES;
    }
    else return;
    
    _notFirstTime = YES;
    
}

#pragma mark Encapsulation

@end
