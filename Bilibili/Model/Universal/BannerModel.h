//
//  BannerModel.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/5.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

/* 首页图片轮播中一个BannerModel代表一条横幅 */

#import <Foundation/Foundation.h>

@class WebImage;

@interface BannerModel : NSObject

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * url;
@property (nonatomic, copy) NSString * imageurl;
@property (nonatomic, copy) NSString * imagekey;

@property (nonatomic, copy) NSString * style;
@property (nonatomic, copy) NSString * remark;
@property (nonatomic, copy) NSString * type;        //bangumi:番剧 weblink:网页 apk:游戏广告

@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger width;

/* 游戏广告额外数据 */
@property (nonatomic, copy) NSString * apkurl;
@property (nonatomic, copy) NSString * _description;

@property (nonatomic, assign) NSInteger apksize;

@property (nonatomic, copy) NSArray<WebImage *> * image_list;

@end
