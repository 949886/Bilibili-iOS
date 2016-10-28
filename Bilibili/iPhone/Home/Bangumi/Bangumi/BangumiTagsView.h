//
//  BangumiTagsView.h
//  Bilibili
//
//  Created by LunarEclipse on 16/10/22.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TagModel;

@interface BangumiTagsView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray<TagModel *> * tags;


@end
