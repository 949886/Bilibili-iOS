//
//  ProfileSegmentCell.m
//  Bilibili
//
//  Created by LunarEclipse on 16/10/15.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "ProfileSegmentCell.h"
#import "ProfileItemCell.h"

@import YYKit;

@interface ProfileSegmentCell ()

@property (nonatomic, strong) NSArray * icons;
@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, strong) NSArray * classes;

@end

@implementation ProfileSegmentCell

static NSString * const reuseIdentifier = @"Cell";
static NSString * const separatorIdentifier = @"Separator";

#pragma mark Initialization

- (instancetype)init
{
    if (self = [super init])
        [self initialize];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
        [self initialize];
    return self;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
        [self initialize];
    return self;
}

- (void)initialize
{
    UICollectionViewFlowLayout * flowLayout = [ProfileItemLayout new];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(kScreenWidth / 4, kScreenWidth / 4);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_collectionView registerNib:[UINib nibWithNibName:@"ProfileItemCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [self addSubview:_collectionView];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _collectionView.contentSize = _collectionView.bounds.size;
}

#pragma mark Delegate

/* UICollectionViewDataSource */

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.iconImageView.image = [UIImage imageNamed:_icons[indexPath.row]];
    cell.titleLabel.text = _titles[indexPath.row];
    
    return cell;
}

#pragma mark Getter & Setter

-(NSInteger)itemCount
{
    return MIN(_icons.count, _titles.count);
}

#pragma mark Methods

-(void)setIcons:(NSArray<NSString *> *)icons titles:(NSArray<NSString *> *)titles classes:(NSArray<Class> *)classes
{
    _icons = icons;
    _titles = titles;
    _classes = classes;
    
    [self.collectionView reloadData];
}

@end
