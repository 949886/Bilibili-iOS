//
//  BangumiTagsView.m
//  Bilibili
//
//  Created by LunarEclipse on 16/10/22.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "BangumiTagsView.h"
#import "SeasonsCollectionViewCell.h"

#import "TagModel.h"

@import YYKit;

#pragma mark - BangumiTagsViewCell

@interface BangumiTagsViewCell : UICollectionViewCell

@property (nonatomic, strong) TagModel * TAG;
@property (nonatomic, strong) UILabel * label;

-(void)setup:(TagModel *)tag;

@end

@implementation BangumiTagsViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _label = [[UILabel alloc] initWithFrame:self.bounds];
    _label.font = [UIFont systemFontOfSize:13 weight:UIFontWeightLight];
    _label.textColor = [UIColor lightGrayColor];
    [self addSubview:_label];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.cornerRadius = self.height * 0.5;
    
    [_label sizeToFit];
    _label.centerX = self.width * 0.5;
    _label.centerY = self.height * 0.5;
}

-(void)setup:(TagModel *)tag
{
    _TAG = tag;
    
    _label.text = tag.tag_name;
}

@end


#pragma mark - BangumiTagsView

@interface BangumiTagsView ()

@property (nonatomic, strong) UICollectionViewFlowLayout * flowLayout;

@end

@implementation BangumiTagsView

static NSString * const reuseIdentifier = @"Cell";

#pragma mark Initialization

- (void)initialize
{
    _flowLayout = [UICollectionViewFlowLayout new];
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.minimumLineSpacing = 12;
    _flowLayout.minimumInteritemSpacing = 0;
    
    self.dataSource = self;
    self.delegate = self;
    self.collectionViewLayout = _flowLayout;
    [self registerClass:[BangumiTagsViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
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
    return _tags.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BangumiTagsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell setup:_tags[indexPath.row]];
    
    return cell;
}

/* UICollectionViewDelegate */

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BangumiTagsViewCell * cell = [BangumiTagsViewCell new];
    cell.label.text = _tags[indexPath.row].tag_name;
    [cell.label sizeToFit];
    return CGSizeMake(cell.label.size.width + 20, 28);
}


#pragma mark Getter & Setter

-(void)setTags:(NSArray<TagModel *> *)tags
{
    _tags = tags;
    [self reloadData];
}


@end
