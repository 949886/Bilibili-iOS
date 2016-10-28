//
//  BangumiRecommendModel.h
//  Bilibili
//
//  Created by LunarEclipse on 16/9/11.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BangumiRecommendModel : NSObject

@property (nonatomic, assign) u_int64_t cursor;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *reply;
@property (nonatomic, copy) NSString *desc;

@end
