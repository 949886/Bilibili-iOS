//
//  DanmakuView.h
//  Danmaku
//
//  Created by LunarEclipse on 16/9/9.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "Danmakus.h"
#import "DanmakuConfiguration.h"
#import "DanmakuLayer.h"

#import "AcfunDanmakuParser.h"
#import "BilibiliDanmakuParser.h"

#define ACFUN_PARSER [AcfunDanmakuParser instance]
#define BILIBILI_PARSER [BilibiliDanmakuParser instance]

@protocol DanmakuViewDelegate <NSObject>

-(void)prepared;
-(void)updateTime;
-(void)onDanmakuShown:(Danmaku *) danmaku;
-(void)onDrawingFinished;

@end

@interface DanmakuView : UIView

@property (nonatomic, weak) id <DanmakuViewDelegate> delegate;

@property (nonatomic, readonly) BOOL isPrepared;
@property (nonatomic, assign) BOOL isPaused;

@property (nonatomic, readonly) NSArray<DanmakuLayer *> * visiableDanmakus;

@property (nonatomic, strong) DanmakuParser * parser;
@property (nonatomic, strong) DanmakuConfiguration * config;

-(void)prepare:(DanmakuParser *)parser config:(DanmakuConfiguration *)config;

-(void)loadDanmakus:(Danmakus *)danmakus;
-(void)addDanmaku:(Danmaku *)danmaku;
-(void)removeAllDanmakus;
-(void)removeAllVisiableDanmakus;

-(void)start;
-(void)stop;
-(void)pause;
-(void)resume;

-(void)hide;
-(void)show;

@end
