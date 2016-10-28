//
//  DanmakuLayer.m
//  Danmaku
//
//  Created by LunarEclipse on 16/9/27.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "DanmakuLayer.h"

@interface DanmakuLayer ()

@property (nonatomic, assign) DanmakuStyle danmakuStyle;

@end

@implementation DanmakuLayer

+(instancetype)danmakuLayerWithDanmaku:(Danmaku *)danmaku configuration:(DanmakuConfiguration *)config
{
    return [[DanmakuLayer alloc] initWithDanmaku:danmaku configuration:config];
}

-(instancetype)initWithDanmaku:(Danmaku *)danmaku configuration:(DanmakuConfiguration *)config
{
    if (self = [super init])
    {
        self.anchorPoint = CGPointZero;
        self.masksToBounds = NO;
        self.rasterizationScale = 2;
        
        if (config) self.config = config;
        else self.config = [DanmakuConfiguration new];
        self.danmaku = danmaku;
        
        _track = -1;
    }
    return self;
}

-(void)setDanmaku:(Danmaku *)danmaku
{
    if (danmaku == nil || danmaku.text == nil) return;
    
    //Font & paragraph.
    NSMutableDictionary * attributes = @{NSFontAttributeName : [_config.danmakuFont fontWithSize:danmaku.fontSize * _config.fontScaleFactor],
                                         NSParagraphStyleAttributeName : _config.paragraphStyle,
                                         NSForegroundColorAttributeName : danmaku.textUIColor }.mutableCopy;
    
    //Shadow & stroke.
    _danmakuStyle = _config.danmakuStyle;
    
    BOOL stroke = _danmakuStyle & 1;
    BOOL shadow = _danmakuStyle & (1 << 1);
    
    if (stroke)
    {
        attributes[NSStrokeWidthAttributeName] = @(_config.strokeWidth);
        attributes[NSStrokeColorAttributeName] = _config.strokeColor;
    }
    
    self.shadowOpacity = shadow ? 1 : 0;
    self.shadowRadius = shadow ? _config.shadow.shadowBlurRadius : 0;
    self.shadowOffset = shadow ? _config.shadow.shadowOffset : CGSizeZero;
    self.shadowColor = shadow ? ((UIColor *)_config.shadow.shadowColor).CGColor : nil;
    self.shouldRasterize = shadow;
    
    _attributedString = [[NSMutableAttributedString alloc] initWithString:danmaku.text attributes:attributes];
        
    //Layer
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.frame = [_attributedString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading context:nil];
    self.alignmentMode = kCAAlignmentJustified;
    self.wrapped = YES;
    self.contentsScale = [UIScreen mainScreen].scale;
    self.string = _attributedString;
    [CATransaction commit];
    
    _danmaku = danmaku;
}

-(void)setPositionWithoutImpliciteAnimation:(CGPoint)position
{
    CGRect rect = CGRectMake(position.x, position.y, self.bounds.size.width, self.bounds.size.height);
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.frame = rect;
    [CATransaction commit];
    
//    if ([NSThread isMainThread]) {
//        ((CALayer *)self.presentationLayer).position = position;
//        [self setPositionWithoutImpliciteAnimationSynchronously:position];
//    }
//    else dispatch_sync(dispatch_get_main_queue(), ^{
//        [self setPositionWithoutImpliciteAnimationSynchronously:position];
//    });
}

//-(void)setPositionWithoutImpliciteAnimationSynchronously:(CGPoint)position
//{
//    CGRect rect = CGRectMake(position.x, position.y, self.bounds.size.width, self.bounds.size.height);
////    ((CALayer *)self.presentationLayer).frame = rect;
//
//    [CATransaction begin];
//    [CATransaction setDisableActions:YES];
//    self.frame = rect;
//    [CATransaction commit];
//}

@end
