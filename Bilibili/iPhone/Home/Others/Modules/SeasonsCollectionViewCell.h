//
//  SeasonsCollectionViewCell.h
//  Bilibili
//
//  Created by LunarEclipse on 16/10/21.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BangumiModel.h"

typedef NS_ENUM(NSInteger, SeasonsCollectionViewCellType)
{
    SeasonsCollectionViewCellTypeLeft,
    SeasonsCollectionViewCellTypeMiddle,
    SeasonsCollectionViewCellTypeRight
};

@interface SeasonsCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) SeasonsCollectionViewCellType type;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) BangumiModel * season;

-(void)setup:(BangumiModel *)season;

@end
