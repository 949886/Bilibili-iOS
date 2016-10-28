//
//  AccountManager.h
//  Weibo
//
//  Created by LunarEclipse on 16/6/29.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AccountModel.h"

@interface AccountManager : NSObject

@property (nonatomic, readonly) NSArray<AccountModel *> * accounts;
@property (nonatomic, readonly) AccountModel * currentAccount;
@property (nonatomic, readonly) BOOL isLogin;

+ (instancetype)manager;

- (void)addAccount:(AccountModel *)account;
- (void)deleteAccount:(AccountModel *)account;

@end
