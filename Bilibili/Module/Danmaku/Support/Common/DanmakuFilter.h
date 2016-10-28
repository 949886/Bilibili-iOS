//
//  DanmakuFilter.h
//  Danmaku
//
//  Created by LunarEclipse on 16/9/27.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DanmakuFilter : NSObject

@property (nonatomic, copy) NSArray * colorBlackList;   //Available type: NSRange, NSNumber.
@property (nonatomic, copy) NSArray * colorWhiteList;   //ditto..
@property (nonatomic, copy) NSArray * userHashBlackList;    //Available type: NSNumber.
@property (nonatomic, copy) NSArray * userHashWhiteList;    //ditto.

@end
