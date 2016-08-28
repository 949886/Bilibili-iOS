//
//  JJAVModel.h
//  Bilibili
//
//  Created by LunarEclipse on 16/8/24.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JJList;

@interface JJAVModel : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger av;
@property (nonatomic, copy) NSString *up;
@property (nonatomic, assign) NSInteger maxpage;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *upimg;
@property (nonatomic, copy) NSString *upsign;
@property (nonatomic, strong) NSArray<JJList *> *list;

@end


@interface JJList : NSObject

@property (nonatomic, assign) NSInteger aid;
@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *mp3Url;
@property (nonatomic, assign) NSInteger mp3Length;
@property (nonatomic, assign) NSInteger mp3Click;
@property (nonatomic, copy) NSString *mp4Url;
@property (nonatomic, assign) NSInteger mp4Length;
@property (nonatomic, assign) NSInteger mp4Click;

@end

