//
//  SeasonsCollectionViewCell.m
//  Bilibili
//
//  Created by LunarEclipse on 16/10/21.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "SeasonsCollectionViewCell.h"
#import "extension.h"

@implementation SeasonsCollectionViewCell

- (void)awakeFromNib
{
    
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected) self.titleLabel.textColor = RGB(234, 91, 141);
    else self.titleLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1];
}


-(void)setType:(SeasonsCollectionViewCellType)type
{
    _type = type;
    
    UIImageView * imageView;
    UIImageView * selectedImageView;
    
    switch (type)
    {
        case SeasonsCollectionViewCellTypeLeft:
            imageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"season_seasonLeft"]];
            selectedImageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"season_seasonLeft_s"]];
            break;
        case SeasonsCollectionViewCellTypeMiddle:
            imageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"season_seasonMiddle"]];
            selectedImageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"season_seasonMiddle_s"]];
            break;
        case SeasonsCollectionViewCellTypeRight:
            imageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"season_seasonRight"]];
            selectedImageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"season_seasonRight_s"]];
            break;
    }
    
    self.backgroundView = imageView;
    self.selectedBackgroundView = selectedImageView;
}

-(void)setup:(BangumiModel *)season
{
    _season = season;
    
    self.titleLabel.text = season.title;
}

@end
