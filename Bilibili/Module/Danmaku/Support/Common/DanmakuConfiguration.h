//
//  DanmakuConfiguration.h
//  Danmaku
//
//  Created by LunarEclipse on 16/9/9.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "DanmakuFilter.h"

#define DEFAULT_FONT_SCALE 0.66

@import UIKit;

@class DanmakuVisibility;

typedef NS_ENUM(NSInteger, DanmakuStyle)
{
    DanmakuStyleNone =  0,         // 无
    DanmakuStyleStroken = 1 << 0,      // 描边
    DanmakuStyleShadow = 1 << 1       // 阴影
//    DanmakuStyleProjection = 1 << 2    // 投影（不支持）
};


@interface DanmakuConfiguration : NSObject

@property (nonatomic, assign) DanmakuStyle danmakuStyle;
@property (nonatomic, strong) DanmakuVisibility * danmakuVisibility;
@property (nonatomic, strong) DanmakuFilter * danmakuFilter;

@property (nonatomic, strong) NSParagraphStyle * paragraphStyle;

@property (nonatomic, strong) UIFont * danmakuFont;     //Default is STHeitiSC-Medium, font size will not work.
@property (nonatomic, assign) int maximumDanmakus;    //Max danmaku count that can be shown in screen(<0 is no limit, default is 40).

@property (nonatomic, assign) float speedFactor;
@property (nonatomic, assign) float fontScaleFactor;

@property (nonatomic, assign) float strokeWidth;        //Default is -5.
@property (nonatomic, strong) UIColor * strokeColor;    //Default [white 0.5, ahpha 1].
@property (nonatomic, strong) NSShadow * shadow;

+ (instancetype)defaultConfiguration;

@end

@class Danmaku;

@interface DanmakuVisibility : NSObject

@property (nonatomic, assign) BOOL RL;
@property (nonatomic, assign) BOOL LR;
@property (nonatomic, assign) BOOL top;
@property (nonatomic, assign) BOOL bottom;
@property (nonatomic, assign) BOOL special; //Not supportted.
@property (nonatomic, assign) BOOL script;  //Not supportted.

-(BOOL)filt:(Danmaku *)danmaku;

@end
