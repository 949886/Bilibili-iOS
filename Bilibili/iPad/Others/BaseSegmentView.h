//
//  BaseSegmentView.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/15.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseSegmentView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionViewFlowLayout * layout;

@property (nonatomic, assign) UIEdgeInsets margin;           //view的外边距（与HTML类似）
@property (nonatomic, assign) UIEdgeInsets padding;          //view的内边距

@property (nonatomic, assign) NSInteger columns;        //一行几列，由此决定cell宽度（0则应用layout默认高度）
@property (nonatomic, assign) NSInteger rows;           //一行几列，由此决定cell高度（0则应用layout默认高度）

@property (nonatomic, assign) CGFloat horizonalSpacing;
@property (nonatomic, assign) CGFloat verticalSpacing;

@property (nonatomic, strong, readonly) UICollectionView * collectionView;

-(instancetype)initWithFrame:(CGRect)frame cellPrototype:(Class)prototype;
-(instancetype)initWithFrame:(CGRect)frame nibName:(NSString *) nibName;

@end
