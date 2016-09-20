//
//  FlowCollectionView.m
//  Bilibili
//
//  Created by LunarEclipse on 16/9/7.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "FlowCollectionView.h"

@import YYKit;

@implementation FlowCollectionView

#pragma mark Initialization

- (instancetype)initWithFrame:(CGRect)frame
{
    _layout = [UICollectionViewFlowLayout new];
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _layout.minimumInteritemSpacing = 0;
    _layout.minimumLineSpacing = 0;
    
    if (self = [super initWithFrame:frame collectionViewLayout:_layout])
        [self initialize];
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout])
        [self initialize];
    return self;
}

-(void)initialize
{
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.backgroundColor = [UIColor clearColor];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.collectionViewLayout = _layout;
}

#pragma mark Override

-(void)layoutSubviews
{
     [super layoutSubviews];
    
    UIEdgeInsets padding = self.contentInset;
    CGFloat spacing = _layout.minimumInteritemSpacing;
    CGFloat lineSpacing = _layout.minimumLineSpacing;
    
    if (_columns >= 1)
    {
        CGFloat width = floorf((self.width - (_columns - 1) * _horizonalSpacing - (padding.left + padding.right))) / _columns - ceilf(spacing * (_columns - 1) / _columns) - 2.0 / _columns;
        _layout.itemSize = CGSizeMake(width, _layout.itemSize.height);
    }
    if (_rows >= 1)
    {
        CGFloat height = floorf((self.height - (_rows - 1) * _verticalSpacing - (padding.top + padding.bottom))) / _rows - ceilf(lineSpacing * (_rows - 1) / _rows) - 2.0 / _rows;
        _layout.itemSize = CGSizeMake(_layout.itemSize.width, height) ;
    }
}


-(void)setVerticalSpacing:(CGFloat)verticalSpacing
{
    _verticalSpacing = verticalSpacing;
    _layout.minimumLineSpacing = verticalSpacing;
    [self setNeedsLayout];
}

@end
