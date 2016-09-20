//
//  Live_m
//  Bilibili
//
//  Created by LunarEclipse on 16/9/6.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "LiveHomeHeader.h"

@implementation LiveHomeHeader

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
    _followButton.textLayout = TextLayoutBottom;
    _liveCenterButton.textLayout = TextLayoutBottom;
    _searchButton.textLayout = TextLayoutBottom;
    _categoryButton.textLayout = TextLayoutBottom;
}

- (IBAction)onClickFollowButton:(id)sender
{
    
}

- (IBAction)onClickLiveCenterButton:(id)sender
{
    
}

- (IBAction)onClickSearchButton:(id)sender
{
    
}

- (IBAction)onClickCategoryButton:(id)sender
{
    
}

@end
