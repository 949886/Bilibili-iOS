//
//  BilibiliEnumeration.h
//  Bilibili
//
//  Created by LunarEclipse on 16/9/17.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#ifndef Enumerations_h
#define Enumerations_h

typedef NS_ENUM(NSInteger, VideoQuarityOptions)
{
    VideoQuarityLow = 1,    //流畅
    VideoQuarityNormal,     //高清
    VideoQuarityHigh,       //超清
    VideoQuarityHD
};

typedef NS_ENUM(NSInteger, BilibiliVideoType)
{
    BilibiliVideoTypeNormal = 1,
    BilibiliVideoTypeBangumi
};

#endif /* Enumerations_h */
