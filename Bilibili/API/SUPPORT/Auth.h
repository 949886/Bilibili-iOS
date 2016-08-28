//
//  Auth.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/23.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Auth : NSObject

//B站8月份对视频地址API更换了签名加密算法（其他API未受影响）
+(NSString *)generateSign:(NSDictionary *)parameters;

@end
