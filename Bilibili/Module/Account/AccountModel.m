//
//  AccountModel.m
//  Weibo
//
//  Created by LunarEclipse on 16/6/29.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "AccountModel.h"

@import YYKit;

@implementation AccountModel

- (void)encodeWithCoder:(NSCoder *)aCoder { [self modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone { return [self modelCopy]; }
- (NSUInteger)hash { return [self modelHash]; }
- (BOOL)isEqual:(id)object { return [self modelIsEqual:object]; }
- (NSString *)description { return [self modelDescription]; }

@end


