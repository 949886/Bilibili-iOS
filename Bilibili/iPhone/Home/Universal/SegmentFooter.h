//
//  SegmentFooter.h
//  Bilibili
//
//  Created by LunarEclipse on 16/9/8.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "models.h"
#import "ImageSlider.h"

@interface SegmentFooter : UICollectionViewCell

@property (nonatomic, strong)  ImageSlider * imageSlider;
@property (nonatomic, copy) NSArray<BannerModel *> * banners;

-(void)setup:(NSArray<BannerModel *> *)banners;

@end