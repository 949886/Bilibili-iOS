//
//  _m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/11.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "VideoCell.h"
#import "extension.h"

#import "VideoViewController.h"
#import "BangumiViewController.h"

@import YYKit;
@import SDWebImage;

@interface VideoCell ()

@property (nonatomic, strong) RecommendElement * element;

@end

@implementation VideoCell

#pragma mark Override

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    _titleLabel.verticalAlignment = VerticalAlignmentTop;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([_element._goto isEqualToString:@"av"])
    {
        VideoViewController * controller = [[VideoViewController alloc] initWithAID:[_element.param integerValue]];
        [self.viewController.navigationController pushViewController:controller animated:YES];
    }
    
    if ([_element._goto isEqualToString:@"bangumi"])
    {
        BangumiViewController * controller = [[BangumiViewController alloc] initWithSeasonID:[_element.param integerValue]];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark Encapsulation

-(void)hideCountData
{
    _playCountIcon.hidden = YES;
    _playCountLabel.hidden = YES;
    _danmakuCountIcon.hidden = YES;
    _danmakuCountLabel.hidden = YES;
}

-(void)showCountData
{
    _playCountIcon.hidden = NO;
    _playCountLabel.hidden = NO;
    _danmakuCountIcon.hidden = NO;
    _danmakuCountLabel.hidden = NO;
}

#pragma mark Methods

-(void)setup:(RecommendElement *)element type:(NSString *)type
{
    _element = element;
    
    _titleLabel.text = element.title;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:element.cover] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
    
    if ([type isEqualToString:@"region"] ||
        [type isEqualToString:@"recommend"])
    {
        _playCountLabel.text = [NSString stringWithFormat:@"%@", [NSString integer2Chinese:element.play]];
        _danmakuCountLabel.text = [NSString stringWithFormat:@"%ld", (long)element.danmaku];
    }
    
    //若为活动等内容，隐藏播放数和弹幕数。
    if ([type isEqualToString:@"activity"] ||
        [type isEqualToString:@"bangumi"])
        [self hideCountData];
    else [self showCountData];;
}

@end
