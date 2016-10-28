//
//  BilibiliVideoPlayer.m
//  Bilibili
//
//  Created by LunarEclipse on 16/10/11.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "BilibiliVideoPlayer.h"

@import YYKit;
@import AVFoundation;

@interface BilibiliVideoPlayer ()

@property (nonatomic, strong) NSTimer * timer;

@property (nonatomic, assign) BOOL isDraggingSlider;

/* Full Screen */

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (weak, nonatomic) IBOutlet UIVisualEffectView *topContainterView;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *bottomContainerView;

/* Window */

@property (weak, nonatomic) IBOutlet UIButton *smallPlayButton;
@property (weak, nonatomic) IBOutlet UIView *widgetContainterView;

@end

@implementation BilibiliVideoPlayer

#pragma mark Initialization

- (instancetype)init
{
    if (self = [super init])
        [self initialize];
    return self;
}

/* Override */
-(void)initialize
{
    //Self
    self.clipsToBounds = NO;
    self.playerView.clipsToBounds = NO;
    
//    _endTimeLabel.text = [NSString stringWithFormat:@"%@", [self timeInterval2String:self.player.duration]];
    
    _progressView.progress = 0;
    
    _slider.value = 0;
    [_slider setThumbImage:[UIImage imageNamed:@"icmpv_thumb_light"] forState:UIControlStateNormal];
    
    /* -----Window----- */
    
    //添加渐变图层
    if (_widgetContainterView)
    {
        CAGradientLayer * gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = _widgetContainterView.bounds;
        gradientLayer.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor colorWithWhite:0 alpha:0.33].CGColor];
        gradientLayer.startPoint = CGPointMake(0.5, 0);
        gradientLayer.endPoint = CGPointMake(0.5, 1);
        gradientLayer.zPosition = -1;
        [_widgetContainterView.layer addSublayer:gradientLayer];
    }
}

#pragma mark Override

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self initialize];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) return;
    
    //Setup timer
    _timer = [NSTimer timerWithTimeInterval:0.4 target:self selector:@selector(monitorProgress) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

-(void)removeFromSuperview
{
    [super removeFromSuperview];
    
    // Removed from superview
    [self.timer invalidate];
    self.timer = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.hideWidgets = !self.hideWidgets;
    
    [super touchesEnded:touches withEvent:event];
}

-(void)play
{
    [super play];
    
    [_playButton setImage:[UIImage imageNamed:@"player_pause_iphone_fullscreen"] forState:UIControlStateNormal];
    [_smallPlayButton setImage:[UIImage imageNamed:@"player_pause_bottom_window"] forState:UIControlStateNormal];
}

-(void)pause
{
    [super pause];
    
    [_playButton setImage:[UIImage imageNamed:@"player_start_iphone_fullscreen"] forState:UIControlStateNormal];
    [_smallPlayButton setImage:[UIImage imageNamed:@"player_play_bottom_window"] forState:UIControlStateNormal];
}

-(void)hideWidgets:(BOOL)hideWidgets animated:(BOOL)isAnimated
{
    float duration = isAnimated ? 0.5 : 0;
    if (hideWidgets)
    {
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            _playButton.alpha = 0;
            _topContainterView.alpha = 0;
            _bottomContainerView.alpha = 0;
            _widgetContainterView.alpha = 0;
        } completion:^(BOOL finished) {
            
        }];
    }
    else
    {
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            _playButton.alpha = 1;
            _topContainterView.alpha = 1;
            _bottomContainerView.alpha = 1;
            _widgetContainterView.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }
}

#pragma mark Encapsulation

-(NSString *)timeInterval2String:(NSTimeInterval)interval//(s)
{
    return [NSString stringWithFormat:@"%02d:%02d", (int)interval / 60, (int)interval % 60];
}

#pragma mark Callback

-(void)monitorProgress
{
    _slider.value = self.player.currentPlaybackTime / self.player.duration;
    _progressView.progress = self.player.playableDuration / self.player.duration;
    
    _startTimeLabel.text = [NSString stringWithFormat:@"%@", [self timeInterval2String:self.player.currentPlaybackTime]];
    _endTimeLabel.text = [NSString stringWithFormat:@"%@", [self timeInterval2String:self.player.duration - self.player.currentPlaybackTime]];
}

#pragma mark IBAction

- (IBAction)onDragSliderStarted:(id)sender
{
    _isDraggingSlider = YES;
    _timer.fireDate = [NSDate distantFuture];
}

- (IBAction)onDraggingSlider:(id)sender
{
    if (_isDraggingSlider)
    {
        _startTimeLabel.text = [NSString stringWithFormat:@"%@", [self timeInterval2String:self.slider.value * self.player.duration]];
    }
}

- (IBAction)onDragSliderFinished:(id)sender
{
    _isDraggingSlider = NO;
    [self.player setCurrentPlaybackTime:self.slider.value * self.player.duration];
    _timer.fireDate = [NSDate date];
}

/* Full Screen */

- (IBAction)onClickBackButton:(id)sender
{
    [self onClickShrinkButton:nil];
}

- (IBAction)onClickChargeButton:(id)sender
{
    
}

- (IBAction)onClickCoinButton:(id)sender
{
    
}

- (IBAction)onClickShareButton:(id)sender
{
    
}

- (IBAction)onClickConfigButton:(id)sender
{
    
}

- (IBAction)onClickMoreButton:(id)sender
{
    
}

- (IBAction)onClickPlayButton:(id)sender
{
    if ([self.player isPlaying]) [self pause];
    else [self play];
}

- (IBAction)onClickAddDanmakuButton:(id)sender
{
    
}

- (IBAction)onClickHideDanmakuButton:(id)sender
{
    
}

- (IBAction)onClickVideoQualityButton:(id)sender
{
    
}

- (IBAction)onClickSelectEpisodeButton:(id)sender
{
    
}

- (IBAction)onClickLockButton:(id)sender
{
    
}

- (IBAction)onClickShrinkButton:(id)sender
{
    self.controller.fullscreen = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:VideoPlayerEnterWindowNotification object:self];
}

/* Window */

- (IBAction)onClickSmallPlayButton:(id)sender
{
    [self onClickPlayButton:_smallPlayButton];
}

- (IBAction)onClickFullScreenButton:(id)sender
{
    self.controller.fullscreen = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:VideoPlayerEnterFullscreenNotification object:self];
}

@end
