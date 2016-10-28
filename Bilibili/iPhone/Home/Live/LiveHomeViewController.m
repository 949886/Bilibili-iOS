//
//  LiveHomeViewController.m
//  Bilibili
//
//  Created by LunarEclipse on 16/8/26.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "LiveHomeViewController.h"
#import "WebViewControll.h"

#import "LiveHomeHeader.h"
#import "SegmentCell.h"

#import "LiveHomeModel.h"
#import "BilibiliAPI.h"

@import YYKit;
@import MJRefresh;
@import SDWebImage;

@interface LiveHomeViewController ()

//@property (nonatomic, weak) IBOutlet UITableView * tableView;
@property (nonatomic, weak) ImageSlider * imageSlider;

@property (nonatomic, strong) LiveHomeModel * data;
@property (nonatomic, strong) NSMutableArray * segmentsData;

@end

@implementation LiveHomeViewController

#pragma mark Override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    
    _segmentsData = [NSMutableArray new];
    
    [self.tableView registerNib: [UINib nibWithNibName:@"SegmentCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    
    //初始化Header
    LiveHomeHeader * header = [[[NSBundle mainBundle] loadNibNamed:@"LiveHomeHeader" owner:nil options:nil] firstObject];
    header.autoresizingMask = UIViewAutoresizingNone;   //不设置会出现UIView-Encapsulated-Layout-Height Constants冲突
    self.tableView.tableHeaderView = header;
    
    //初始化图片轮播器
    ImageSlider * imageSlider = header.imageSlider;
    imageSlider.imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, imageSlider.height);
    //imageSlider.images = @[@"2.jpg", @"3.jpg"];
    self.imageSlider = imageSlider;
    
    @weakify(self);
    [self.imageSlider handleClickEvent:^(NSInteger index) {
        @strongify(self);
        
        //对不同类型的banner进行不同的操作(bangumi:番剧 weblink:网页 apk:游戏广告)
        if(self.data.banners.count <= index) return;
        BannerModel * banner = self.data.banners[index];
        
        //weblink
        if ([banner.url isNotBlank])
        {
            WebViewControll * controller = [[WebViewControll alloc] initWithURL:banner.url];
            UINavigationController * navigationController = self.view.superview.viewController.navigationController;
            [navigationController pushViewController:controller animated:YES];
        }
        
        //TODO: 跳转到Video和bangumi
    }];
    
    //通过API加载数据
    [self loadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Delegate

/* TableView DataSource */

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _segmentsData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SegmentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    LiveHomePartition * segment = _segmentsData[indexPath.row];
    
    //设置数据
    cell.titleLabel.text = segment.info.name;
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:segment.info.sub_icon.src]];
    [cell setupLive:_segmentsData[indexPath.row]];
    
    //匹配数字并设置高亮颜色
    NSString * moreInfoString = [NSString stringWithFormat:NSLocalizedString(@"home_live_moreInfo", nil), segment.info.count];
    
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:@"\\d+" options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray<NSTextCheckingResult *> * results = [regex matchesInString:moreInfoString options:NSMatchingReportCompletion range:NSMakeRange(0, moreInfoString.length)];
    
    NSMutableAttributedString * aString = [[NSMutableAttributedString alloc] initWithString:moreInfoString];
    for (NSTextCheckingResult * result in results)
        [aString setAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]} range:result.range];

    cell.moreInfoLabel.attributedText = aString;
    
    return cell;
}

/* ScrollViewDelegate */

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.tableView.contentOffset.y < 0 && self.tableView.contentOffset.y >= -50)
        [self.tableView setContentOffset:CGPointZero animated:YES];
}

#pragma mark Encapsulation

- (void)loadData
{
    @weakify(self);
    [BilibiliAPI getLiveHomeWithSuccess:^(LiveHomeModel * object, BilibiliResponse * response) {
        @strongify(self)
        if (!self) return;
        
        self.data = object;
        self.segmentsData = object.partitions.mutableCopy;
        [self.segmentsData insertObject:object.recommendData atIndex:0];
        
        //设置图片轮播器图片
        NSMutableArray * imageURLs = [NSMutableArray array];
        for (BannerModel * banner in self.data.banners)
            [imageURLs addObject:banner.imageurl];
        self.imageSlider.urls = imageURLs;
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(BilibiliResponse * response, NSError * error) {
        [self.tableView.mj_header endRefreshing];
#ifdef DEBUG
        NSLog(@"%@", response);
        NSLog(@"%@", error);
#endif
    }];
}

#pragma mark Callback


@end
