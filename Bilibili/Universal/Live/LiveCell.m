//
//  LiveCell.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/6.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "LiveCell.h"
#import "LiveViewController.h"

#import "LiveModel.h"

@import YYKit;
@import SDWebImage;

@interface LiveCell ()

@property (nonatomic, strong) LiveModel * live;

@end

@implementation LiveCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _titleLabel.verticalAlignment = VerticalAlignmentTop;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(_live == nil) return;
    
    LiveViewController * controller = [[LiveViewController alloc]initWithLive:_live];
    [self.viewController.navigationController pushViewController:controller animated:YES];
}

-(void)setup:(LiveModel *)live
{
    _live = live;
    
    self.usernameLabel.text = live.owner.name;
    self.viewersLabel.text = [NSString stringWithFormat:@"%ld", (long)live.online];
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:live.cover.src] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
    [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:live.owner.face] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
}

@end
