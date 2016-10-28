//
//  ProfileViewController.m
//  Bilibili
//
//  Created by LunarEclipse on 16/9/2.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileTitleView.h"
#import "ProfileContentViewController.h"

#import "AccountManager.h"

@import YYKit;
@import SDWebImage;

@interface ProfileViewController ()

@property (nonatomic, strong) ProfileTitleView * profileTitleView;
@property (nonatomic, strong) ProfileContentViewController * contentController;

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.profileTitleView = [[NSBundle mainBundle] loadNibNamed:@"ProfileTitleView" owner:nil options:nil].firstObject;
    self.titleView = self.profileTitleView;
    
    self.contentController = [[ProfileContentViewController alloc] initWithNibName:nil bundle:nil];
    self.contentController.view.frame = self.contentView.bounds;
    [self.contentView addSubview:self.contentController.view];
}

- (void)viewWillAppear:(BOOL)animated
{
    AccountModel * account = [AccountManager manager].currentAccount;
    
    if (account == nil)
    {
        _profileTitleView.loginView.hidden = NO;
        _profileTitleView.profileView.hidden = YES;
    }
    else
    {
        _profileTitleView.usernameLabel.text = account.user.name;
        _profileTitleView.coinsLabel.text = account.user.coins.stringValue;
        [_profileTitleView.portraitImageView sd_setImageWithURL:[NSURL URLWithString:account.user.face]];
        if (account.user.level_info.current_level <= 9 &&
            account.user.level_info.current_level >= 0)
        {
            NSString * imageName = [NSString stringWithFormat:@"misc_level_whiteLv%ld", account.user.level_info.current_level];
            _profileTitleView.levelImageView.image = [UIImage imageNamed:imageName];
        }
        
        _profileTitleView.loginView.hidden = YES;
        _profileTitleView.profileView.hidden = NO;
    }
}

@end
