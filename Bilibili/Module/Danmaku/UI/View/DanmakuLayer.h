//
//  DanmakuLayer.h
//  Danmaku
//
//  Created by LunarEclipse on 16/9/27.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "Danmaku.h"
#import "DanmakuConfiguration.h"

@import UIKit;

@interface DanmakuLayer : CATextLayer

@property (nonatomic, strong) NSMutableAttributedString * attributedString;

@property (nonatomic, strong) Danmaku * danmaku;
@property (nonatomic, strong) DanmakuConfiguration * config;

@property (nonatomic, assign) NSInteger track;

+(instancetype)danmakuLayerWithDanmaku:(Danmaku *)danmaku configuration:(DanmakuConfiguration *)config;
-(instancetype)initWithDanmaku:(Danmaku *)danmaku configuration:(DanmakuConfiguration *)config;

-(void)setPositionWithoutImpliciteAnimation:(CGPoint)position;

@end
