//
//  MPlayURLModel.h
//  Bilibili
//
//  Created by LunarEclipse on 16/8/25.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

//HTML5低清接口数据模型：http://www.bilibili.com/m/html5?aid=5976369&page=1

@interface MPlayURLModel : NSObject

@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *cid;
@property (nonatomic, copy) NSString *src;

@property (nonatomic, assign) NSInteger *code;
@property (nonatomic, copy) NSString *message;

@end
