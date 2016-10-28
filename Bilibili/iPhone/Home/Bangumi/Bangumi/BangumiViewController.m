//
//  BangumiViewController.m
//  Bilibili
//
//  Created by LunarEclipse on 16/10/17.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "BangumiViewController.h"
#import "BangumiHeaderController.h"

#import "CommentCell.h"

#import "BangumiModel.h"
#import "BilibiliAPI.h"

@import YYKit;

@interface BangumiViewController ()

@property (nonatomic, assign) NSInteger sid;
@property (nonatomic, strong) BangumiModel * bangumi;

@property (nonatomic, strong) BangumiHeaderController * headerController;

@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
@property (nonatomic, strong) UIView * navigationBarBackground;

@end

@implementation BangumiViewController

#pragma mark Initialization

-(instancetype)initWithBangumi:(BangumiModel *)bangumi
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _bangumi = bangumi;
        _sid = bangumi.season_id;
    }
    return self;
}

-(instancetype)initWithSeasonID:(NSInteger)sid
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _sid = sid;
    }
    return self;
}

#pragma mark Override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Init
    _statusBarStyle = UIStatusBarStyleLightContent;
    _navigationBarBackground = [[UIView alloc] initWithFrame:CGRectMake(0, -20, kScreenWidth, 64)];
    
    //Navigatior
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = NSLocalizedString(@"bangumi_title", nil);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"common_back_v2"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickBackItem:)];
    
    self.navigationController.navigationBar.tintColor = [UIColor clearColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor clearColor]};
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar addSubview:_navigationBarBackground];
    [self.navigationController.navigationBar sendSubviewToBack:_navigationBarBackground];
    
    //Header
    _headerController = [BangumiHeaderController new];
    _headerController.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.000];
    self.tableView.tableHeaderView = _headerController.view;
    
    @weakify(self);
    _headerController.onSeasonSelected = ^(BangumiModel * bangumi){
        @strongify(self);
        self.page = 0;
        [self loadBangumi:bangumi.season_id];
    };
    _headerController.onEpisodeSelected = ^(EpisodeModel * episode){
        @strongify(self);
        self.page = 0;
        self.aid = episode.av_id;
    };
    
    //API.
    [self loadBangumi:_sid];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.navigationBar.alpha = 0;
    _navigationBarBackground.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.navigationController.navigationBar.alpha = 1;
    self.navigationController.navigationBar.tintColor = nil;
    self.navigationController.navigationBar.titleTextAttributes = nil;
    
    [_navigationBarBackground removeFromSuperview];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return _statusBarStyle;
}

#pragma mark Delegate

/* ScrollView Delegate */

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float offset = scrollView.contentOffset.y;
    
    //禁止顶部bounce
    if (offset < 0) self.tableView.contentOffset = CGPointZero;
    
    //更新StatusBar
    UIStatusBarStyle previousStyle = _statusBarStyle;
    if (offset > 40)  _statusBarStyle = UIStatusBarStyleDefault;
    else _statusBarStyle = UIStatusBarStyleLightContent;
    if (previousStyle != _statusBarStyle)
        [self setNeedsStatusBarAppearanceUpdate];
    
    //更新navigationBar透明度
    self.navigationController.navigationBar.alpha = offset / 50;
}


#pragma mark Encapsulation

-(void)loadBangumi:(NSInteger)sid
{
    @weakify(self);
    [BilibiliAPI getBangumiInfoWithSid:sid success:^(BangumiModel * object, BilibiliResponse * response) {
        @strongify(self);
        if (!self) return;
        
        self.bangumi = object;
        [self refreshUI];
        
    } failure:^(BilibiliResponse * response, NSError * error) {
#ifdef DEBUG
        NSLog(@"%s %@", __func__, response);
        NSLog(@"%s %@", __func__, error);
#endif
    }];
}

-(void)refreshUI
{
    _headerController.bangumi = _bangumi;
    self.tableView.tableHeaderView = _headerController.view;
    
    if (_bangumi.user_season.last_ep_index < _bangumi.episodes.count) {
        self.aid = _bangumi.episodes[_bangumi.user_season.last_ep_index].av_id;
    }
}

#pragma mark Callback

- (void)onClickBackItem:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
