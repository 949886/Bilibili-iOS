//
//  VideoPlayerStateView.h
//  Bilibili
//
//  Created by LunarEclipse on 16/10/23.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoPlayerStateView : UIView

+(instancetype)defaultView;

-(void)log:(NSString *)text;    //写入加载状态
-(void)clear;

@end
