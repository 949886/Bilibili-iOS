//
//  AccountManager.m
//  Weibo
//
//  Created by LunarEclipse on 16/6/29.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "AccountManager.h"

#define ACCOUNTS_KEY @"AccountsKey"
#define CURRENT_INDEX_KEY @"CurrentIndexKey"

@interface AccountManager ()

@property (nonatomic, assign) NSUInteger index;

@end

@implementation AccountManager

#pragma mark Singleton

+ (instancetype)manager
{
    static AccountManager *  _instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

#pragma mark Initialization

- (instancetype)init
{
    if (self = [super init]) {
        [self loadAccounts];
    }
    return self;
}

#pragma mark Methods

- (void)addAccount:(AccountModel *)account
{
    NSMutableArray * accounts = self.accounts.mutableCopy;
    [accounts addObject:[NSKeyedArchiver archivedDataWithRootObject:account]];
    
    [[NSUserDefaults standardUserDefaults] setValue:accounts forKey:ACCOUNTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)deleteAccount:(AccountModel *)account
{
    
}

#pragma mark Getter & Setter

-(NSArray<AccountModel *> *)accounts
{
    NSArray * array =[[NSUserDefaults standardUserDefaults] arrayForKey:ACCOUNTS_KEY];
    if(array == nil) array = [NSArray new];
    
    NSMutableArray * mArray = [NSMutableArray new];
    for (NSData * accountData in array) {
        AccountModel * account = [NSKeyedUnarchiver unarchiveObjectWithData:accountData];
        [mArray addObject:account];
    }
    
    return mArray;
}

-(AccountModel *)currentAccount
{
    if (self.accounts.count == 0)
        return nil;
    else if (self.index >= self.accounts.count)
    {
        self.index = 0;
        return [self.accounts firstObject];
    }
    else return self.accounts[self.index];
}

-(NSUInteger)index
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:CURRENT_INDEX_KEY];
}

-(void)setIndex:(NSUInteger)index
{
    [[NSUserDefaults standardUserDefaults] setValue:@(index) forKey:CURRENT_INDEX_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark Encapsulation

-(void)loadAccounts
{
#ifdef DEBUG
    if (self.currentAccount)
        NSLog(@"Auto-load account: %@", self.currentAccount.user.name);
    else NSLog(@"No account infomation.");
#endif
    
    //Load cookie.
    if(self.index < self.accounts.count)
    {
        NSString * cookieValue = self.accounts[self.index].cookie;
        NSInteger expiresIn = self.accounts[self.index].expiresIn;
        
        
        if(cookieValue && ![cookieValue isEqualToString:@""] && expiresIn)
        {
            NSDictionary * properties = @{NSHTTPCookieName : @"account",
                                          NSHTTPCookieValue : cookieValue,
                                          NSHTTPCookieDomain : @"bilibili.com",
                                          NSHTTPCookieOriginURL : @"bilibili.com",
                                          NSHTTPCookieExpires : @(expiresIn).stringValue,
                                          NSHTTPCookieVersion : @"1" };
            NSHTTPCookie * cookie = [NSHTTPCookie cookieWithProperties:properties];
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        }
    }
}

@end
