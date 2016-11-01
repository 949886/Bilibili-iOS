//
//  LiveViewController.m
//  Bilibili
//
//  Created by LunarEclipse on 16/10/10.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "LiveViewController.h"
#import "LiveMessagesController.h"
#import "LiveRankController.h"
#import "VideoPlayerController.h"

#import "SegmentedControl.h"

#import "BilibiliAPI.h"
#import "DanmakuFramework.h"

@import YYKit;
@import SDWebImage;

@interface LiveViewController ()

@property (nonatomic, strong) LiveModel * live;
@property (nonatomic, strong) LiveRoomModel * liveRoom;

@property (nonatomic, strong) DanmakuView * danmakuView;
@property (nonatomic, strong) SegmentedControl * segmentedControl;

@property (nonatomic, strong) VideoPlayerController * videoPlayerController;
@property (nonatomic, strong) LiveMessagesController * liveMessagesController;

@property (nonatomic, assign) BOOL hideStatusBar;

@property (weak, nonatomic) IBOutlet UIView *titleBar;
@property (weak, nonatomic) IBOutlet UIView *playerView;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *portraitImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewerCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UIButton *roomInfoButton;
@property (weak, nonatomic) IBOutlet UIButton *followButton;
@property (weak, nonatomic) IBOutlet UIButton *ownerInfoButton;
@property (weak, nonatomic) IBOutlet UITextField *danmakuTextField;

@end

@implementation LiveViewController

#pragma mark Initialization

-(instancetype)initWithLive:(LiveModel *)live
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _live = live;
    }
    return self;
}

#pragma mark Override

- (void)viewDidLoad
{
    [super viewDidLoad];
//    __weak typeof(self) weakSelf = self;
    
    self.live = _live;
    if (self.navigationController)
        self.navigationController.delegate = self;
    
    //VideoPlayer
    if ([_live.playurl isNotBlank])
        [self setupPlayer];
    
    //SegmentControl
    SegmentedControl * segmentedControl = [[SegmentedControl alloc]initWithType:SegmentedControlTypeUnderlined];
    segmentedControl.size = CGSizeMake(kScreenWidth - 16 , 40);
    segmentedControl.centerX = kScreenWidth * 0.5;
    segmentedControl.bottom = _infoView.height;
    segmentedControl.index = 0;
    segmentedControl.color = [UIColor colorWithRed:1.000 green:0.329 blue:0.498 alpha:1.000];
    segmentedControl.font = [UIFont fontWithName:@"AvenirNext-UltraLight" size:15];
    segmentedControl.items = @[@"互动", @"活动", @"七日榜", @"粉丝榜"].mutableCopy;
    self.segmentedControl = segmentedControl;
    [_infoView addSubview:segmentedControl];
    
    //Live Messages
    _liveMessagesController = [[LiveMessagesController alloc] initWithRoomID:_live.room_id];
    _liveMessagesController.view.frame = _scrollView.bounds;
    _liveMessagesController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_scrollView addSubview:_liveMessagesController.view];
    
    //Load data.
    [self loadLiveRoomInfo];
}

- (BOOL)prefersStatusBarHidden
{
    return _hideStatusBar;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


#pragma mark Delegate

/* UINavigationControllerDelegate */

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //隐藏导航栏
    [navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark Getter & Setter

-(void)setLive:(LiveModel *)live
{
    _live = live;
    
    _titleLabel.text = live.title;
    _viewerCountLabel.text = @(live.online).stringValue;
    [_ownerInfoButton setTitle:live.owner.name forState:UIControlStateNormal];
    [_portraitImageView sd_setImageWithURL:[NSURL URLWithString:_live.owner.face] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
}

#pragma mark Encapsulation

-(void)loadUserInfo
{
    [BilibiliAPI getUserWithID:_live.owner.mid success:^(UserModel * object, BilibiliResponse * response) {
        
    } failure:^(BilibiliResponse * response, NSError * error) {
#ifdef DEBUG
        NSLog(@"%@", response);
        NSLog(@"%@", error);
#endif
    }];
}

-(void)loadLiveRoomInfo
{
    __weak typeof(self) weakSelf = self;
    [BilibiliAPI getLiveRoomIndexWithRoomID:_live.room_id success:^(LiveRoomModel * object, BilibiliResponse * response) {
        weakSelf.liveRoom = object;
        [weakSelf refreshUI];
    } failure:^(BilibiliResponse * response, NSError * error) {
#ifdef DEBUG
        NSLog(@"%@", response);
        NSLog(@"%@", error);
#endif
    }];
}

-(void)refreshUI
{
    
}

-(void)setupPlayer
{
    __weak typeof(self) weakSelf = self;
    
    _videoPlayerController = [[VideoPlayerController alloc] initWithType:VideoPlayerLive];
    _videoPlayerController.player.url = _live.playurl;
    [_videoPlayerController.player showInView:_playerView];
    _videoPlayerController.player.onClick = ^(VideoPlayer * player){
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            weakSelf.titleBar.alpha = player.hideWidgets ? 0 : 1;
        } completion:nil];
        weakSelf.hideStatusBar = player.hideWidgets;
        [weakSelf setNeedsStatusBarAppearanceUpdate];
    };
}

#pragma mark IBAction

//返回按钮
- (IBAction)onClickBackButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onClickVideo:(id)sender
{
    if (_videoPlayerController.player.player.isPreparedToPlay) {
        [_videoPlayerController.player play];
    }
}

- (IBAction)onClickRoomInfoButton:(id)sender
{
    
}

- (IBAction)onClickOwnerInfoButton:(id)sender
{
    
}

- (IBAction)onClickFollowButton:(id)sender
{
    
}

- (IBAction)onClickGiftButton:(id)sender
{
    
}

@end
