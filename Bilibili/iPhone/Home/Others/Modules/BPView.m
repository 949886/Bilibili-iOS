//
//  BPView.m
//  Bilibili
//
//  Created by LunarEclipse on 16/10/17.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "BPView.h"
#import "BangumiModel.h"

@import SDWebImage;

@interface BPView ()

@property (nonatomic, strong) BangumiModel * bangumi;

@end

@implementation BPView

+ (instancetype)defaultBPView
{
    return [[NSBundle mainBundle] loadNibNamed:@"BPView" owner:nil options:nil].firstObject;
}

-(void)setup:(BangumiModel *)bangumi
{
    _bangumi = bangumi;
    
    //Sponsers.
    if (bangumi.rank.total_bp_count != 0)
        _sponsersLabel.text = [NSString stringWithFormat:NSLocalizedString(@"bp_sponsors", nil), bangumi.rank.total_bp_count];
    else NSLocalizedString(@"bp_noSponsors", nil);
    
    if(bangumi.rank.week_bp_count != 0)
        _sponsersWeeklyLabel.text = [NSString stringWithFormat:NSLocalizedString(@"bp_sponsorsWeekly", nil), bangumi.rank.week_bp_count];
    else NSLocalizedString(@"bp_noSponsorsWeekly", nil);
    
    //Avatars of sponsers.
    NSArray<UIImageView *> * views = @[_sponser1, _sponser2, _sponser3, _sponser4];
    for (int i = 0; i < MIN(views.count - 1, bangumi.rank.list.count - 1); ++i)
        [views[i] sd_setImageWithURL:[NSURL URLWithString:bangumi.rank.list[i].face]];
}

@end
