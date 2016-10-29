//
//  PlayerView.h
//  Bilibili
//
//  Created by LunarEclipse on 16/10/28.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

@import IJKMediaFramework;

@interface PlayerView : UIView

@property (nonatomic, strong) IJKFFMoviePlayerController * player;

+ (instancetype)playerViewWithURL:(NSString *)url;
- (instancetype)initWithURL:(NSString *)url;

@end
