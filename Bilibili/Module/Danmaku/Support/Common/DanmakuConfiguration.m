//
//  DanmakuConfiguration.m
//  Danmaku
//
//  Created by LunarEclipse on 16/9/9.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "DanmakuConfiguration.h"
#import "Danmaku.h"

@implementation DanmakuConfiguration

+ (instancetype)defaultConfiguration
{
    static DanmakuConfiguration * _instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

#pragma mark Initialization

- (instancetype)init
{
    if (self = [super init])
        [self initialize];
    return self;
}

-(void)initialize
{
    _danmakuStyle = DanmakuStyleStroken;
    _danmakuFont = [UIFont fontWithName:@"STHeitiSC-Medium" size:16];   // [UIFont boldSystemFontOfSize:16]
    _danmakuVisibility = [DanmakuVisibility new];
    _danmakuFilter = [DanmakuFilter new];
    _paragraphStyle = [self defaultParagraphStyle];
    _maximumDanmakus = 40;
    _speedFactor = 1.0;
    _fontScaleFactor = DEFAULT_FONT_SCALE;
    _strokeWidth = -5;
    _strokeColor = [UIColor colorWithWhite:0.500 alpha:1.000];
    _shadow = [self defaultShadow];
}

#pragma mark Methods


#pragma mark Encapsulation

-(NSParagraphStyle *)defaultParagraphStyle
{
    NSMutableParagraphStyle * style = [NSMutableParagraphStyle new];
    style.lineSpacing = 0;
    style.lineHeightMultiple = 1;
    style.alignment = NSTextAlignmentLeft;
    return style;
}

-(NSShadow *)defaultShadow
{
    NSShadow * shadow = [NSShadow new];
    shadow.shadowBlurRadius = 3.0;
    shadow.shadowOffset = CGSizeMake(0, 2);
    shadow.shadowColor = [UIColor blackColor];
    return shadow;
}

@end


@implementation DanmakuVisibility

- (instancetype)init
{
    if (self = [super init])
    {
        _RL = YES;
        _LR = YES;
        _top = YES;
        _bottom = YES;
    }
    return self;
}

-(BOOL)filt:(Danmaku *)danmaku
{
    switch (danmaku.type)
    {
        case DanmakuTypeRL: return _RL;
        case DanmakuTypeLR: return _LR;
        case DanmakuTypeBottom: return _top;
        case DanmakuTypeTop: return _bottom;
        default: return NO;
    }
}

@end
