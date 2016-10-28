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
#import "UserModel.h"

@class LevelModel;

@class CommentsPage, CommentModel;

@interface CommentsModel : NSObject

@property (nonatomic, strong) CommentsPage * page;
@property (nonatomic, strong) NSMutableArray<CommentModel *> * hots;
@property (nonatomic, strong) NSMutableArray<CommentModel *> * replies;

@end

@interface CommentsPage : NSObject

@property (nonatomic, assign) NSInteger num;
@property (nonatomic, assign) NSInteger account;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger size;

@end

@class CommentContent;

@interface CommentModel : NSObject

@property (nonatomic, assign) NSInteger floor;          //楼层
@property (nonatomic, assign) NSInteger like;           //赞
@property (nonatomic, assign) NSInteger count;          //回复数
@property (nonatomic, assign) NSInteger rcount;         //回复数
@property (nonatomic, assign) NSInteger ctime;          //时间戳
@property (nonatomic, assign) NSInteger oid;            //视频cid
@property (nonatomic, assign) NSInteger mid;
@property (nonatomic, assign) NSInteger rpid;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, assign) NSInteger parent;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger action;
@property (nonatomic, assign) NSInteger root;

@property (nonatomic, copy) NSString * rpid_str;
@property (nonatomic, copy) NSString * parent_str;
@property (nonatomic, copy) NSString * root_str;

//@property (nonatomic, strong) NSArray * replies;        

@property (nonatomic, strong) UserModel * member;       //评论用户
@property (nonatomic, strong) CommentContent *content;  //内容

@end

@interface CommentContent : NSObject

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *device;
@property (nonatomic, assign) NSInteger plat;

//@property (nonatomic, strong) NSArray * members;

@end

