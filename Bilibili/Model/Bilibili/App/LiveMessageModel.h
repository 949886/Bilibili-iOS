//
//  LiveMessageModel.h
//  Bilibili
//
//  Created by LunarEclipse on 16/10/25.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LiveMessageModel;

@interface LiveMessagesModel : NSObject

//@property (nonatomic, strong) NSArray *admin;

@property (nonatomic, strong) NSArray<LiveMessageModel *> * messages;

@end

@interface LiveMessageModel : NSObject

@property (nonatomic, assign) NSInteger vip;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, assign) NSInteger svip;
@property (nonatomic, assign) NSInteger teamid;
@property (nonatomic, assign) NSInteger rnd;

@property (nonatomic, assign) NSInteger isadmin;
@property (nonatomic, assign) NSInteger rank;
@property (nonatomic, assign) NSInteger guard_level;

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *timeline;
@property (nonatomic, copy) NSString *user_title;

@property (nonatomic, strong) NSArray<NSString *> *user_level;
@property (nonatomic, strong) NSArray<NSString *> *title;
@property (nonatomic, strong) NSArray<NSString *> *medal;

@end

/*
 {
 "text": "p站",
 "uid": 32755300,
 "nickname": "是金鱼总会发光",
 "timeline": "2016-10-25 13:35:10",
 "isadmin": 1,
 "vip": 0,
 "svip": 0,
 "medal": [
 8,
 "肉哒",
 "洛达",
 43088,
 2146033
 ],
 "title": [
 "ice-dust"
 ],
 "user_level": [
 22,
 0,
 12108287,
 ">50000"
 ],
 "rank": 10000,
 "teamid": 0,
 "rnd": 394656613,
 "user_title": "title-48-1",
 "guard_level": 0
 }
 */

