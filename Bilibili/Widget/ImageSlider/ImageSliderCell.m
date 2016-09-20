//
//  ImageSliderCell.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/9.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "ImageSliderCell.h"

@interface ImageSliderCell ()

@property (nonatomic, strong) UIImageView * imageView;

@end

@implementation ImageSliderCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:_imageView];
        _imageView.userInteractionEnabled = YES;
    }
    return self;
}

-(void)setImage:(UIImage *)image
{
    _image = image;
    _imageView.image = image;
}

@end
