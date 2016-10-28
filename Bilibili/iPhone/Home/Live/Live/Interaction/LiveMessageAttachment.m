//
//  LiveMessageAttachment.m
//  Bilibili
//
//  Created by LunarEclipse on 16/10/25.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "LiveMessageAttachment.h"

@implementation LiveMessageMedal

+(instancetype)defaultMedal
{
    LiveMessageMedal * view = [[NSBundle mainBundle] loadNibNamed:@"LiveMessageAttachment" owner:nil options:nil].firstObject;
    return view;
}

@end
