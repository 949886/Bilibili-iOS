//
//  BangumiHeaderController.m
//  Bilibili
//
//  Created by LunarEclipse on 16/10/17.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "BangumiHeaderController.h"

#import "SeasonsCollectionView.h"
#import "EpisodesCollectionView.h"
#import "BangumiTagsView.h"
#import "RelativeBangumisView.h"

#import "BPView.h"



#import "extension.h"

@import YYKit;
@import SDWebImage;

@interface BangumiHeaderController ()

@property (nonatomic, weak) UIViewController * bangumiViewController;

@property (nonatomic, strong) BPView * bpview;

@property (weak, nonatomic) IBOutlet UIImageView *titleBackgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@property (weak, nonatomic) IBOutlet SeasonsCollectionView *seasonsCollectionView;
@property (weak, nonatomic) IBOutlet EpisodesCollectionView *episodesCollectionView;
@property (weak, nonatomic) IBOutlet BangumiTagsView *tagsCollectionView;
@property (weak, nonatomic) IBOutlet RelativeBangumisView *recommendCollectionView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *isFinishedLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastPlayLabel;
@property (weak, nonatomic) IBOutlet UILabel *chooseEpisodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *briefLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) IBOutlet UIView *lastPlayContainter;
@property (weak, nonatomic) IBOutlet UIView *bpViewContainer;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lastPlayContainerHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bpViewContainerHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *seasonsCollectionViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *episodesCollectionViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagsCollectionViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *recommendContainerHeight;

@end

@implementation BangumiHeaderController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    
    _bpViewContainerHeight.constant = 0;
    _bpview = [BPView defaultBPView];
    [_bpViewContainer addSubview:_bpview];
    
    _seasonsCollectionView.onCellSelected = ^(SeasonsCollectionViewCell * cell){
        __strong typeof(self) strongSelf = weakSelf;
        if(strongSelf.onSeasonSelected) strongSelf.onSeasonSelected(cell.season);
    };
    _episodesCollectionView.onCellSelected = ^(EpisodesCollectionViewCell * cell){
        __strong typeof(self) strongSelf = weakSelf;
        if(strongSelf.onEpisodeSelected) strongSelf.onEpisodeSelected(cell.episode);
    };
    
    self.view.autoresizingMask = UIViewAutoresizingNone;
    self.view.height = [self.view systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
}

-(void)setBangumi:(BangumiModel *)bangumi
{
    _bangumi = bangumi;
    
    //Infomation Label
    _titleLabel.text = bangumi.title;
    _briefLabel.text = bangumi.brief;
    _statusLabel.text = [NSString stringWithFormat:NSLocalizedString(@"bangumi_status", 播放%@ 订阅%@), [NSString integer2Chinese:bangumi.play_count], [NSString integer2Chinese:bangumi.favourites]];
    _isFinishedLabel.text = bangumi.is_finished ?
    NSLocalizedString(@"bangumi_finished", 已完结) :
    [NSString stringWithFormat:NSLocalizedString(@"bangumi_unfinished", 连载中每周%@更新), @"一"];
    
    //Last play
    _lastPlayContainter.hidden = (BOOL)bangumi.user_season.last_ep_index;
    _lastPlayContainerHeight.constant = (bangumi.user_season.last_ep_index != 0) ? 32 : 0;
    _lastPlayLabel.text = [NSString stringWithFormat:NSLocalizedString(@"bangumi_episode", 第 %ld 话), bangumi.user_season.last_ep_index];
    
    //Image
    [_titleBackgroundImageView sd_setImageWithURL:[NSURL URLWithString:bangumi.cover]];
    [_coverImageView sd_setImageWithURL:[NSURL URLWithString:bangumi.cover] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
    
    //
    _seasonsCollectionView.seasons = bangumi.seasons;
    _seasonsCollectionView.currentSeason = bangumi;
    
    _episodesCollectionView.episodes = [[bangumi.episodes reverseObjectEnumerator] allObjects];
    _episodesCollectionView.currentEpisode = bangumi.user_season.last_ep_index;
    
    _recommendCollectionView.seasonID = bangumi.season_id;
    _recommendContainerHeight.constant =  2 * ((kScreenWidth / 3 - ceilf(2.0 * 4 / 3)) * 1.25 + 50) + 20;
    
    //Bp
    if (bangumi.allow_bp)
    {
        _bpViewContainer.hidden = NO;
        _bpViewContainerHeight.constant = 136;
        [_bpview setup:_bangumi];
    }
    else
    {
        _bpViewContainer.hidden = YES;
        _bpViewContainerHeight.constant = 0;
    }
    
    //Tags
    _tagsCollectionView.tags = bangumi.tags;
    
    self.view.height = [self.view systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
}

#pragma mark IBAction

//返回按钮
- (IBAction)onClickBackButton:(id)sender
{
    [self.view.superview.viewController.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onClickShareButton:(id)sender
{
    
}

- (IBAction)onClickAttentionButton:(id)sender
{
    
}

- (IBAction)onClickDownloadButton:(id)sender
{
    
}

- (IBAction)onClickLastPlayButton:(id)sender
{
    
}

- (IBAction)onClickMoreCommentButton:(id)sender
{
    
}

@end
