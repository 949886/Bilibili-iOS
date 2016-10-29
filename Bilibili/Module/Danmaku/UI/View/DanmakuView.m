//
//  DanmakuView.m
//  Danmaku
//
//  Created by LunarEclipse on 16/9/9.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "DanmakuView.h"
#import "DanmakuTrack.h"

@interface DanmakuView()

@property (nonatomic, strong) Danmakus * danmakus;
@property (nonatomic, strong) DanmakuTracks * danmakuTracks;

@property (nonatomic, copy) NSMutableArray * reusableLayers;

@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, assign) NSTimeInterval startTime;
@property (nonatomic, assign) NSTimeInterval previousTime;
@property (nonatomic, assign) NSTimeInterval elapsedTime;

@property (nonatomic, strong) dispatch_semaphore_t semaphore;

@end

@implementation DanmakuView

#pragma mark Initialization

- (instancetype)init
{
    if (self = [super init])
        [self initialize];
    return self;
}

-(void)initialize
{
    self.layer.masksToBounds = YES;
    
    _reusableLayers = [NSMutableArray new];
    
    _parser = BILIBILI_PARSER;
    _config = [DanmakuConfiguration defaultConfiguration];
    
    _danmakuTracks = [DanmakuTracks new];
    
    _semaphore = dispatch_semaphore_create(1);
}

#pragma mark Override

-(void)removeFromSuperview
{
    [super removeFromSuperview];
    
    [_timer invalidate];
    _timer = nil;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
}

#pragma mark Methods

-(void)prepare:(DanmakuParser *)parser config:(DanmakuConfiguration *) config
{
    self.parser = parser;
    self.config = config;
}


-(void)loadDanmakus:(Danmakus *)danmakus
{
    _danmakus = danmakus;
}

-(void)addDanmaku:(Danmaku *)danmaku
{
    [self draw:danmaku];
}

-(void)removeAllDanmakus
{
    
}

-(void)removeAllVisiableDanmakus
{
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    for (DanmakuLayer * layer in _reusableLayers)
        [layer removeFromSuperlayer];
    
    [_reusableLayers removeAllObjects];
    
    dispatch_semaphore_signal(_semaphore);
}


-(void)start
{
    if(_timer != nil) return;
    
    _timer = [NSTimer timerWithTimeInterval:0.2 target:self selector:@selector(drawDanmakus) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    _startTime = [NSDate date].timeIntervalSince1970;
}

-(void)stop
{
    [_timer invalidate];
    _timer = nil;
}

-(void)pause
{
    if(_isPaused) return;
        
    for (CATextLayer * textLayer in self.visiableDanmakus)
        [self pauseLayer:textLayer];
    
    _timer.fireDate = [NSDate distantFuture];
    
    _isPaused = YES;
}

-(void)resume
{
    if(!_isPaused) return;
    
    for (CATextLayer * textLayer in self.visiableDanmakus)
        [self resumeLayer:textLayer];
    
    _timer.fireDate = [NSDate date];
    
    _isPaused = NO;
}

-(void)hide
{
    self.hidden = YES;
}

-(void)show
{
    self.hidden = NO;
}

-(void)setCurrentTime:(double)time
{
    _startTime = [NSDate date].timeIntervalSince1970 - time;
    _previousTime = time;
}

#pragma mark Getter & Setter

-(NSArray *)visiableDanmakus
{
    NSMutableArray * array = [NSMutableArray new];
    
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    for (DanmakuLayer * layer in _reusableLayers) {
        if (layer.superlayer) [array addObject:layer];
    }
    dispatch_semaphore_signal(_semaphore);
    
    return array;
}


#pragma mark Encapsulation

-(DanmakuLayer *)dequeueReusableLayer
{
    
    DanmakuLayer * layer = nil;
    for (layer in _reusableLayers)
        if (!layer.superlayer)
            return layer;
    
    //If there are not reusable layer, create a new one.
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    layer = [DanmakuLayer danmakuLayerWithDanmaku:nil configuration:_config];
    [_reusableLayers addObject:layer];
    dispatch_semaphore_signal(_semaphore);
    
    return layer;
}

-(void)draw:(Danmaku *)danmaku
{
    DanmakuLayer * layer = [self dequeueReusableLayer];
    layer.danmaku = danmaku;
    
//    [self dispatchDanmakuTracks:layer];
    [_danmakuTracks dispatchTrack:layer inDanmakuView:self];
    [self.layer addSublayer:layer];
//    if ([danmaku.text isEqualToString:@"aaaaaa"]) {
//        NSLog(@"%@", NSStringFromCGRect(layer.frame));
//        NSLog(@"%@", @(self.bounds.size.width / danmaku.speed));
//        NSLog(@"%@", layer.animationKeys);
//
//    }
    
    float duration = self.bounds.size.width / danmaku.speed;    
    
    switch (danmaku.type)
    {
        case DanmakuTypeRL:
        {
//            [CATransaction begin];
//            [CATransaction setAnimationDuration:duration];
//            [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear]];
//            [CATransaction setCompletionBlock:^{
//                [layer removeFromSuperlayer];
//                [layer setPositionWithoutImpliciteAnimation:CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX)];
//            }];
//            layer.frame = CGRectMake(-layer.bounds.size.width, layer.frame.origin.y, layer.bounds.size.width, layer.bounds.size.height);
//            [CATransaction commit];
            
            [CATransaction begin];
            CABasicAnimation * animation = [CABasicAnimation animation];
            animation.duration = duration;
            animation.keyPath = @"position";
//            animation.fromValue = [NSValue valueWithCGPoint:layer.frame.origin];
            animation.toValue = [NSValue valueWithCGPoint:CGPointMake(-layer.bounds.size.width, layer.frame.origin.y)];
            animation.fillMode = kCAFillModeBoth;
            [CATransaction setCompletionBlock:^{
                    [layer removeFromSuperlayer];
//                    [layer setPositionWithoutImpliciteAnimation:CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX)];
            }];
            [layer addAnimation:animation forKey:@"position"];
            [CATransaction commit];

        } break;
        case DanmakuTypeLR:
        {
//            [CATransaction begin];
//            [CATransaction setAnimationDuration:duration];
//            [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear]];
//            [CATransaction setCompletionBlock:^{
//                [layer removeFromSuperlayer];
//                [layer setPositionWithoutImpliciteAnimation:CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX)];
//            }];
//            layer.frame = CGRectMake(self.bounds.size.width, layer.frame.origin.y, layer.bounds.size.width, layer.bounds.size.height);
//            [CATransaction commit];
            
            [CATransaction begin];
            CABasicAnimation * animation = [CABasicAnimation animation];
            animation.duration = duration;
            animation.keyPath = @"position";
//            animation.fromValue = [NSValue valueWithCGPoint:layer.frame.origin];
            animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.bounds.size.width, layer.frame.origin.y)];
            animation.fillMode = kCAFillModeBoth;
            [CATransaction setCompletionBlock:^{
                [layer removeFromSuperlayer];
                //                    [layer setPositionWithoutImpliciteAnimation:CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX)];
            }];
            [layer addAnimation:animation forKey:@"position"];
            [CATransaction commit];
        } break;
        case DanmakuTypeBottom:
        case DanmakuTypeTop:
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [layer removeFromSuperlayer];
                [layer setPositionWithoutImpliciteAnimation:CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX)];
            });
        } break;
        default: break;
    }
}

-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

-(void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

#pragma mark Callback

-(void)drawDanmakus
{
    if (!_danmakus) return;
    
    NSTimeInterval currentTime = [NSDate date].timeIntervalSince1970 - _startTime;
    NSTimeInterval previousTime = _previousTime;
    
    _elapsedTime = currentTime - previousTime;
    
    Danmakus * sub = [_danmakus subWithStartTime:previousTime endTime:currentTime];
    for (Danmaku * danmaku in sub.danmakus)
        if([_config.danmakuVisibility filt:danmaku])
            [self draw:danmaku];
    
    _previousTime = currentTime;
}

@end
