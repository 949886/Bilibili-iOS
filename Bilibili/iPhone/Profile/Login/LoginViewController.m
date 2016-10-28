//
//  LoginViewController.m
//  Bilibili
//
//  Created by LunarEclipse on 16/10/15.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "LoginViewController.h"

#import "AccountManager.h"

#import "BilibiliAPI.h"
#import "BilibiliException.h"

@import YYKit;
@import ReactiveCocoa;

@interface LoginViewController ()

@property (nonatomic, assign) BOOL isLoggingIn;

@end

@implementation LoginViewController

#pragma mark Override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    
    
    [_usernameTextField becomeFirstResponder];
    
    //Textfield Control Signal.
    
    [[_usernameTextField rac_signalForControlEvents:UIControlEventEditingDidBegin] subscribeNext:^(id x) {
        weakSelf.userImageView.image = [UIImage imageNamed:@"ictab_me_selected"];
        weakSelf.headerImageView.image = [UIImage imageNamed:@"login_header"];
    }];
    [[_usernameTextField rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(id x) {
        weakSelf.userImageView.image = [UIImage imageNamed:@"ictab_me"];
    }];
    [[_usernameTextField rac_signalForControlEvents:UIControlEventEditingDidEndOnExit] subscribeNext:^(id x) {
        [weakSelf.passwordTextField becomeFirstResponder];
        
    }];
    
    [[_passwordTextField rac_signalForControlEvents:UIControlEventEditingDidBegin] subscribeNext:^(id x) {
        weakSelf.lockImageView.image = [UIImage imageNamed:@"pws_icon_hover"];
        weakSelf.headerImageView.image = [UIImage imageNamed:@"login_header_cover_eyes"];
    }];
    [[_passwordTextField rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(id x) {
        weakSelf.lockImageView.image = [UIImage imageNamed:@"pws_icon"];
    }];
    [[_passwordTextField rac_signalForControlEvents:UIControlEventEditingDidEndOnExit] subscribeNext:^(id x) {
        [weakSelf onLoginButtonClick:nil];
    }];
    
    //Textfield Text signal.
    
    RACSignal * isUsernameValidSignal = [_usernameTextField.rac_textSignal map:^id(NSString * text) {
        if (text.length >= 1) return @(YES);
        else return @(NO);
    }];
    
    RACSignal * isPasswordValidSignal = [_passwordTextField.rac_textSignal  map:^id(NSString * text) {
        if (text.length >= 6) return @(YES);
        else return @(NO);
    }];
    
    //聚合信号
    [[RACSignal combineLatest:@[isUsernameValidSignal, isPasswordValidSignal]
                       reduce:^id(NSNumber * isUsernameValid, NSNumber * isPasswordValid){
        return @([isUsernameValid boolValue] && [isPasswordValid boolValue]);
    }] subscribeNext:^(NSNumber * isLoginValid) {
        BOOL boolean = [isLoginValid boolValue];
        weakSelf.loginButton.alpha = boolean ? 1 : 0.5;
        weakSelf.loginButton.userInteractionEnabled = boolean;
    }];
}

#pragma mark Delegate

/* Delegate */

#pragma mark IBAction

- (IBAction)onCloseButtonClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onForgotPasswordButtonClick:(id)sender
{
    
}

- (IBAction)onRegisterButtonClick:(id)sender
{
    
}

- (IBAction)onLoginButtonClick:(id)sender
{
    if (_isLoggingIn) return;
    _isLoggingIn = YES;
    _loginButton.alpha = 0.5;
    _loginButton.userInteractionEnabled = NO;
    
    __weak typeof(self) weakSelf = self;
    
    NSString * username = _usernameTextField.text;
    NSString * password = _passwordTextField.text;
    
    [BilibiliAPI loginWithUsername:username password:password success:^(LoginResponse * loginResonse, BilibiliResponse * response) {
        NSLog(@"%@", @(loginResonse.uid));
        [BilibiliAPI getUserWithID:loginResonse.uid success:^(UserModel * user, BilibiliResponse * response) {
            if(!user || !user.name || ![user.name isNotBlank])
            {
                weakSelf.isLoggingIn = NO;
                weakSelf.loginButton.alpha = 1;
                weakSelf.loginButton.userInteractionEnabled = YES;
                return;
            }
            
            AccountModel * account = [AccountModel new];
            account.user = user;
            account.cookie = loginResonse.cookie.value;
            account.expiresIn = [NSDate date].timeIntervalSince1970 + loginResonse.expiresIn;
            [[AccountManager manager] addAccount:account];
            NSLog(@"登陆成功");
            [weakSelf onCloseButtonClick:nil];
        } failure:^(BilibiliResponse * response, NSError * error) {
            weakSelf.isLoggingIn = NO;
            weakSelf.loginButton.alpha = 1;
            weakSelf.loginButton.userInteractionEnabled = YES;
#ifdef DEBUG
            NSLog(@"%@", response);
            NSLog(@"%@", error);
#endif
        }];
    } failure:^(BilibiliResponse * response, NSError * error) {
        weakSelf.isLoggingIn = NO;
        weakSelf.loginButton.alpha = 1;
        weakSelf.loginButton.userInteractionEnabled = YES;
        
        if (error) NSLog(@"登录失败，请检查网络设置");
        if (response)
            switch (response.code)
            {
                case BILI_E_PASSWORD_RETRIED_TOO_MANY_TIMES: break;
                case BILI_E_USER_IS_NOT_EXISTS:
                    NSLog(@"用户名不存在");
                    break;
                    
                case BILI_E_PASSWORD_ERROR:
                    NSLog(@"密码错误");
                    break;
                    
                case BILI_E_PASSWORD_IS_LEAKED:
                    NSLog(@"密码不安全，请修改密码");
                    break;
                    
                default:break;
            }
    }];
}

@end
