//
//  macro.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/7.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#ifndef macro_h
#define macro_h

#define RGB(RED, GREEN, BLUE) \
[UIColor colorWithRed:RED / 256.0 green:GREEN / 256.0 blue:BLUE / 256.0 alpha:1]
#define RGBA(RED, GREEN, BLUE, ALPHA) \
[UIColor colorWithRed:RED / 256.0 green:GREEN / 256.0 blue:BLUE / 256.0 alpha:ALPHA / 256.0]

#define IS_IPAD ([[[UIDevice currentDevice]model]isEqualToString:@"iPad"])
#define IS_IPHONE ([[[UIDevice currentDevice]model]isEqualToString:@"iPhone"])

#endif /* macro_h */
