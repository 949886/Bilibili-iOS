//
//  ImageSlider.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/7.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ImageSliderType)
{
    ImageSliderTypeNone = 0
};

@interface ImageSlider : UIView <UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) int index;

@property (nonatomic, copy) NSArray<NSString *> * images;   //加载本地图片，赋值该属性
@property (nonatomic, copy) NSArray<NSString *> * urls;     //以URL加载图片，赋值该属性

@property (nonatomic, assign) CGSize imageSize;             //不指定则默认填充整个view
@property (nonatomic, assign) CGFloat padding;              //图片间的间距
@property (nonatomic, strong) UIImage * placeholder;

@property (nonatomic, assign) float scrollInterval;         //自动滚动间隔（秒）

@property (nonatomic, assign) BOOL scrollAutomatically;     //是否自动滚动
@property (nonatomic, assign) BOOL scrollInfinitely;        //是否无限循环滚动
@property (nonatomic, assign) BOOL hidePageControl;         //是否隐藏pageControl

@property (nonatomic, copy) void(^didClickSegment)(NSInteger);  //通过此属性设置点击事件

-(instancetype)initWithType:(ImageSliderType)type;

-(void)activate;
-(void)deactivate;

-(void)handleEventWithBlock:(void(^)(NSInteger))block;          //同didClickSegment

@end
