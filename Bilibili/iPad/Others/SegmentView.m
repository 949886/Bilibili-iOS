//
//  VideoCollectionView.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/10.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

@import YYKit;
@import SDWebImage;
@import ReactiveCocoa;

#import "SegmentView.h"
#import "WebViewControll.h"
#import "VideoCell.h"
#import "LiveCell.h"

#import "extension.h"

#define ID @"Cell"

@interface SegmentView ()

@end

@implementation SegmentView

#pragma mark Initialization

-(instancetype)initWithType:(SegmentViewType)type
{
    if (self = [self initWithFrame:CGRectZero])
    {
        self.type = type;
    }
    return self;
}

#pragma mark Override

-(void)layoutSubviews
{
    //自动计算行数
    if (_data) self.rows = (_data.count - 1) / self.columns + 1;
    else self.rows = 0;
    
    [super layoutSubviews];
}


-(void)setType:(SegmentViewType)type
{
    if (_type == type) return;
    _type = type;
    
    switch (type)
    {
        case SegmentViewVideo:
        {
            NSString * nibName = IS_IPAD ? @"IPadVideoCell" : @"IPhoneVideoCell";
            UINib * nib = [UINib nibWithNibName:nibName bundle:nil];
            [self.collectionView registerNib:nib forCellWithReuseIdentifier:ID];
            
        } break;
        case SegmentViewLive:
        {
            NSString * nibName = IS_IPAD ? @"IPadLiveCell" : @"IPadLiveCell";
            UINib * nib = [UINib nibWithNibName:nibName bundle:nil];
            [self.collectionView registerNib:nib forCellWithReuseIdentifier:ID];
        } break;
        case SegmentViewTopic:
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
        break;
        default: break;
    }
}

#pragma mark Delegate

//DataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(_data) return _data.count;
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    if (_type == SegmentViewVideo && _data)
    {
        if(indexPath.row > _data.count) return cell;
        VideoModel * video = _data[indexPath.row];
        VideoCell * videoCell = (VideoCell *)cell;
        videoCell.titleLabel.text = video.title;
        videoCell.playCountLabel.text = [NSString stringWithFormat:@"%ld", (long)video.stat.view];
        videoCell.danmakuCountLabel.text = [NSString stringWithFormat:@"%ld", (long)video.stat.danmaku];
        [videoCell.imageView sd_setImageWithURL:[NSURL URLWithString:video.pic] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
    }
    if (_type == SegmentViewLive && _data)
    {
        if(indexPath.row > _data.count) return cell;
        LiveModel * live = _data[indexPath.row];
        LiveCell * liveCell = (LiveCell *)cell;
        liveCell.usernameLabel.text = live.owner.name;
        liveCell.titleLabel.text = live.title;
        liveCell.viewersLabel.text = [NSString stringWithFormat:@"%ld", (long)live.online];
        [liveCell.coverImageView sd_setImageWithURL:[NSURL URLWithString:live.cover.src] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
        [liveCell.portraitImageView sd_setImageWithURL:[NSURL URLWithString:live.owner.face] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
        
        //TODO: 头像Gif处理
    }
    if (_type == SegmentViewTopic && _data)
    {
        if(indexPath.row > _data.count) return cell;
        TopicModel * topic = _data[indexPath.row];
        cell.backgroundColor = [UIColor redColor];
        UIButton * topicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        topicButton.frame = cell.bounds;
        topicButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [topicButton sd_setBackgroundImageWithURL:[NSURL URLWithString:topic.cover] forState:UIControlStateNormal placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
        
        __weak typeof(self) weakSelf = self;
        [[topicButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            WebViewControll * controller = [[WebViewControll alloc]initWithURL:topic.url];
            UINavigationController * navigationController = weakSelf.viewController.view.superview.viewController.navigationController;
            [navigationController pushViewController:controller animated:YES];
        }];
        
        [cell addSubview:topicButton];
    }

    return cell;
}

//Delegate


@end
