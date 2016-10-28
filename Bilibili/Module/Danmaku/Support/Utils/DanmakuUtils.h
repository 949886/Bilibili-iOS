//
//  DanmakuUtils.h
//  Danmaku
//
//  Created by LunarEclipse on 16/9/9.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DanmakuView.h"

@interface DanmakuUtils : NSObject

+ (void)fillText:(NSString *)text toDanmaku:(Danmaku *)danmaku;

+ (float)durationOfDanmaku:(Danmaku *)danmaku inDanmakuView:(DanmakuView *)view;
+ (CGSize)sizeOfDanmaku:(Danmaku *)danmaku withConfiguration:(DanmakuConfiguration *)config;

@end
