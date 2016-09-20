//
//  VideoCell.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/11.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

@import YYKit;

#import "VideoCell.h"
#import "extension.h"

#import "VideoViewController.h"

@import YYKit;
@import SDWebImage;

@interface VideoCell ()

@property (nonatomic, strong) RecommendElement * element;

@end

@implementation VideoCell

#pragma mark Override

- (void)awakeFromNib
{
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    _titleLabel.verticalAlignment = VerticalAlignmentTop;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    VideoViewController * controller = [[VideoViewController alloc] initWithAID:@"12450"];
    [self.viewController.navigationController pushViewController:controller animated:YES];
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

-(void)setup:(RecommendElement *)element
{
    _element = element;
    
    _titleLabel.text = element.title;
    _playCountLabel.text = [NSString stringWithFormat:@"%ld", (long)element.play];
    _danmakuCountLabel.text = [NSString stringWithFormat:@"%ld", (long)element.danmaku];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:element.cover] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
}

@end
