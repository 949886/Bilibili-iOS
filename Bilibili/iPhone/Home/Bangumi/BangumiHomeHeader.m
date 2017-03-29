//
//  BangumiHomeHeader.m
//  Bilibili
//
//  Created by LunarEclipse on 8/9/9.
//  Copyright © 208年 LunarEclipse. All rights reserved.
//

#import "BangumiHomeHeader.h"

@implementation BangumiHomeHeader

#pragma mark Initialization

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
        [self initialize];
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self initialize];
}

-(void)initialize
{
    [_unfinishedBangumiButton setTextLayout:TextLayoutBottom spacing:4];
    [_finishedBangumiButton setTextLayout:TextLayoutBottom spacing:4];
    [_tianchaoBangumiButton setTextLayout:TextLayoutBottom spacing:4];
    [_extraButton setTextLayout:TextLayoutBottom spacing:4];
    
    
    _followingBangumiButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _bangumiListButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _categoryButton.imageView.contentMode = UIViewContentModeScaleAspectFit;

}

#pragma mark IBAction

- (IBAction)onClickUnfinishedBangumiButton:(id)sender
{
    
}

- (IBAction)onClickFinishedBangumiButton:(id)sender
{
    
}

- (IBAction)onClickTianchaoBangumiButton:(id)sender
{
    
}

- (IBAction)onClickExtraButton:(id)sender
{
    
}

- (IBAction)onClickFollowingBangumiButton:(id)sender
{
    
}

- (IBAction)onClickBangumiListButton:(id)sender
{
    
}

- (IBAction)onClickCategoryButton:(id)sender
{
    
}

@end
