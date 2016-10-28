//
//  BaseSegmentView.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/15.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

@import YYKit;

#import "BaseSegmentView.h"

#define ID @"Cell"

@interface BaseSegmentView ()



@end

@implementation BaseSegmentView

#pragma mark Initialization


-(instancetype)initWithFrame:(CGRect)frame cellPrototype:(Class)prototype
{
    if (self = [self initWithFrame:frame])
    {
        [_collectionView registerClass:prototype forCellWithReuseIdentifier:ID];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame nibName:(NSString *)nibName
{
    if (self = [self initWithFrame:frame])
    {
        UINib * nib = [UINib nibWithNibName:nibName bundle:nil];
        [_collectionView registerNib:nib forCellWithReuseIdentifier:ID];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame])
    {
        _layout = [UICollectionViewFlowLayout new];
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _layout.minimumInteritemSpacing = 0;
        _layout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:_layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_collectionView];
    }
    return self;
}

#pragma mark Override

-(void)layoutSubviews
{
    [super layoutSubviews];
    

    
    //设置边距（margin & padding）
//    self.bounds = CGRectMake(0, 0, self.bounds.size.width - _margin.left - _margin.right, self.bounds.size.height - _margin.top - _margin.bottom);
    _collectionView.bounds = CGRectMake(0, 0, _collectionView.bounds.size.width - _padding.left - _padding.right, _collectionView.bounds.size.height - _padding.top - _padding.bottom);
    
    if (_columns >= 1)
    {
        //(原宽度 - 纵距 * (行数 - 1) - 2 * (左右内边距 + 左右外边距)) / 列数
        CGFloat width = (_collectionView.width - (_columns - 1) * _horizonalSpacing - (_padding.left + _padding.right + _margin.left + _margin.right)) / _columns;
        _layout.itemSize = CGSizeMake(width, _layout.itemSize.height);
    }
    if (_rows >= 1)
    {
        //(原高度 - 行距 * (行数 - 1) - 2 * (上下内边距 + 上下外边距)) / 行数
        CGFloat height = (_collectionView.height - (_rows - 1) * _verticalSpacing - (_padding.top + _padding.bottom + _margin.top + _margin.bottom)) / _rows;
        _layout.itemSize = CGSizeMake(_layout.itemSize.width, height);
    }
}

-(void)setVerticalSpacing:(CGFloat)verticalSpacing
{
    _verticalSpacing = verticalSpacing;
    _layout.minimumLineSpacing = verticalSpacing;
    [self setNeedsLayout];
}

#pragma mark Delegate

//DataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [_collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    return cell;
}

//Delegate
@end

