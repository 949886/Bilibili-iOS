//
//  CommentCell.m
//  Bilibili
//
//  Created by LunarEclipse on 16/9/18.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "CommentCell.h"

@import SDWebImage;
@import ReactiveObjC;

@interface CommentCell ()

@property (nonatomic, strong) CommentModel * comment;

@end

@implementation CommentCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)setup:(CommentModel *)comment
{
    _comment = comment;
    
    _usernameLabel.text = comment.member.name;
    _statusLabel.text = [NSString stringWithFormat:@"#%ld", (long)comment.floor];
    _contentLabel.text = comment.content.message;
    _repliesLabel.text = [@(comment.rcount) stringValue];
    _likesLabel.text = [@(comment.like) stringValue];
    
    BOOL hideReplyCount = comment.rcount <= 0;
    _repliesImageView.hidden = hideReplyCount;
    _repliesLabel.hidden = hideReplyCount;
    
    [_portraitImageView sd_setImageWithURL:[NSURL URLWithString:comment.member.face]];
    
    if (comment.member.level_info.current_level <= 9 &&
        comment.member.level_info.current_level >= 0)
    {
        NSString * imageName = [NSString stringWithFormat:@"misc_level_whiteLv%ld", (long)comment.member.level_info.current_level];
        _levelImageView.image = [UIImage imageNamed:imageName];
    }
    
    if ([comment.member.sex isEqualToString:@"男"])
        _genderImageView.image = [UIImage imageNamed:@"misc_sex_male"];
    else if ([comment.member.sex isEqualToString:@"女"])
        _genderImageView.image = [UIImage imageNamed:@"misc_sex_female"];
    else _genderImageView.image = nil;
}

- (IBAction)onLikeButtonClick:(id)sender
{
    
}

- (IBAction)onMoreButtonClick:(id)sender
{
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"cancle", 取消) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"comment_actionSheet_report", 举报), nil];
    [[actionSheet rac_buttonClickedSignal]subscribeNext:^(NSNumber * index) {
        if (index.integerValue == 0)
        {
            NSLog(@"举报");
        }
    }];
    
    [actionSheet showInView:self.window];
}

@end
