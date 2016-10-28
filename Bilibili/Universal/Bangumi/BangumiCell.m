//
//  BangumiCell.m
//  Bilibili
//
//  Created by LunarEclipse on 16/9/10.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "BangumiCell.h"
#import "BangumiViewController.h"

#import "BangumiModel.h"

#import "extension.h"

@import YYKit;
@import SDWebImage;

@interface BangumiCell ()

@property (nonatomic, strong) BangumiModel * bangumi;

@end

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

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(_bangumi == nil) return;
    
    BangumiViewController * controller = [[BangumiViewController alloc] initWithBangumi:_bangumi];
//    [self.viewController.navigationController pushViewController:controller animated:YES];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)setup:(BangumiModel *)bangumi
{
    _bangumi = bangumi;
    
    self.titleLabel.text = bangumi.title;
    self.episodeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"home_bangumi_currentEpisode", nil), bangumi.newest_ep_index];
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:bangumi.cover] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
}

@end
