//
//  DanmakuParser.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/9.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "DanmakuParser.h"
#import "DanmakuUtils.h"

@implementation DanmakuParser

+ (instancetype)instance
{
    static DanmakuParser  * _instance = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

+ (Danmakus *)parse:(NSString *)xml
{
    NSData * data = [xml dataUsingEncoding:NSUTF8StringEncoding];
    NSXMLParser * parser = [[NSXMLParser alloc]initWithData:data];
    DanmakuParser * delegate = [self new];
    parser.delegate = delegate;
    NSDate *date = [NSDate date];
     [parser parse];
    NSLog(@"%f", -[date timeIntervalSinceNow]);
    return delegate.result;
}

- (instancetype)init
{
    if (self = [super init])
    {
        _result = [Danmakus new];
    }
    return self;
}

@end
