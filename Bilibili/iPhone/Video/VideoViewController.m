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

#import "BilibiliAPI.h"

#import "SegmentedControl.h"

@import YYKit;
@import GPUImage;
@import SDWebImage;

@interface VideoViewController ()

@property (nonatomic, assign) NSInteger aid;
@property (nonatomic, strong) VideoModel * video;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *visualEffectView;
@property (weak, nonatomic) IBOutlet UIImageView *portraitImageView;
@property (weak, nonatomic) IBOutlet UITextField *danmakuTextField;
@property (weak, nonatomic) IBOutlet UIView *tabsView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) VideoBriefController * videoBriefController;
@property (nonatomic, strong) CommentViewController * commentViewController;

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

#pragma mark Override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.navigationController)
        self.navigationController.delegate = self;
    
    [_danmakuTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    _videoBriefController = [VideoBriefController new];
    _videoBriefController.tableView.frame = _scrollView.bounds;
    [_scrollView addSubview:_videoBriefController.tableView];
    
    [self loadVideoData];
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
    [BilibiliAPI getVideoInfoWithAID:6311662 success:^(VideoModel * object, BilibiliResponse * response) {
        _video = object;
        _videoBriefController.video = _video;
    } failure:^(BilibiliResponse * response, NSError * error) {
#ifdef DEBUG
        NSLog(@"%@", response);
        NSLog(@"%@", error);
#endif
    }];
}

-(void)refreshUI
{
    _titleLabel.text = _video.title;
    
    //Download image with SDWebImage then add blur filter by GPUImage.
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:_video.pic] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//        UIImage * image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"2" ofType:@"jpg"]];
        GPUImageGaussianBlurFilter * blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
        blurFilter.blurRadiusInPixels = 5.0;
        _backgroundImageView.image = [blurFilter imageByFilteringImage: image];
    }];
}

#pragma mark IBAction

- (IBAction)onClickMoreButton:(id)sender
{
    
}

//返回按钮
- (IBAction)onClickBackButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
