//
//  PlayURLModel.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/3.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DownloadURL;

@interface PlayURLModel : NSObject

@property (nonatomic, copy) NSString * from;
@property (nonatomic, copy) NSString * result;
@property (nonatomic, copy) NSString * format;
@property (nonatomic, copy) NSString * accept_format;
@property (nonatomic, copy) NSString * seek_param;
@property (nonatomic, copy) NSString * seek_type;

@property (nonatomic, assign) NSInteger timelength;
@property (nonatomic, assign) NSInteger ad_check;

@property (nonatomic, copy) NSArray<DownloadURL *> * durl;
@property (nonatomic, copy) NSArray<NSNumber *> * accept_quality;

-(NSString *)URL;
-(NSArray *)backupURL;

@end


@interface DownloadURL : NSObject

@property (nonatomic, copy) NSString * url;
@property (nonatomic, copy) NSArray<NSString *> * backup_url;

@property (nonatomic, assign) NSInteger order;
@property (nonatomic, assign) NSInteger length; //时间长度
@property (nonatomic ,assign) NSInteger size;   //文件大小

@end