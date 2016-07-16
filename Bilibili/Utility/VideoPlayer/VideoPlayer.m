//
//  VideoPlayer.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/4.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "VideoPlayer.h"

@import AVFoundation;

@interface VideoPlayer ()

@property (nonatomic, strong) AVPlayer * player;
@property (nonatomic, strong) AVPlayerItem * playerItem;

@property (nonatomic, strong) AVPlayerLayer * playerLayer;

@end

@implementation VideoPlayer

-(instancetype)initWithURL:(NSURL *)url
{
    if (self = [super init])
    {
        _view = [UIView new];
        
        AVAsset * asset = [AVAsset assetWithURL:url];
        _playerItem = [AVPlayerItem playerItemWithAsset:asset];
//        [_playerItem addObserver:self forKeyPath:@"status" options:0 context:nil];
        _player = [AVPlayer playerWithPlayerItem:_playerItem];
        
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        [_view.layer addSublayer:_playerLayer];
    }
    return self;
}

+(instancetype)videoPlayerWithURL:(NSURL *)url
{
    return [[VideoPlayer alloc]initWithURL:url];
}

-(void)showInView:(UIView *)view withRect:(CGRect)rect
{
    _view.frame = rect;
    _playerLayer.frame = rect;
    _view.backgroundColor = [UIColor orangeColor];
    [view addSubview:_view];
}

-(void)play
{
    [_player play];
}
-(void)pause
{
    
}
-(void)stop
{
    
}


#pragma mark Delegate

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
//{
//    if(_playerItem.status == AVPlayerItemStatusReadyToPlay)
//    {
//        
//    }
//}

@end
