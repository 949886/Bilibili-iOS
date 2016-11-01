//
//  RecHomeViewController.m
//  Bilibili
//
//  Created by LunarEclipse on 16/8/26.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "RecHomeViewController.h"
#import "WebViewControll.h"

#import "ImageSlider.h"
#import "DenpakuView.h"
#import "SegmentCell.h"

#import "BilibiliAPI.h"

@import YYKit;
@import MJRefresh;
@import SDWebImage;

@interface RecHomeViewController ()

@property (nonatomic, weak) ImageSlider * imageSlider;

@property (nonatomic, strong) NSArray<RecommendSegment *> * data;
@property (nonatomic, copy) NSMutableArray * segmentsData;

@end

@implementation RecHomeViewController

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
    
    //初始化图片轮播器
    ImageSlider * imageSlider = [[ImageSlider alloc]initWithFrame:CGRectMake(0, 0, self.tableView.width, 120)];
    imageSlider.imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, imageSlider.height);
    //imageSlider.images = @[@"2.jpg", @"3.jpg"];
    self.imageSlider = imageSlider;
    self.tableView.tableHeaderView = imageSlider;
    
//    @weakify(self);
//    [self.imageSlider handleClickEvent:^(NSInteger index) {
//        @strongify(self);
//        
//        //对不同类型的banner进行不同的操作(bangumi:番剧 weblink:网页 apk:游戏广告)
//        if(_data.banners.count <= index) return;
//        BannerModel * banner = _data.banners[index];
//        
//        //weblink
//        if ([banner.url isNotBlank])
//        {
//            WebViewControll * controller = [[WebViewControll alloc] initWithURL:banner.url];
//            UINavigationController * navigationController = self.view.superview.viewController.navigationController;
//            [navigationController pushViewController:controller animated:YES];
//        }
//        
//        //TODO: 跳转到Video和bangumi
//    }];

    
    //加载数据
    [self loadData];
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
    
    RecommendSegment * segment = _segmentsData[indexPath.row];
    
    //设置数据
    cell.titleLabel.text = segment.title;
    NSString * str = (segment.title.length >= 2) ? [segment.title substringWithRange:NSMakeRange(0, 2)] : @"";
    cell.moreInfoLabel.text = [NSString stringWithFormat:NSLocalizedString(@"home_recommend_moreInfo", nil), str];
//    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:segment.info.sub_icon.src]];
    [cell setupRecommend:_segmentsData[indexPath.row]];
    
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
    [BilibiliAPI getRecommendHomeWithDevice:0 success:^(NSArray<RecommendSegment *> * object, BilibiliResponse * response) {
        @strongify(self)
        if (!self) return;
        
        self.data = object;
        self.segmentsData = object.mutableCopy;

        //设置图片轮播器图片
        NSMutableArray * imageURLs = [NSMutableArray array];
        for (BannerModel * banner in self.data.firstObject.banners)
            [imageURLs addObject:banner.imageurl];
        self.imageSlider.urls = imageURLs;

        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(BilibiliResponse * response, NSError *  error) {
        [self.tableView.mj_header endRefreshing];
#ifdef DEBUG
        NSLog(@"%@", response);
        NSLog(@"%@", error);
#endif
    }];
}

@end
