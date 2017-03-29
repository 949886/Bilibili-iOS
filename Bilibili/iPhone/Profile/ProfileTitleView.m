//
//  ProfileTitleView.m
//  Bilibili
//
//  Created by LunarEclipse on 16/10/12.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "ProfileTitleView.h"
#import "LoginViewController.h"

@import YYKit;

@implementation ProfileTitleView

#pragma mark Initialization

- (instancetype)init
{
    if (self = [super init])
        [self initialize];
    return self;
}

-(void)initialize
{
    
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self initialize];
}

#pragma mark IBAction

- (IBAction)onLoginButtonClick:(id)sender
{
    LoginViewController * loginViewController = [LoginViewController new];
    [self.viewController presentViewController:loginViewController animated:YES completion:nil];
}

- (IBAction)onRegisterButtonClick:(id)sender
{
    
}

- (IBAction)onProfileButtonClick:(id)sender
{
    
}

@end
