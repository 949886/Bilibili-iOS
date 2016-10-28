//
//  EpisodeModel.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/3.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserModel;

@interface EpisodeModel : NSObject

@property (nonatomic, assign) NSInteger index;       //第几集
@property (nonatomic, assign) NSInteger av_id;
@property (nonatomic, assign) NSInteger episode_id;

@property (nonatomic, copy) NSString * cover;       //封面
@property (nonatomic, copy) NSString * index_title; //标题
@property (nonatomic, copy) NSString * update_time;
@property (nonatomic, copy) NSString * mid;

@property (nonatomic, copy) NSString * coins;
@property (nonatomic, copy) NSString * danmaku; //弹幕数

@property (nonatomic, assign) BOOL is_webplay;

@property (nonatomic, strong) UserModel * up;    //up主(B站投的就为空)

@end
