//
//  Danmaku.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/2.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

// <d p="23.826000213623,1,25,16777215,1422201084,0,057075e9,757076900">我从未见过如此厚颜无耻之猴</d>
// 0:时间(弹幕出现时间)
// 1:类型(1从右至左滚动弹幕|6从左至右滚动弹幕|5顶端固定弹幕|4底端固定弹幕|7高级弹幕|8脚本弹幕)
// 2:字号
// 3:颜色
// 4:时间戳 ?
// 5:弹幕池id
// 6:用户hash
// 7:弹幕id

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DanmakuType)
{
    DanmakuTypeRL = 1,      //从右至左滚动弹幕
    DanmakuTypeLR = 6,      //从左至右滚动弹幕
    DanmakuTypeButtom = 4,  //底端固定弹幕
    DanmakuTypeTop = 5,     //顶端固定弹幕
    DanmakuTypeSpecial = 7, //高级弹幕
    DanmakuTypeScript = 8   //脚本弹幕
};

@interface Danmaku : NSObject

/*XML数据*/

@property (nonatomic) float time;
@property (nonatomic) DanmakuType type;
@property (nonatomic) float fontSize;
@property (nonatomic) NSInteger textColor;
@property (nonatomic) NSInteger timestamp;
@property (nonatomic) NSInteger poolID;
@property (nonatomic) u_int64_t userHash;
@property (nonatomic) u_int64_t index;

@property (nonatomic, copy) NSString * text;


/*其他弹幕数据（XML文件中未提供）*/

@property (nonatomic) float duration;           //弹幕存活时间
@property (nonatomic) BOOL visibility;          //是否可见
@property (nonatomic) BOOL isGuest;

@end
