//
//  LiveMessagesCell.m
//  Bilibili
//
//  Created by LunarEclipse on 16/10/25.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "LiveMessagesCell.h"

@interface LiveMessagesCell ()

@property (nonatomic, strong) LiveMessagesCellModel * viewModel;

@end

@implementation LiveMessagesCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
        [self initialize];
    return self;
}

- (void)initialize
{
    _label = [[YYLabel alloc] initWithFrame:self.bounds];
    _label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:_label];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:NO animated:animated];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x += LIVE_MESSAGES_MARGIN;
    frame.size.width -= 2 * LIVE_MESSAGES_MARGIN;
    [super setFrame:frame];
}

-(void)setup:(LiveMessagesCellModel *)viewModel
{
    _viewModel = viewModel;
    
    _label.textLayout = viewModel.layout;
}

@end
