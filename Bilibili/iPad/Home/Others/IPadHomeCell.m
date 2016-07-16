//
//  IPadHomeCell.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/10.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "IPadHomeCell.h"
#import "VideoCell.h"

#import "YYKit.h"

@implementation IPadHomeCell

-(void)setup:(RecommendationSegment *)model
{
    //初始化segmentView
    if (!_segmentView)
    {
        SegmentView * segmentView = [SegmentView new];
        _segmentView = segmentView;
        [_collectionViewContainer addSubview:_segmentView];
        _segmentView.frame = _collectionViewContainer.bounds;
        _segmentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _segmentView.columns = 4;
        _segmentView.margin = UIEdgeInsetsMake(0, 10, 10, 10);
        _segmentView.horizonalSpacing = 10;
        _segmentView.verticalSpacing = 20;
    }

    //刷新segmentView数据
    if ([model.type isEqualToString:@"recommend"] ||
        [model.type isEqualToString:@"region"])
    {
//        _segmentView.frame = _collectionViewContainer.bounds;
        _segmentView.type = SegmentViewVideo;
        _segmentView.data = model.videos;

        [_segmentView.collectionView reloadData];
    }
    else if([model.type isEqualToString:@"live"])
    {
//        _segmentView.frame = _collectionViewContainer.bounds;
        _segmentView.type = SegmentViewLive;
        _segmentView.data = model.lives;
        
        [_segmentView.collectionView reloadData];
    }
    else if ([model.type isEqualToString:@"topic"])
    {
//        _segmentView.frame = _collectionViewContainer.bounds;
        self.backgroundColor = UIColorHex(f5f5f5);
        self.segmentView.backgroundColor = [UIColor clearColor];
        _refreshContainter.hidden = YES;
        _moreInfoContainer.hidden = YES;
        _segmentView.columns = 2;
        _segmentView.type = SegmentViewTopic;
        _segmentView.data = model.topics;
        [_segmentView.collectionView reloadData];
        return;
    }
    else
    {
        _segmentView.data = nil;
        _segmentView.type = SegmentViewCategory;
        [_segmentView.collectionView reloadData];
    }
}

@end
