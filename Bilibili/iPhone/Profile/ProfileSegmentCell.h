//
//  ProfileSegmentCell.h
//  Bilibili
//
//  Created by LunarEclipse on 16/10/15.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileSegmentCell : UITableViewCell <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, assign, readonly) NSInteger itemCount;

-(void)setIcons:(NSArray<NSString *> *)icons titles:(NSArray<NSString *> *)titles classes:(NSArray<Class> *)classes;

@end
