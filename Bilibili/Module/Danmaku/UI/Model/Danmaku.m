//
//  DanmakuModel.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/2.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "Danmaku.h"

@implementation Danmaku

+ (Danmaku *)danmakuWithValues:(NSArray *)values
{
    Danmaku * danmaku = [self new];
    
    if(values.count > 0)
        danmaku.time = [values[0] doubleValue];
    if(values.count > 1)
        danmaku.type = [values[1] integerValue];
    if(values.count > 2)
        danmaku.fontSize = [values[2] floatValue];
    if(values.count > 3)
        danmaku.textColor = [values[3] integerValue];
    if(values.count > 4)
        danmaku.timestamp = [values[4] integerValue];
    if(values.count > 5)
        danmaku.poolID = [values[5] integerValue];
    if(values.count > 6)
        danmaku.userHash = strtoull([(NSString *)values[6] UTF8String], 0, 16);
    if(values.count > 7)
        danmaku.index = [values[7] longLongValue];
    
    return danmaku;
}

- (instancetype)init
{
    if (self = [super init])
    {
        _type = DanmakuTypeRL;
        _visibility = YES;
    }
    return self;
}

-(void)setText:(NSString *)text
{
    if (text == nil || text.length == 0 || [text containsString:@"\n"]) return;
    _text = text;
    _lines = [text componentsSeparatedByString:@"\n"].count;
}

-(float)speed
{
    switch (_type)
    {
        case DanmakuTypeRL:
        case DanmakuTypeLR:
            return BASE_SPEED * (1 + 0.05 * _text.length);
            break;
        default: return 0;
    }
}

-(UIColor *)textUIColor
{
    if (_textColor < (1 << 16)) // 65536 (0xFFFF)
    {
        unsigned int redMask = 0x0100;
        unsigned int greenMask = 0x0010;
        unsigned int blueMask = 0x0001;
        
        return [UIColor colorWithRed:(_textColor & redMask) >> 2
                               green:(_textColor & greenMask) >> 1
                                blue:_textColor & blueMask
                               alpha:1];
    }
    else //(Form: 0x00000000)
    {
        unsigned int redMask = 0x00110000;
        unsigned int greenMask = 0x00001100;
        unsigned int blueMask = 0x00000011;
        
        return [UIColor colorWithRed:(_textColor & redMask) >> 16
                               green:(_textColor & greenMask) >> 8
                                blue:_textColor & blueMask
                               alpha:1];
    }
}

@end
