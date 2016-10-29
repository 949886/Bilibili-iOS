//
//  VideoViewController.m
//  Bilibili
//
//  Created by LunarEclipse on 16/9/13.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoBriefController.h"
#import "CommentViewController.h"
#import "VideoPlayerController.h"

#import "BilibiliAPI.h"
#import "DanmakuFramework.h"

#import "BilibiliVideoPlayer.h"
#import "SegmentedControl.h"

@import YYKit;
@import GPUImage;
@import SDWebImage;
@import ReactiveCocoa;

@interface VideoViewController ()

@property (nonatomic, assign) NSInteger aid;
@property (nonatomic, assign) NSInteger eid;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, strong) VideoModel * video;
@property (nonatomic, strong) PlayURLModel * playURL;

@property (nonatomic, copy) NSString * url;

@property (nonatomic, strong) VideoPlayer * player;
@property (nonatomic, strong) DanmakuView * danmakuView;
@property (nonatomic, strong) SegmentedControl * segmentedControl;

@property (nonatomic, strong) VideoPlayerController * videoPlayerController;
@property (nonatomic, strong) VideoBriefController * videoBriefController;
@property (nonatomic, strong) CommentViewController * commentViewController;

@property (nonatomic, assign) BOOL isSuccess;
@property (nonatomic, assign) BOOL hideStatusBar;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UIButton *playerButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIView *playerView;
@property (weak, nonatomic) IBOutlet UIImageView *portraitImageView;
@property (weak, nonatomic) IBOutlet UITextField *danmakuTextField;
@property (weak, nonatomic) IBOutlet UIView *tabsView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *titleBar;

@end

@implementation VideoViewController

#pragma mark Initialization

-(instancetype)initWithAID:(NSInteger)aid
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _aid = aid;
    }
    return self;
}

-(instancetype)initWithAID:(NSInteger)aid episodeID:(NSInteger)eid
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _aid = aid;
        _eid = eid;
    }
    return self;
}

-(void)dealloc
{
    [_player removeFromSuperview];
}

#pragma mark Override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Init
    
    if (self.navigationController)
        self.navigationController.delegate = self;
    
    _videoPlayerController = [[VideoPlayerController alloc] initWithType:VideoPlayerDefault];
    _playerView.clipsToBounds = NO;
    _player = _videoPlayerController.player;
    
    _danmakuView = [DanmakuView new];
    
    _scrollView.contentSize = CGSizeMake(2 * [UIScreen mainScreen].bounds.size.width, _scrollView.height);
    
    [_danmakuTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    //VideoBriefController & CommentViewController
    _videoBriefController = [VideoBriefController new];
    _videoBriefController.tableView.frame = _scrollView.bounds;
    [_scrollView addSubview:_videoBriefController.tableView];
    
    _commentViewController = [[CommentViewController alloc] initWithAID:_aid];
    _commentViewController.view.frame = _scrollView.bounds;
    _commentViewController.view.left = _videoBriefController.view.right;
    [_scrollView addSubview:_commentViewController.view];
    
    //Setup SegmentedControl
    SegmentedControl * segmentedControl = [[SegmentedControl alloc]initWithType:SegmentedControlTypeUnderlined];
    segmentedControl.frame = CGRectMake(0, 0, kScreenWidth * 2 / 3 , _tabsView.height);
    segmentedControl.centerX = _tabsView.centerX;
    segmentedControl.index = 0;
    segmentedControl.color = [UIColor colorWithRed:1.000 green:0.329 blue:0.498 alpha:1.000];
    segmentedControl.font = [UIFont fontWithName:@"AvenirNext-UltraLight" size:12];
    segmentedControl.items = @[@"简介", @"评论"].mutableCopy;
    self.segmentedControl = segmentedControl;
    
    [_tabsView addSubview:segmentedControl];
    
    __weak typeof(self) weakSelf = self;
    [segmentedControl handleEventWithBlock:^(NSInteger index) { //监听点击
        [weakSelf.scrollView setContentOffset:CGPointMake(index * weakSelf.scrollView.width, 0) animated:YES];
    }];
    
    [[_scrollView rac_valuesForKeyPath:@"contentOffset" observer:nil]subscribeNext:^(id x) {
        int page = weakSelf.scrollView.contentOffset.x / weakSelf.scrollView.width + 0.5;
        if(page >= weakSelf.segmentedControl.items.count) return;
        if(page != weakSelf.segmentedControl.index)
            weakSelf.segmentedControl.index = page;
    }];
    
    //Load data with API.
    [self loadVideoData];
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

#pragma mark Encapsulation

-(void)loadVideoData
{
    [self.videoPlayerController.player log:@"正在获取视频信息..."];
    
    __weak typeof(self) weakSelf = self;
    [BilibiliAPI getVideoInfoWithAID:_aid success:^(VideoModel * object, BilibiliResponse * response) {
        weakSelf.video = object;
        weakSelf.videoBriefController.video = object;
        [weakSelf refreshUI];
        [weakSelf loadPlayURL];
        [weakSelf loadDanmaku];
    } failure:^(BilibiliResponse * response, NSError * error) {
#ifdef DEBUG
        NSLog(@"%@", response);
        NSLog(@"%@", error);
#endif
    }];
}

-(void)loadPlayURL
{
    if(_page >= _video.pages.count) return;
    
    [self.videoPlayerController.player log:@"正在解析视频地址..."];
    
    
    __weak typeof(self) weakSelf = self;
    
    /* Method 1 */
    
//    NSInteger cid = _video.pages[_page].cid;
//    NSInteger vid = _eid ? _eid : _video.aid;
//    BilibiliVideoType type = _eid ? BilibiliVideoTypeBangumi : BilibiliVideoTypeNormal;
//    
//    [BilibiliAPI getPlayURLWithCid:cid vid:vid videoType:type quality:VideoQuarityNormal success:^(PlayURLModel * object, BilibiliResponse * response) {
//        weakSelf.playURL = object;
//        [weakSelf setupPlayerURL:weakSelf.playURL.URL];
//    } failure:^(BilibiliResponse * response, NSError * error) {
//#ifdef DEBUG
//        NSLog(@"%@", response);
//        NSLog(@"%@", error);
//#endif
//    }];
    
    
    /* Alternative Method */
    
    [BilibiliAPI getVideoURLWithAID:_aid page:1 success:^(NSString * url) {
        [weakSelf.videoPlayerController.player log:@"视频地址解析完毕..."];
        [weakSelf setupPlayer:url];
    } failure:^{
        [weakSelf.videoPlayerController.player log:@"视频地址解析失败..."];
    }];
}

-(void)loadDanmaku
{
    if(_page >= _video.pages.count) return;
    
    [self.videoPlayerController.player log:@"正在加载弹幕..."];
    
    __weak typeof(self) weakSelf = self;
    [BilibiliAPI getDanmakuWithCid:_video.pages[_page].cid success:^(NSString * _Nullable xml) {
        
        //Load danmakus.
        Danmakus * danmakus = [BilibiliDanmakuParser parse:xml];
        [weakSelf.danmakuView loadDanmakus:danmakus];
        
        [self.videoPlayerController.player log:@"弹幕加载成功..."];
    } failure:^{
        [weakSelf loadDanmaku];
        [self.videoPlayerController.player log:@"弹幕加载失败..."];
    }];
}

-(void)addHistory
{
//    __weak typeof(self) weakSelf = self;
    
    //if has log in
    
//    [BilibiliAPI addHistory]
}

-(void)refreshUI
{
    _titleLabel.text = [NSString stringWithFormat:@"AV%@", @(_video.aid)];
    
    //Download image with SDWebImage then add blur filter by GPUImage.
    __weak typeof(self) weakSelf = self;
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:_video.pic] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        GPUImageGaussianBlurFilter * blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
        blurFilter.blurRadiusInPixels = 5.0;
        weakSelf.backgroundImageView.image = [blurFilter imageByFilteringImage: image];
    }];
}

-(void)setupPlayer:(NSString *)url
{
    _url = url;
    
    __weak typeof(self) weakSelf = self;
    
    if (url && [url isNotBlank] && self.player != nil)
    {
        self.player.url = url;
        
        //设置隐藏标题栏以及状态栏的回调
        self.player.onClick = ^(VideoPlayer * player){
            [weakSelf hideWidgets:player.hideWidgets];
        };
        
        //显示弹幕
        self.videoPlayerController.danmakuView = self.danmakuView;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onPlay:) name:VideoPlayerPlayNotification object:nil];
    }
}

-(void)hideUselessViews
{
    _playButton.hidden = YES;
    _playerButton.hidden = YES;
    _backgroundImageView.hidden = YES;
}

-(void)hideWidgets:(BOOL)boolean
{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.titleBar.alpha = boolean ? 0 : 1;
    } completion:nil];
    self.hideStatusBar = boolean;
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark IBAction

- (IBAction)onClickMoreButton:(id)sender
{
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"cancle", 取消) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"video_actionSheet_report", 举报), nil];
    [[actionSheet rac_buttonClickedSignal]subscribeNext:^(NSNumber * index) {
        if (index.integerValue == 0)
        {
            NSLog(@"举报");
        }
    }];
    
    [actionSheet showInView:self.view];
}

//返回按钮
- (IBAction)onClickBackButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onClickVideo:(id)sender
{
    if (_player)
    {
        [_player showInView:_playerView];
        
        _moreButton.hidden = NO;
        [self hideUselessViews];
        
        if([_player isPreparedToPlay])
            [_player play];
    }
}

#pragma mark Callback

-(void)onPlay:(NSNotification *)notification
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self.danmakuView start];
    });
}

@end
