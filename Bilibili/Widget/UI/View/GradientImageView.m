//
//  GradientImageView.m
//  Bilibili
//
//  Created by LunarEclipse on 16/9/4.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "GradientImageView.h"

@import YYKit;

@interface GradientImageView ()

@property (nonatomic, strong) CAGradientLayer * gradientLayer;

@end

@implementation GradientImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
        [self initialize];
    return self;
}

-(void)awakeFromNib
{
    [self initialize];
}

-(void)initialize
{
    _gradientLayer = [CAGradientLayer layer];
    _gradientLayer.frame = self.bounds;
    _gradientLayer.colors = @[(id)[UIColor clearColor].CGColor, (id)UIColorHex(#00000066).CGColor];
    _gradientLayer.startPoint = CGPointMake(0.5, 0.5);
    _gradientLayer.endPoint = CGPointMake(0.5, 1);
    [self.layer addSublayer:_gradientLayer];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _gradientLayer.frame = self.bounds;
}

@end
