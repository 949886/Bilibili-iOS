//
//  PlayURLModel.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/3.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "PlayURLModel.h"

@implementation PlayURLModel

+(NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"durl" : [DownloadURL class],
             @"accept_quality" : [NSNumber class]};
}

-(NSString *)URL
{
    if (_durl && _durl.firstObject.url)
        return _durl.firstObject.url;
    return nil;
}

-(NSArray *)backupURL
{
    if (_durl && _durl.firstObject.backup_url)
        return _durl.firstObject.backup_url;
    return nil;
}

@end

@implementation DownloadURL

+(NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"backup_url" : [NSString class]};
}

@end