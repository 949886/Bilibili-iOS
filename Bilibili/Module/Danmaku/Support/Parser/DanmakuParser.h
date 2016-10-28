//
//  DanmakuParser.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/9.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

//DO NOT use this class directly.

#import <Foundation/Foundation.h>

#import "Danmakus.h"

@interface DanmakuParser : NSObject <NSXMLParserDelegate>

@property (nonatomic, strong) Danmaku * danmaku;
@property (nonatomic, strong) Danmakus * result;

+ (instancetype)instance;

+ (Danmakus *)parse:(NSString *)xml;

@end
