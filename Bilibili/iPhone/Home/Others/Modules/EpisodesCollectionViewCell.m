//
//  EpisodesCollectionViewCell.m
//  Bilibili
//
//  Created by LunarEclipse on 16/10/21.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "EpisodesCollectionViewCell.h"
#import "VideoViewController.h"

#import "extension.h"

@implementation EpisodesCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected)
    {
        self.layer.borderColor = RGB(234, 91, 141).CGColor;
        self.titleLabel.textColor = RGB(234, 91, 141);
        self.episodeLabel.textColor = RGB(234, 91, 141);
    }
    else
    {
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.titleLabel.textColor = [UIColor blackColor];
        self.episodeLabel.textColor = [UIColor blackColor];
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    if (_episode == nil || _episode.av_id == 0) return;
    
    VideoViewController * controller = [[VideoViewController alloc] initWithAID:_episode.av_id episodeID:_episode.episode_id];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)setup:(EpisodeModel *)episode
{
    _episode = episode;
    
    _episodeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"bangumi_episode", nil), episode.index];
    _titleLabel.text = episode.index_title;
}

@end
