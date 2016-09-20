//
//  CategoriesViewController.m
//  Bilibili
//
//  Created by LunarEclipse on 16/9/2.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "CategoriesViewController.h"
#import "LiveHomeHeader.h"
#import "CategoryCell.h"
#import "FlowCollectionView.h"

#define ID @"CategoryCell"

@import YYKit;

@interface CategoriesViewController ()

@property (nonatomic, strong) UICollectionView * collectionView;

@property (nonatomic, copy) NSArray * images;
@property (nonatomic, copy) NSArray * names;

@end

@implementation CategoriesViewController

#pragma mark Override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleName = @"分区";
    
    _images = @[@"home_region_icon_live", @"home_region_icon_13", @"home_region_icon_1", @"home_region_icon_3",
                @"home_region_icon_129", @"home_region_icon_4", @"home_region_icon_36", @"home_region_icon_160",
                @"home_region_icon_119", @"home_region_icon_fashion", @"home_region_icon_165", @"home_region_icon_155",
                @"home_region_icon_23", @"home_region_icon_5"];
    
    _names = @[@"直播", @"番剧", @"动画", @"音乐", @"舞蹈", @"游戏", @"科技", @"生活", @"鬼畜",
               @"时尚", @"广告", @"娱乐", @"电影", @"电视剧", @"游戏中心"];
    
    //Initialize CollectionView
    UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 8;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.contentView.bounds collectionViewLayout:layout];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.000];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _collectionView.contentInset = UIEdgeInsetsMake(20, 20, 0, 20);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"CategoryCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [self.contentView addSubview:_collectionView];
    
    CGFloat length = floorf(kScreenWidth / 3) - ceilf(layout.minimumInteritemSpacing * 2 / 3) - ceilf((_collectionView.contentInset.left + _collectionView.contentInset.right) / 3);
    layout.itemSize = CGSizeMake(length, length);
}

#pragma mark Delegate

/* UICollectionViewDataSource */

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return MIN(_images.count, _names.count);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryCell * cell = [_collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.iconImageView.image = [UIImage imageNamed:_images[indexPath.row]];
    cell.nameLabel.text = _names[indexPath.row];
    return cell;
}

@end
