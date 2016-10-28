//
//  LiveModel.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/5.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserModel.h"
#import "WebImage.h"

@interface LiveModel : NSObject

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * area;            //直播分区，如绘画专区、生活娱乐、电子竞技等
@property (nonatomic, copy) NSString * playurl;         //直播flv播放地址

@property (nonatomic, copy) NSString * accept_quality;  //好像并没有什么用

@property (nonatomic, assign) NSInteger room_id;
@property (nonatomic, assign) NSInteger area_id;
@property (nonatomic, assign) NSInteger online;         //在线人数

@property (nonatomic, assign) NSInteger check_version;
@property (nonatomic, assign) NSInteger broadcast_type;

@property (nonatomic, strong) WebImage * cover;
@property (nonatomic, strong) UserModel * owner;

@end
