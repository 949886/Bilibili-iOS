//
//  BangumiCell.m
//  Bilibili
//
//  Created by LunarEclipse on 16/9/10.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "BangumiCell.h"

@implementation BangumiCell

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
    _titleLabel.verticalAlignment = VerticalAlignmentTop;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

@end
