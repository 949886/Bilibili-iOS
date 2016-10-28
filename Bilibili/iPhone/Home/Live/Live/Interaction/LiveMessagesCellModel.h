//
//  LiveMessagesCellModel.h
//  Bilibili
//
//  Created by LunarEclipse on 16/10/25.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LiveMessageModel.h"
#import "LiveMessageAttachment.h"

#define LIVE_MESSAGES_MARGIN 12

@import YYKit;

@interface LiveMessagesCellModel : NSObject

@property (nonatomic, strong) LiveMessageModel * liveMessage;

@property (nonatomic, assign, readonly) CGSize size;
@property (nonatomic, strong, readonly) YYTextLayout * layout;

- (instancetype)initWithLiveMessage:(LiveMessageModel *)liveMessage;

@end
