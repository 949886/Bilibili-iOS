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
#import "extension.h"

#import "BangumiViewController.h"

@import YYKit;
@import SDWebImage;
@import ReactiveObjC;

@interface BangumiRecommendCell ()

@property (nonatomic, strong) BangumiRecommendModel * recommend;

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
    [super awakeFromNib];
    [self initialize];
}

-(void)initialize
{
    
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:NO animated:animated];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_recommend == nil) return;
    
    NSString * perfix = @"http://bangumi.bilibili.com/anime/";
    if ([_recommend.link hasPrefix:perfix])
    {
        NSInteger sid = [[_recommend.link substringFromIndex:perfix.length] integerValue];
        BangumiViewController * controller = [[BangumiViewController alloc] initWithSeasonID:sid];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else
    {

    }
}

-(void)setup:(BangumiRecommendModel *)recommend
{
    _recommend = recommend;
    
    self.titleLabel.text = recommend.title;
    self.descriptionLabel.text = recommend.desc;
    [self.coverImageView  sd_setImageWithURL:[NSURL URLWithString:recommend.cover] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
}


@end
