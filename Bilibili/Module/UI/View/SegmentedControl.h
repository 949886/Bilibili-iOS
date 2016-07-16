//
//  SegmentedControl.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/8.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SegmentedControlType)
{
    SegmentedControlTypeSystem = 0, //TypeSystem以后写，只有Underlined，务必用Underlined
    SegmentedControlTypeUnderlined
};

/* 自定义SegmentedControl */

@interface SegmentedControl : UIView

@property (nonatomic, strong) NSMutableArray * items;
@property (nonatomic, assign) NSInteger index;      //当前选择的选项卡的序号（从0开始）

@property (nonatomic, strong) UIColor * color;      //文字和underline的颜色，默认为blue, alpha=0.5
@property (nonatomic, strong) UIFont * font;        //标题字体，默认为system, 15px

@property (nonatomic, strong, readonly) UIView * background;
@property (nonatomic, strong, readonly) UIScrollView * scrollView;

@property (nonatomic, assign) BOOL scrollEnabled;   //默认为NO
@property (nonatomic, assign) CGFloat segmentWidth; //scrollEnabled为YES时此属性才有用

@property (nonatomic, copy) void(^didClickSegment)(NSInteger);  //通过此属性设置回调事件

-(instancetype)initWithType:(SegmentedControlType)type;

-(void)handleEventWithBlock:(void(^)(NSInteger))block;          //同didClickSegment

//-(void)addSegment:(NSString *)title event:(void(^)(NSInteger))event;
//-(void)addEvent:(void(^)(NSInteger))event atIndex:(NSInteger)index;

@end
