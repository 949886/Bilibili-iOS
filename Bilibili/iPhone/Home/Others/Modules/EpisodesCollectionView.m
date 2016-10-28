//
//  EpisodesCollectionView.m
//  Bilibili
//
//  Created by LunarEclipse on 16/10/17.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "EpisodesCollectionView.h"

@import YYKit;

@interface EpisodesCollectionView ()

@property (nonatomic, strong) UICollectionViewFlowLayout * flowLayout;

@end

@implementation EpisodesCollectionView

static NSString * const reuseIdentifier = @"Cell";

#pragma mark Initialization

- (void)initialize
{
    _flowLayout = [UICollectionViewFlowLayout new];
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.minimumLineSpacing = 12;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.itemSize = CGSizeMake(160, 72);
    
    self.dataSource = self;
    self.delegate = self;
    self.collectionViewLayout = _flowLayout;
    [self registerNib:[UINib nibWithNibName:@"EpisodesCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark Override

-(void)awakeFromNib
{
    [self initialize];
}

#pragma mark Delegate

/* UICollectionViewDataSource */

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _episodes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EpisodesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell setup:_episodes[indexPath.row]];
    return cell;
}

/* UICollectionViewDelegate */

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    if(indexPath.row == _currentEpisode)
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        });
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    EpisodesCollectionViewCell * cell = (EpisodesCollectionViewCell *)[self cellForItemAtIndexPath:indexPath];
    if(_onCellSelected) _onCellSelected(cell);
}

#pragma mark Getter & Setter

-(void)setEpisodes:(NSArray<EpisodeModel *> *)episodes
{
    _episodes = episodes;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}

@end
