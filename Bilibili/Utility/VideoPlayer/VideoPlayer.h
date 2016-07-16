//
//  VideoPlayer.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/4.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

@import UIKit;

@interface VideoPlayer : NSObject

@property (nonatomic, strong, readonly) UIView * view;

-(instancetype)initWithURL:(NSURL *)url;
+(instancetype)videoPlayerWithURL:(NSURL *)url;

-(void)showInView:(UIView *)view withRect:(CGRect)rect;

-(void)play;
-(void)pause;
-(void)stop;

@end
