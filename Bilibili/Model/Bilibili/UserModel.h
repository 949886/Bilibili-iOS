//
//  UserModel.h
//  Weibo
//
//  Created by LunarEclipse on 16/6/29.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

/**
 *  API
 *  通过用户名(user)获取：http://api.bilibili.cn/userinfo?user=月蝕LunarEclipse
 *  通过用ID(mid)获取：http://api.bilibili.cn/userinfo?mid=17281
 */

#import <Foundation/Foundation.h>

@class LevelModel, PendantModel, NameplateModel;

@interface UserModel : NSObject

@property (nonatomic, copy) NSString * mid;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * sex;         //男, 女, 保密
@property (nonatomic, copy) NSString * face;        //高清头像URL（URL中斜杠/前都会一条反斜杠\）
@property (nonatomic, copy) NSString * sign;        //签名
@property (nonatomic, copy) NSString * _description;//->description

@property (nonatomic, assign) NSInteger fans;       //粉丝
@property (nonatomic, assign) NSInteger attention;  //关注数
@property (nonatomic, assign) NSInteger _friend;    //->friend
@property (nonatomic, assign) NSInteger rank;       //参考下方rank说明
@property (nonatomic, assign) NSInteger regtime;    //注册时间戳（自1970-1-1 00:00:00 GMT以来的秒数）
@property (nonatomic, assign) NSInteger article;
@property (nonatomic, assign) NSInteger spacesta;
@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) NSNumber * coins;

@property (nonatomic, strong) LevelModel * level_info;      //等级
@property (nonatomic, strong) PendantModel * pendant;       //
@property (nonatomic, strong) NameplateModel * nameplate;   //

@property (nonatomic, copy) NSArray<NSNumber *> * attentions;

@end


@interface LevelModel : NSObject

@property (nonatomic, assign) NSInteger current_level;      //当前等级
@property (nonatomic, assign) NSInteger current_exp;        //当前经验值
@property (nonatomic, assign) NSInteger current_min;        //当前等级最少需要的经验
@property (nonatomic, assign) NSInteger next_exp;           //到达下一级所需经验值

@end


//rank 说明 * 32000: 站长 – 有权限获取所有视频信息 (包括未通过审核和审核中的视频) * 31000: 职人 * 20000: 字幕君 – 有权限发送逆向弹幕 * 10000: 普通用户
