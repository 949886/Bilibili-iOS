//
//  VideoCell.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/11.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

@import ReactiveCocoa;
@import YYKit;

#import "VideoCell.h"
#import "extension.h"

@implementation VideoCell

- (void)awakeFromNib
{
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    _titleLabel.verticalAlignment = VerticalAlignmentTop;
}


@end
