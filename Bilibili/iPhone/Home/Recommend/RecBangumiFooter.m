//
//  RecBangumiFooter.m
//  Bilibili
//
//  Created by LunarEclipse on 16/9/8.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "RecBangumiFooter.h"

@implementation RecBangumiFooter

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _bangumiTimelineButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    _bangumiCategoryButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (IBAction)onClickBangumiTimelineButton:(id)sender
{
    NSLog(@"onClickBangumiTimelineButton");
}

- (IBAction)onClickBangumiCategoryButton:(id)sender
{
    NSLog(@"onClickBangumiCategoryButton");
}

@end
