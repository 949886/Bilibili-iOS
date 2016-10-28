//
//  Danmakus.h
//  Danmaku
//
//  Created by LunarEclipse on 16/9/9.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Danmaku.h"

@interface Danmakus : NSObject

@property (nonatomic, copy) NSArray<Danmaku *> * danmakus;
@property (nonatomic, copy, readonly) NSArray<Danmaku *> * sortedDanmakus;

-(void)addDanmaku:(Danmaku *)danmaku;

-(Danmakus *)subWithStartTime:(double)startTime endTime:(double)endTime;

@end
