//
//  SecretConstants.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/2.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#ifndef SecretConstants_h
#define SecretConstants_h

#define PLATFORM  @"ios"
#define DEVICE ([[UIDevice currentDevice].model isEqualToString:@"iPad"] ? @"pad" : @"phone")

#define APP_KEY @"86385cdc024c0f6c"
#define ACCESS_KEY @"bb414b00fc0465fdd879e3ac09f80be8"
#define SIGN @"6e459ab22503751d6083cca0e712474b"
#define TS @"1467671646"

#define LIVE_APP_KEY @"27eb53fc9058f8c3"
#define LIVE_ACCESS_KEY @"99d02371222f07c14779faf9193c7bdf"
#define LIVE_SIGN @"54b5fe76ce29f5f4052941a61a158a21"
#define LIVE_TS @"1467674346"

#endif /* SecretConstants_h */
