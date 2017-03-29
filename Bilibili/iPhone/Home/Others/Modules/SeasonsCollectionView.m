//
//  SeasonsCollectionView.m
//  Bilibili
//
//  Created by LunarEclipse on 16/10/20.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "SeasonsCollectionView.h"


#import "BangumiModel.h"

@import YYKit;

@interface SeasonsCollectionView ()

@property (nonatomic, strong) UICollectionViewFlowLayout * flowLayout;

@end

@implementation SeasonsCollectionView

static NSString * const reuseIdentifier = @"Cell";

#pragma mark Initialization

- (void)initialize
{
    _flowLayout = [UICollectionViewFlowLayout new];
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.itemSize = CGSizeMake(85, 40);
    
    self.dataSource = self;
    self.delegate = self;
    self.collectionViewLayout = _flowLayout;
    [self registerNib:[UINib nibWithNibName:@"SeasonsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark Override

-(void)awakeFromNib
{
    [super awakeFromNib];
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
    return _seasons.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SeasonsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    BangumiModel * season = _seasons[indexPath.row];
    
    [cell setup:season];
    
    if (indexPath.row == 0)
        cell.type = SeasonsCollectionViewCellTypeLeft;
    else if (indexPath.row == _seasons.count - 1)
        cell.type = SeasonsCollectionViewCellTypeRight;
    else cell.type = SeasonsCollectionViewCellTypeMiddle;
    
    return cell;
}

/* UICollectionViewDelegate */

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    BangumiModel * season = _seasons[indexPath.row];
    if(season.season_id == _currentSeason.season_id)
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        });
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SeasonsCollectionViewCell * cell = (SeasonsCollectionViewCell *)[self cellForItemAtIndexPath:indexPath];
    if(_onCellSelected) _onCellSelected(cell);
}


#pragma mark Getter & Setter

-(void)setSeasons:(NSArray *)seasons
{
    _seasons = seasons;

    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}

@end
