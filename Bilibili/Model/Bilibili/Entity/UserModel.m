//
//  UserModel.m
//  Weibo
//
//  Created by LunarEclipse on 16/6/29.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "UserModel.h"
#import "YYKit.h"

#define YYKIT_CODING \
- (void)encodeWithCoder:(NSCoder *)aCoder { [self modelEncodeWithCoder:aCoder]; } \
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self modelInitWithCoder:aDecoder]; } \
- (id)copyWithZone:(NSZone *)zone { return [self modelCopy]; } \
- (NSUInteger)hash { return [self modelHash]; } \
- (BOOL)isEqual:(id)object { return [self modelIsEqual:object]; } \
- (NSString *)description { return [self modelDescription]; }

@implementation UserModel

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"name" : @[@"name", @"uname"],
             @"face" : @[@"face", @"avatar"],
             @"_friend" : @"friend",
             @"_description" : @"description"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"attentions" : [NSNumber class]};
}

YYKIT_CODING

@end


@implementation LevelModel

YYKIT_CODING

@end


@implementation PendantModel

YYKIT_CODING

@end


@implementation VipModel

YYKIT_CODING

@end


@implementation NameplateModel

YYKIT_CODING

@end

@implementation OfficialVerifyModel

YYKIT_CODING

@end


@implementation SimpleUserModel

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"name" : @[@"name", @"uname"]};
}

@end
