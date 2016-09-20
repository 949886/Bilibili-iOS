//
//  SegmentFooter.m
//  Bilibili
//
//  Created by LunarEclipse on 16/9/8.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "SegmentFooter.h"

@implementation SegmentFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
        [self initialize];
    return self;
}

-(void)initialize
{
    _imageSlider = [[ImageSlider alloc] initWithFrame:self.bounds];
    _imageSlider.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_imageSlider handleClickEvent:^(NSInteger index) {
      NSLog(@"%ld", (long)index);
    }];
    [self addSubview:_imageSlider];
}

-(void)setup:(NSArray<BannerModel *> *)banners
{
    if(banners == nil) return;
    _banners = banners;
    
    NSMutableArray * urls = [NSMutableArray array];
    for (BannerModel * banner in banners) {
        [urls addObject:banner.imageurl];
    }
    _imageSlider.urls = urls;
}

@end
