//
//  BangumiRecommendCell.m
//  Bilibili
//
//  Created by LunarEclipse on 16/9/10.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "BangumiRecommendCell.h"
#import "BangumiRecommendModel.h"
#import "BilibiliAPI.h"

@import YYKit;
@import ReactiveCocoa;

@interface BangumiRecommendCell ()


@end

@implementation BangumiRecommendCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
        [self initialize];
    return self;
}

- (void)awakeFromNib
{
    [self initialize];
}

-(void)initialize
{
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}


@end
