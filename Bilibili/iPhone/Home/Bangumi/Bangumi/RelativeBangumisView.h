//
//  RelativeBangumisView.h
//  Bilibili
//
//  Created by LunarEclipse on 16/10/21.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BangumiModel;

@interface RelativeBangumisView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, assign) NSInteger seasonID;

@end
