//
//  NetworkManager.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/4.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

-(instancetype)init NS_UNAVAILABLE;

+(NetworkManager *)instance;

-(void)activate;

@end
