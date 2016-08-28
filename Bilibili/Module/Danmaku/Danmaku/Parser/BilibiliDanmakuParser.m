//
//  BilibiliDanmakuParser.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/9.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "BilibiliDanmakuParser.h"

@implementation BilibiliDanmakuParser

+(void)parse
{
//    NSString * xml = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://comment.bilibili.com/1114146.xml"] encoding:NSUTF8StringEncoding error:nil];
    NSXMLParser * parser = [[NSXMLParser alloc]initWithContentsOfURL:[NSURL URLWithString:@"http://comment.bilibili.com/1114146.xml"]];
    parser.delegate = self;
    [parser parse];
    

}

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
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName
{
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
}

@end
