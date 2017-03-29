//
//  ProfileItemCell.m
//  Bilibili
//
//  Created by LunarEclipse on 16/10/13.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "ProfileItemCell.h"

@implementation ProfileItemCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

@end


@implementation ProfileItemSeparator

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.000];
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    self.frame = layoutAttributes.frame;
}

@end


@implementation ProfileItemLayout

- (void)prepareLayout
{
    // Registers decoration views.
    [self registerClass:[ProfileItemSeparator class] forDecorationViewOfKind:@"Start"];
    [self registerClass:[ProfileItemSeparator class] forDecorationViewOfKind:@"End"];
    [self registerClass:[ProfileItemSeparator class] forDecorationViewOfKind:@"Vertical"];
    [self registerClass:[ProfileItemSeparator class] forDecorationViewOfKind:@"Horizontal"];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *baseLayoutAttributes = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray * layoutAttributes = [baseLayoutAttributes mutableCopy];
    
    for (UICollectionViewLayoutAttributes *thisLayoutItem in baseLayoutAttributes)
    {
        if (thisLayoutItem.representedElementCategory == UICollectionElementCategoryCell)
        {
            if ([self isFirstInSection:thisLayoutItem.indexPath]) //Is first item
            {
                UICollectionViewLayoutAttributes *newHorizontalLayoutItem = [self layoutAttributesForDecorationViewOfKind:@"Start" atIndexPath:thisLayoutItem.indexPath];
                [layoutAttributes addObject:newHorizontalLayoutItem];
            }
            
            if ([self isLastInSection:thisLayoutItem.indexPath])
            {
                UICollectionViewLayoutAttributes *newHorizontalLayoutItem = [self layoutAttributesForDecorationViewOfKind:@"End" atIndexPath:thisLayoutItem.indexPath];
                [layoutAttributes addObject:newHorizontalLayoutItem];
            }
            
            // Adds vertical lines when the item isn't the last in a section or in line.
            if (![self isLastLine:thisLayoutItem.indexPath]) {
                UICollectionViewLayoutAttributes *newLayoutItem = [self layoutAttributesForDecorationViewOfKind:@"Vertical" atIndexPath:thisLayoutItem.indexPath];
                [layoutAttributes addObject:newLayoutItem];
            }
            
            // Adds horizontal lines when the item isn't in the last line.
            if ([self isFirstInLine:thisLayoutItem.indexPath])
            {
                NSIndexPath * indexPath = thisLayoutItem.indexPath;
                for (int i = 1; i == 1 || ![self isFirstInLine:indexPath]; ++i) {
                    UICollectionViewLayoutAttributes *newHorizontalLayoutItem = [self layoutAttributesForDecorationViewOfKind:@"Horizontal" atIndexPath:indexPath];
                    [layoutAttributes addObject:newHorizontalLayoutItem];
//                    rect = newHorizontalLayoutItem.frame;
                    indexPath = [NSIndexPath indexPathForItem:thisLayoutItem.indexPath.row + i inSection:thisLayoutItem.indexPath.section];
                }
            }
        }
    }
    
    return layoutAttributes;
}

//-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
//{
//    return NO;
//}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind atIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:indexPath.row + 1 inSection:indexPath.section];
    
    UICollectionViewLayoutAttributes *cellAttributes = [self layoutAttributesForItemAtIndexPath:indexPath];
    UICollectionViewLayoutAttributes *nextCellAttributes = [self layoutAttributesForItemAtIndexPath:nextIndexPath];
    
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:decorationViewKind withIndexPath:indexPath];
    
    CGRect baseFrame = cellAttributes.frame;
    CGRect nextFrame = nextCellAttributes.frame;
    
    CGFloat strokeWidth = 0.5;
    CGFloat spaceToNextItem = 0;
    if (nextFrame.origin.y == baseFrame.origin.y)
        spaceToNextItem = (nextFrame.origin.x - baseFrame.origin.x - baseFrame.size.width);
    
    if ([decorationViewKind isEqualToString:@"Start"]) {
        layoutAttributes.frame = CGRectMake(baseFrame.origin.x,
                                            0,
                                            self.collectionView.bounds.size.width,
                                            strokeWidth);
    }
    
    if ([decorationViewKind isEqualToString:@"End"]) {
        layoutAttributes.frame = CGRectMake(0,
                                            baseFrame.origin.y + baseFrame.size.height - 1,
                                            self.collectionView.bounds.size.width,
                                            strokeWidth);
    }
    
    if ([decorationViewKind isEqualToString:@"Horizontal"]) {
        CGFloat padding = 0;
        // Positions the vertical line for this item.
        CGFloat x = baseFrame.origin.x + baseFrame.size.width + (spaceToNextItem - strokeWidth)/2;
        layoutAttributes.frame = CGRectMake(x,
                                            baseFrame.origin.y + padding - strokeWidth,
                                            strokeWidth,
                                            baseFrame.size.height - padding*2);
    }
    if ([decorationViewKind isEqualToString:@"Vertical"]){
        // Positions the horizontal line for this item.
        layoutAttributes.frame = CGRectMake(baseFrame.origin.x,
                                            baseFrame.origin.y + baseFrame.size.height - strokeWidth,
                                            baseFrame.size.width + spaceToNextItem,
                                            strokeWidth);
    }
    
    layoutAttributes.zIndex = -1;
    return layoutAttributes;
}


- (BOOL)isFirstInSection:(NSIndexPath *)indexPath
{
    return 0 == indexPath.row;
}

- (BOOL)isLastInSection:(NSIndexPath *)indexPath
{
    NSInteger lastItem = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:indexPath.section] -1;
    return  lastItem == indexPath.row;
}

- (BOOL)isFirstLine:(NSIndexPath *)indexPath
{
    NSIndexPath *lastItem = [NSIndexPath indexPathForItem:0 inSection:indexPath.section];
    UICollectionViewLayoutAttributes *lastItemAttributes = [self layoutAttributesForItemAtIndexPath:lastItem];
    UICollectionViewLayoutAttributes *thisItemAttributes = [self layoutAttributesForItemAtIndexPath:indexPath];
    return lastItemAttributes.frame.origin.y == thisItemAttributes.frame.origin.y;
}

- (BOOL)isLastLine:(NSIndexPath *)indexPath
{
    NSInteger lastItemRow = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:indexPath.section] -1;
    NSIndexPath *lastItem = [NSIndexPath indexPathForItem:lastItemRow inSection:indexPath.section];
    UICollectionViewLayoutAttributes *lastItemAttributes = [self layoutAttributesForItemAtIndexPath:lastItem];
    UICollectionViewLayoutAttributes *thisItemAttributes = [self layoutAttributesForItemAtIndexPath:indexPath];
    return lastItemAttributes.frame.origin.y == thisItemAttributes.frame.origin.y;
}

- (BOOL)isFirstInLine:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) return YES;
    
    NSIndexPath *previousIndexPath = [NSIndexPath indexPathForItem:indexPath.row - 1 inSection:indexPath.section];
    
    UICollectionViewLayoutAttributes *cellAttributes = [self layoutAttributesForItemAtIndexPath:indexPath];
    UICollectionViewLayoutAttributes *previousCellAttributes = [self layoutAttributesForItemAtIndexPath:previousIndexPath];
    
    return !(cellAttributes.frame.origin.y == previousCellAttributes.frame.origin.y);
}

- (BOOL)isLastInLine:(NSIndexPath *)indexPath
{
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:indexPath.row + 1 inSection:indexPath.section];
    
    UICollectionViewLayoutAttributes *cellAttributes = [self layoutAttributesForItemAtIndexPath:indexPath];
    UICollectionViewLayoutAttributes *nextCellAttributes = [self layoutAttributesForItemAtIndexPath:nextIndexPath];
    
    return !(cellAttributes.frame.origin.y == nextCellAttributes.frame.origin.y);
}

@end
