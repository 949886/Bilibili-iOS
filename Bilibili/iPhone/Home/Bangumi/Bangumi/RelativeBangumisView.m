//
//  RelativeBangumisView.m
//  Bilibili
//
//  Created by LunarEclipse on 16/10/21.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "RelativeBangumisView.h"
#import "BangumiCell.h"

#import "BilibiliAPI.h"

#import "extension.h"

#define PADDING 4

@import YYKit;

@interface RelativeBangumisView ()

@property (nonatomic, copy) NSArray<BangumiModel *> * bangumis;

@property (nonatomic, strong) UICollectionViewFlowLayout * flowLayout;

@end

@implementation RelativeBangumisView

static NSString * const reuseIdentifier = @"Cell";

#pragma mark Initialization

- (void)initialize
{
    _flowLayout = [UICollectionViewFlowLayout new];
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.itemSize = CGSizeMake(kScreenWidth / 3 - ceilf(2.0 * PADDING / 3), (kScreenWidth / 3 - ceilf(2.0 * PADDING / 3)) * 1.25 + 50);
    
    self.dataSource = self;
    self.delegate = self;
    self.collectionViewLayout = _flowLayout;
    self.contentInset = UIEdgeInsetsMake(PADDING, PADDING, PADDING, PADDING);
    [self registerNib:[UINib nibWithNibName:@"BangumiCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
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
    return _bangumis.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BangumiCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    BangumiModel * bangumi = _bangumis[indexPath.row];
    
    [cell setup:bangumi];
    cell.episodeLabel.hidden = YES;
    cell.viewersLabel.text = [NSString stringWithFormat:NSLocalizedString(@"home_bangumi_followers", nil), [NSString integer2Chinese:bangumi.favourites]];
    
    return cell;
}

#pragma mark Getter & Setter

-(void)setSeasonID:(NSInteger)seasonID
{
    _seasonID = seasonID;
    [self loadRelativeBangumis];
}

#pragma mark Encapsulation

-(void)loadRelativeBangumis
{
    @weakify(self);
    [BilibiliAPI getRelativeBangumisWithSid:_seasonID success:^(RelativeBangumisModel * object, BilibiliResponse * response) {
        @strongify(self)
        if (!self) return;
        
        self.bangumis = object.list;
        dispatch_async(dispatch_get_main_queue(), ^{
           [self reloadData];
        });
    } failure:^(BilibiliResponse * response, NSError * error) {
#ifdef DEBUG
        NSLog(@"%@", response);
        NSLog(@"%@", error);
#endif
    }];
}

@end
