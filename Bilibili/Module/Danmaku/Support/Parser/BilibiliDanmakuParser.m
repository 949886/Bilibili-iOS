//
//  BilibiliDanmakuParser.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/9.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "BilibiliDanmakuParser.h"

@interface BilibiliDanmakuParser ()

@end

@implementation BilibiliDanmakuParser

//分别开始解析时调用
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    
}
//结束解析时调用
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    
}

//分别解析到一个元素的开始和结束时调用
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict
{
    if ([elementName isEqualToString:@"d"])
    {
        NSString * valueString = attributeDict[@"p"];
        NSArray * values = [valueString componentsSeparatedByString:@","];
        
        if (values.count > 0)
            self.danmaku = [Danmaku danmakuWithValues:values];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName
{
    [self.result addDanmaku:self.danmaku];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    self.danmaku.text = string;
}

@end
