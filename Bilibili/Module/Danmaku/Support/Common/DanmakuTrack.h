//
//  DanmakuTrack.h
//  Danmaku
//
//  Created by LunarEclipse on 16/9/29.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

/* 表示弹幕轨道 */

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DanmakuTrackType)
{
    DanmakuTrackTypeRL = 1,
    DanmakuTrackTypeLR = 6,
    DanmakuTrackTypeBottom = 4,
    DanmakuTrackTypeTop = 5
};

@protocol DanmakuTracksDelegate <NSObject>
@required
-(NSArray *)visiableDanmakus;
@end


@class DanmakuLayer, DanmakuView;

@interface DanmakuTrack : NSObject

@property (nonatomic, assign) int index;
@property (nonatomic, assign) DanmakuTrackType type;

@property (nonatomic, assign) float y;
@property (nonatomic, assign, readonly) float height;
@property (nonatomic, assign, readonly) BOOL isAvailable;

@property (nonatomic, copy) NSMutableArray * danmakuLayers;

- (instancetype)initWithType:(DanmakuTrackType)type index:(int)index;
+ (instancetype)danmakuTrackWithType:(DanmakuTrackType)type index:(int)index;

@end


@interface DanmakuTracks : NSObject

@property (nonatomic, weak) id <DanmakuTracksDelegate> delegate;

-(void)dispatchTrack:(DanmakuLayer *)layer inDanmakuView:(DanmakuView *)danmakuView;
-(void)asyncDispatchTrack:(DanmakuLayer *)layer inDanmakuView:(DanmakuView *)danmakuView complection:(void (^)()) block;

@end
