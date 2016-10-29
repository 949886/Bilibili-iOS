//
//  PlayerView.m
//  Bilibili
//
//  Created by LunarEclipse on 16/10/28.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "PlayerView.h"

@interface PlayerView ()

@property (nonatomic, copy) NSString * url;

@end

@implementation PlayerView

+ (instancetype)playerViewWithURL:(NSString *)url
{
    return [[PlayerView alloc] initWithURL:url];
}

- (instancetype)initWithURL:(NSString *)url
{
    if (self = [super init])
    {
        _url = url;
        [self setupIJKPlayer];
    }
    return self;
}

-(void)dealloc
{
    [_player.view removeFromSuperview];
    [_player shutdown];
    self.player = nil;
}

-(void)setupIJKPlayer
{
    IJKFFOptions * options = [IJKFFOptions optionsByDefault];
    [options setPlayerOptionValue:@"1" forKey:@"videotoolbox"];
    
    IJKFFMoviePlayerController * player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:_url withOptions:options];
    player.scalingMode = IJKMPMovieScalingModeAspectFit;
    [player prepareToPlay];
    self.player = player;
}

@end
