//
//  LiveMessagesCell.h
//  Bilibili
//
//  Created by LunarEclipse on 16/10/25.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "LiveMessagesCellModel.h"

@import UIKit;
@import YYKit;

@interface LiveMessagesCell : UITableViewCell

@property (nonatomic, strong) YYLabel * label;

-(void)setup:(LiveMessagesCellModel *)viewModel;

@end
