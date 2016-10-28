//
//  DanmakuTrack.m
//  Danmaku
//
//  Created by LunarEclipse on 16/9/29.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "DanmakuTrack.h"
#import "DanmakuView.h"

#define MAX_RL 12
#define MAX_LR 12
#define MAX_TOP 8
#define MAX_BOTTOM 8

#pragma mark - DanmakuTrack

@interface DanmakuTrack ()

@end

@implementation DanmakuTrack

- (instancetype)init
{
    if (self = [super init])
        [self initialize];
    return self;
}

- (instancetype)initWithType:(DanmakuTrackType)type index:(int)index
{
    if (self = [self init])
    {
        _type = type;
        _index =index;
    }
    return self;
}

+ (instancetype)danmakuTrackWithType:(DanmakuTrackType)type index:(int)index
{
    return [[DanmakuTrack alloc] initWithType:type index:index];
}

-(void)initialize
{
    _danmakuLayers = [NSMutableArray new];
}

-(float)height
{
    float height = 0.0;
    
    for (DanmakuLayer * layer in _danmakuLayers)
        height = MAX(height, layer.bounds.size.height);
    
    return height;
}

-(BOOL)isAvailable
{
    switch (_type)
    {
        case DanmakuTrackTypeRL:
        case DanmakuTrackTypeLR:
            for (DanmakuLayer * layer in _danmakuLayers)
            {
                CALayer * superlayer = layer.superlayer;
                CALayer * presentation = layer.presentationLayer;
                
//                NSLog(@"TRACK: %@", @(_index));
//                NSLog(@"1  %@", @(presentation.position.x));
//                NSLog(@"2  %@", @(presentation.bounds.size.width));
//                NSLog(@"3  %@", @(presentation.position.x + presentation.frame.size.width - superlayer.bounds.size.width));

                
                //For these layers that just be added to layer hierarchy, their presentation position will be CGPointZero.
                if (CGPointEqualToPoint(presentation.position, CGPointZero))
                    if (layer.position.x + layer.bounds.size.width > superlayer.bounds.size.width)
                        return NO;
                
                //For those layers already in animated, their presentation position is available (get presentation position must in UI thread).
                if (presentation.position.x + presentation.bounds.size.width > superlayer.bounds.size.width)
                    return NO;
            }
            return YES;
        case DanmakuTrackTypeTop:
        case DanmakuTrackTypeBottom:
            if (_danmakuLayers.count == 0) return YES;  //One track, one danmaku merely.
            return NO;
    }
}

@end


#pragma mark - DanmakuTracks

@interface DanmakuTracks ()

@property (nonatomic, strong) NSArray * visibleLayers;

@property (nonatomic, weak) DanmakuView * danmakuView;
@property (nonatomic, weak) DanmakuLayer * aDanmakuLayer;

@property (nonatomic, copy) NSMutableDictionary * rlTracks;
@property (nonatomic, copy) NSMutableDictionary * lrTracks;
@property (nonatomic, copy) NSMutableDictionary * topTracks;
@property (nonatomic, copy) NSMutableDictionary * bottomTracks;

@property (nonatomic, assign) NSUInteger maxRLTracks;
@property (nonatomic, assign) NSUInteger maxLRTracks;
@property (nonatomic, assign) NSUInteger maxTopTracks;
@property (nonatomic, assign) NSUInteger maxBottomTracks;

@property (nonatomic, copy) NSMutableArray * rlDanmakuLayers;
@property (nonatomic, copy) NSMutableArray * lrDanmakuLayers;
@property (nonatomic, copy) NSMutableArray * topDanmakuLayers;
@property (nonatomic, copy) NSMutableArray * bottomDanmakuLayers;

@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, strong) dispatch_semaphore_t semaphore;

@end

@implementation DanmakuTracks

- (instancetype)init
{
    if (self = [super init])
    {
        _maxRLTracks = MAX_RL;
        _maxLRTracks = MAX_LR;
        _maxTopTracks = MAX_TOP;
        _maxBottomTracks = MAX_BOTTOM;
        
        _rlTracks = [NSMutableDictionary new];
        _lrTracks = [NSMutableDictionary new];
        _topTracks = [NSMutableDictionary new];
        _bottomTracks = [NSMutableDictionary new];
        
        _queue = dispatch_queue_create("com.lunareclipse.danmaku", DISPATCH_QUEUE_SERIAL);
        _semaphore = dispatch_semaphore_create(1);
    }
    return self;
}

#pragma mark Methods

-(void)dispatchTrack:(DanmakuLayer *)layer inDanmakuView:(DanmakuView *)danmakuView
{
    _aDanmakuLayer = layer;
    _danmakuView = danmakuView;
    _visibleLayers = danmakuView.visiableDanmakus;

    [self analyzeDanmakuLayers];
    
    switch (layer.danmaku.type)
    {
        case DanmakuTypeRL:
        {
            DanmakuTrack * track = [self availableTrack:(NSInteger)layer.danmaku.type];
            layer.track = track.index;
            [layer setPositionWithoutImpliciteAnimation:CGPointMake(danmakuView.bounds.size.width, track.y)];
        } break;
        case DanmakuTypeLR:
        {
            DanmakuTrack * track = [self availableTrack:(NSInteger)layer.danmaku.type];
            layer.track = track.index;
            [layer setPositionWithoutImpliciteAnimation:CGPointMake(-layer.bounds.size.width, track.y)];
        } break;
        case DanmakuTypeTop:
        case DanmakuTypeBottom:
        {
            DanmakuTrack * track = [self availableTrack:(NSInteger)layer.danmaku.type];
            layer.track = track.index;
            [layer setPositionWithoutImpliciteAnimation:CGPointMake((danmakuView.bounds.size.width - layer.bounds.size.width) * 0.5 , track.y)];
        } break;
        default: break;
    }
}

-(void)asyncDispatchTrack:(DanmakuLayer *)layer inDanmakuView:(DanmakuView *)danmakuView complection:(void (^)())block
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(_queue, ^{
        __strong typeof(self) strongSelf = weakSelf;
        
        dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
        [strongSelf dispatchTrack:layer inDanmakuView:danmakuView];

        dispatch_sync(dispatch_get_main_queue(), ^{
            if(block) block();
            dispatch_semaphore_signal(_semaphore);
        });
    });
}

#pragma mark Encapsulation

-(DanmakuTrack *)availableTrack:(DanmakuTrackType)type
{
    // Not support Special Danmaku or Script Danmaku.
    
    NSInteger maxTracks = 0;
    switch (type)
    {
        case DanmakuTrackTypeRL: maxTracks = _maxRLTracks; break;
        case DanmakuTrackTypeLR: maxTracks = _maxLRTracks; break;
        case DanmakuTrackTypeTop: maxTracks = _maxTopTracks; break;
        case DanmakuTrackTypeBottom: maxTracks = _maxBottomTracks; break;
    }
    
    for (int i = 0; i < maxTracks; ++i)
    {
        DanmakuTrack * track = [self trackAtIndex:i type:type];
        
        if ([_aDanmakuLayer.danmaku.text isEqualToString:@"aaaaBa"]) {
            NSLog(@"%@ %@", @(i),@(track.isAvailable));
        }
        if (track.isAvailable) return track;
    }
    
    return nil;
}

-(void)analyzeDanmakuLayers
{
    _rlDanmakuLayers = [NSMutableArray new];
    _lrDanmakuLayers = [NSMutableArray new];
    _topDanmakuLayers = [NSMutableArray new];
    _bottomDanmakuLayers = [NSMutableArray new];
    
    if (_aDanmakuLayer.danmaku.type == DanmakuTypeBottom) 
        [self addLayer:_aDanmakuLayer];
    
    for (DanmakuLayer * layer in _visibleLayers)
        [self addLayer:layer];
    
    [self removePreviousTracksData];
    [self sortDanmakuLayers];
    [self caculateYPosition];
}

-(void)removePreviousTracksData
{
    for (int i = 0; i < _maxRLTracks; ++i)
        [[self trackAtIndex:i type:DanmakuTrackTypeRL].danmakuLayers removeAllObjects];
    for (int i = 0; i < _maxLRTracks; ++i)
        [[self trackAtIndex:i type:DanmakuTrackTypeLR].danmakuLayers removeAllObjects];
    for (int i = 0; i < _maxTopTracks; ++i)
        [[self trackAtIndex:i type:DanmakuTrackTypeTop].danmakuLayers removeAllObjects];
    for (int i = 0; i < _maxBottomTracks; ++i)
        [[self trackAtIndex:i type:DanmakuTrackTypeBottom].danmakuLayers removeAllObjects];
}

-(void)sortDanmakuLayers
{
    for (DanmakuLayer * layer in _rlDanmakuLayers)
    {
        if(layer.track < 0) continue;
        [[self trackAtIndex:layer.track type:DanmakuTrackTypeRL].danmakuLayers addObject:layer];
    }
    for (DanmakuLayer * layer in _lrDanmakuLayers)
    {
        if(layer.track < 0) continue;
        [[self trackAtIndex:layer.track type:DanmakuTrackTypeLR].danmakuLayers addObject:layer];
    }
    for (DanmakuLayer * layer in _topDanmakuLayers)
    {
        if(layer.track < 0) continue;
        [[self trackAtIndex:layer.track type:DanmakuTrackTypeTop].danmakuLayers addObject:layer];
    }
    for (DanmakuLayer * layer in _bottomDanmakuLayers)
    {
        for (int i = 0; i < _maxBottomTracks; ++i)
        {
            DanmakuTrack * track = [self trackAtIndex:i type:DanmakuTrackTypeBottom];
            if (track.isAvailable)
            {
                layer.track = track.index;
                break;
            }
        }
        [[self trackAtIndex:layer.track type:DanmakuTrackTypeBottom].danmakuLayers addObject:layer];
    }
}

-(void)caculateYPosition
{
    if(_rlDanmakuLayers.count != 0)
        for (int i = 0; i < _maxRLTracks; ++i)
        {
            float y = 0.0;
            for (int j = 0; j < i; ++j)
                y += [self trackAtIndex:j type:DanmakuTrackTypeRL].height;
            [self trackAtIndex:i type:DanmakuTrackTypeRL].y = y;
        }
    
    if(_lrDanmakuLayers.count != 0)
        for (int i = 0; i < _maxLRTracks; ++i)
        {
            float y = 0.0;
            for (int j = 0; j < i; ++j)
                y += [self trackAtIndex:j type:DanmakuTrackTypeLR].height;
            [self trackAtIndex:i type:DanmakuTrackTypeLR].y = y;
        }
    
    if(_topDanmakuLayers.count != 0)
        for (int i = 0; i < _maxTopTracks; ++i)
        {
            float y = 0.0;
            for (int j = 0; j < i; ++j)
                y += [self trackAtIndex:j type:DanmakuTrackTypeTop].height;
            [self trackAtIndex:i type:DanmakuTrackTypeTop].y = y;
        }
    
    if(_bottomDanmakuLayers.count != 0)
        for (int i = 0; i < _maxBottomTracks; ++i)
        {
            float y = 0.0;
            for (int j = 0; j < i; ++j)
                y += [self trackAtIndex:j type:DanmakuTrackTypeBottom].height;
            DanmakuTrack * track = [self trackAtIndex:i type:DanmakuTrackTypeBottom];
            track.y = _danmakuView.bounds.size.height - track.height - y;
        }
}

-(DanmakuTrack *)trackAtIndex:(NSUInteger)index type:(DanmakuTrackType)type
{
    switch (type)
    {
        case DanmakuTrackTypeRL:
            if(_rlTracks[@(index)] == nil)
                _rlTracks[@(index)] = [DanmakuTrack danmakuTrackWithType:type index:(int)index];
            return _rlTracks[@(index)];
        case DanmakuTrackTypeLR:
            if(_lrTracks[@(index)] == nil)
                _lrTracks[@(index)] = [DanmakuTrack danmakuTrackWithType:type index:(int)index];
            return _lrTracks[@(index)];
        case DanmakuTrackTypeTop:
            if(_topTracks[@(index)] == nil)
                _topTracks[@(index)] = [DanmakuTrack danmakuTrackWithType:type index:(int)index];
            return _topTracks[@(index)];
        case DanmakuTrackTypeBottom:
            if(_bottomTracks[@(index)] == nil)
                _bottomTracks[@(index)] = [DanmakuTrack danmakuTrackWithType:type index:(int)index];
            return _bottomTracks[@(index)];
    }
}

-(void)addLayer:(DanmakuLayer *)layer
{
    switch (layer.danmaku.type)
    {
        case DanmakuTypeRL:
            [_rlDanmakuLayers addObject:layer];
            break;
        case DanmakuTypeLR:
            [_lrDanmakuLayers addObject:layer];
            break;
        case DanmakuTypeTop:
            [_topDanmakuLayers addObject:layer];
            break;
        case DanmakuTypeBottom:
            [_bottomDanmakuLayers addObject:layer];
            break;
        default: break;
    }
}

@end
