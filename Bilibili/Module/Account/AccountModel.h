//
//  AccountModel.h
//  Weibo
//
//  Created by LunarEclipse on 16/6/29.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserModel.h"

@interface AccountModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) UserModel * user;
@property (nonatomic, strong) NSString * cookie;        //CookieValue
@property (nonatomic, assign) NSInteger expiresIn;      //必须有值，值为过期日期的时间戳

@end