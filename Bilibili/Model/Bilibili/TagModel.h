//
//  TagModel.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/6.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TagModel : NSObject

@property (nonatomic, copy) NSString * tag_id;
@property (nonatomic, copy) NSString * tag_name;
@property (nonatomic, copy) NSString * cover;
@property (nonatomic, copy) NSString * type;

@property (nonatomic, assign) NSInteger orderType;

@end
