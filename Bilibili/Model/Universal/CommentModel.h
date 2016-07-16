//
//  CommentModel.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/2.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

/**
 *  API
 *  e.g. http://api.bilibili.com/feedback?ver=3&page=1&aid=12450&pagesize=20
 *  Parameters:
 *  ver API版本，最新是3 / aid 视频av号 / page 页码 / pagesize 一页返回数据个数[10, 300]
 */


#import <Foundation/Foundation.h>

@class LevelModel;

@interface CommentModel : NSObject

@property (nonatomic, copy) NSString * fbid;        //评论ID
@property (nonatomic, copy) NSString * lv;          //楼层
@property (nonatomic, copy) NSString * msg;
@property (nonatomic, copy) NSString * device;
@property (nonatomic, copy) NSString * create;
@property (nonatomic, copy) NSString * create_at;
@property (nonatomic, copy) NSString * good;
@property (nonatomic, assign) BOOL isgood;

@property (nonatomic, copy) NSString * mid;         //用户ID
@property (nonatomic, copy) NSString * nick;        //昵称
@property (nonatomic, copy) NSString * sex;
@property (nonatomic, copy) NSString * face;        //头像URL
@property (nonatomic, assign) NSInteger rank;       //参考UserModel中的rank说明

@property (nonatomic, assign) NSInteger reply_count;
@property (nonatomic, assign) NSInteger ad_check;   //状态(0:正常 1:UP主隐藏 2:管理员删除 3:因举报删除)

@property (nonatomic, strong) LevelModel * level_info;  //等级

@end
