//
//  CommentModel.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/2.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentsModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"replies" : [CommentModel class],
             @"hots" : [CommentModel class]};
}

- (instancetype)init
{
    if (self = [super init]) {
        _page = [CommentsPage new];
        _hots = [NSMutableArray new];
        _replies = [NSMutableArray new];
    }
    return self;
}

@end

@implementation CommentsPage

@end

@implementation CommentModel

@end

@implementation CommentContent

@end

