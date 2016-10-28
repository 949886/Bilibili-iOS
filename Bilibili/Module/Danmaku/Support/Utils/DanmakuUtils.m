//
//  DanmakuUtils.m
//  Danmaku
//
//  Created by LunarEclipse on 16/9/9.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "DanmakuUtils.h"

#define COMMON_DANMAKU_DURATION 3.8 //s
#define MIN_DANMAKU_DURATION 4.0
#define MAX_DANMAKU_DURATION 9.0

@implementation DanmakuUtils

+ (void)fillText:(NSString *)text toDanmaku:(Danmaku *)danmaku
{
    if (text == nil || text.length == 0 || [text containsString:@"\n"]) return;
    danmaku.text = text;
    danmaku.lines = [text componentsSeparatedByString:@"\n"].count;
}

+ (float)durationOfDanmaku:(Danmaku *)danmaku inDanmakuView:(DanmakuView *)view
{
    CGFloat danmakuWidth = [self sizeOfDanmaku:danmaku withConfiguration:view.config].width;
    CGFloat viewPortWidth = view.bounds.size.width;
    
    switch (danmaku.type)
    {
        case DanmakuTypeRL:
        case DanmakuTypeLR:
            return (danmakuWidth + viewPortWidth) / danmaku.speed;
            
        case DanmakuTypeBottom:
        case DanmakuTypeTop:
            return COMMON_DANMAKU_DURATION;
            
        case DanmakuTypeSpecial:
        case DanmakuTypeScript:
            return 0;
    }
    
    return 0;
}

+ (CGSize)sizeOfDanmaku:(Danmaku *)danmaku withConfiguration:(DanmakuConfiguration *)config
{
    NSDictionary * attributes = @{NSFontAttributeName : [config.danmakuFont fontWithSize:danmaku.fontSize]};
    CGRect rect = [danmaku.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    return rect.size;
}

@end
