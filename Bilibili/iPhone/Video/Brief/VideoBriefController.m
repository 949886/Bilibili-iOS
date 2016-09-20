//
//  VideoBriefController.m
//  Bilibili
//
//  Created by LunarEclipse on 16/9/18.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "VideoBriefController.h"

#import "VideoInfoView.h"
#import "RelativeVideoCell.h"

#define CELL @"Cell"

@import YYKit;
@import SDWebImage;
@import ReactiveCocoa;

@interface VideoBriefController ()

@property (nonatomic, strong) VideoInfoView * videoInfoView;

@end

@implementation VideoBriefController

#pragma mark Override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 120;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.000];
    [self.tableView registerNib:[UINib nibWithNibName:@"RelativeVideoCell" bundle:nil] forCellReuseIdentifier:CELL];
    
    _videoInfoView = [[NSBundle mainBundle] loadNibNamed:@"VideoInfoView" owner:nil options:nil].firstObject;
    _videoInfoView.autoresizingMask = UIViewAutoresizingNone;
    _videoInfoView.ownerContainterHeight.constant = 200;
    _videoInfoView.height = [_videoInfoView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    self.tableView.tableHeaderView = _videoInfoView;
}

#pragma mark Delegate

/* UITableViewDataSource */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _video.relates.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoModel * relativeVideo = _video.relates[indexPath.row];
    
    RelativeVideoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.titleLabel.text = relativeVideo.title;
    cell.upperLabel.text = [NSString stringWithFormat:NSLocalizedString(@"video_relative_upper", Up主: ), relativeVideo.owner.name];
    cell.playCountLabel.text = [NSString stringWithFormat:NSLocalizedString(@"video_relative_playCount", Up主: ), (long)relativeVideo.stat.view];
    cell.danmakuCountLabel.text = [NSString stringWithFormat:NSLocalizedString(@"video_relative_danmakuCount", Up主: ), (long)relativeVideo.stat.danmaku];
    [cell.coverImageView sd_setImageWithURL:[NSURL URLWithString:relativeVideo.pic] placeholderImage:[UIImage imageWithColor:[UIColor grayColor]]];
    
    return cell;
}

#pragma mark Getter & Setter

-(void)setVideo:(VideoModel *)video
{
    _video = video;
    
    _videoInfoView.titleLabel.text = _video.title;
    _videoInfoView.desctiptionLabel.text = _video.desc;
    _videoInfoView.playCountLabel.text = [NSString stringWithFormat:@"%ld", (long)_video.stat.view];
    _videoInfoView.danmakuCountLabel.text = [NSString stringWithFormat:@"%ld", (long)_video.stat.danmaku];
    _videoInfoView.shareCountLabel.text = [NSString stringWithFormat:@"%ld", (long)_video.stat.share];
    _videoInfoView.coinCountLabel.text = [NSString stringWithFormat:@"%ld", (long)_video.stat.coin];
    _videoInfoView.favoriateCountLabel.text = [NSString stringWithFormat:@"%ld", (long)_video.stat.favorite];
    _videoInfoView.usernameLabel.text = _video.owner.name;
    [_videoInfoView.portraitImageView sd_setImageWithURL:[NSURL URLWithString:_video.owner.face] placeholderImage:[UIImage imageWithColor:[UIColor grayColor]]];
    
    [self.tableView reloadData];
}


@end
