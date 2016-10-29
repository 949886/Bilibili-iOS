//
//  BangumiHomeViewController.m
//  Bilibili
//
//  Created by LunarEclipse on 16/9/3.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "BangumiHomeViewController.h"
#import "WebViewControll.h"

#import "SegmentCell.h"
#import "BangumiRecommendCell.h"
#import "BangumiHomeHeader.h"

#import "BilibiliAPI.h"

#define CELL_ID @"Cell"
#define REC_CELL_ID @"rec"

@import YYKit;
@import MJRefresh;
@import SDWebImage;

@interface BangumiHomeViewController ()

@property (nonatomic, weak) ImageSlider * imageSlider;

@property (nonatomic, strong) BangumiHomeModel * data;
@property (nonatomic, copy) NSArray<BangumiSegment *> * segmentsData;

@property (nonatomic, copy) NSMutableArray<BangumiRecommendModel *> * recommendData;

@property (nonatomic, assign) BOOL dataLoaded;

@end


@interface BangumiHomeViewController ()

@end

@implementation BangumiHomeViewController


#pragma mark Override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    
    _segmentsData = [NSArray new];
    _recommendData = [NSMutableArray new];
    
    [self.tableView registerNib: [UINib nibWithNibName:@"SegmentCell" bundle:nil] forCellReuseIdentifier:CELL_ID];
    [self.tableView registerNib:[UINib nibWithNibName:@"BangumiRecommendCell" bundle:nil] forCellReuseIdentifier:REC_CELL_ID];
    
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadLatestRecommendData];
    }];
    footer.refreshingTitleHidden = YES;
    self.tableView.mj_footer = footer;
    
    //初始化Header
    BangumiHomeHeader * header = [[[NSBundle mainBundle] loadNibNamed:@"BangumiHomeHeader" owner:nil options:nil] firstObject];
    header.autoresizingMask = UIViewAutoresizingNone;   //不设置会出现UIView-Encapsulated-Layout-Height Constants冲突
    self.tableView.tableHeaderView = header;
    
    //初始化图片轮播器
    ImageSlider * imageSlider = header.imageSlider;
    imageSlider.imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, imageSlider.height);
//    imageSlider.images = @[@"2.jpg", @"3.jpg"];
    self.imageSlider = imageSlider;
    
    @weakify(self);
    [self.imageSlider handleClickEvent:^(NSInteger index) {
        @strongify(self);
        
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
    
    
    //加载数据
    [self loadData];
    [self loadLatestRecommendData];
}


#pragma mark Delegate

/* TableView DataSource */

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0: return _segmentsData.count - 1;
        case 1: return _recommendData.count;
        default: return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //新番连载 & 旧番推荐
    if (indexPath.section == 0)
    {
        BangumiSegment * segment = _segmentsData[indexPath.row];
        SegmentCell * cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
        cell.titleLabel.text = [NSString stringWithFormat:segment.title, 4];
        cell.moreInfoLabel.text = _segmentsData[indexPath.row].moreInfo;
        cell.refreshButton.hidden = YES;
        [cell setupBangumi:_segmentsData[indexPath.row]];
        return cell;
    }
    else //(indexPath.section == 1)番剧推荐
    {
        BangumiRecommendModel * recommend = _recommendData[indexPath.row];
        BangumiRecommendCell * cell = [tableView dequeueReusableCellWithIdentifier:REC_CELL_ID];
        [cell setup:recommend];
        return cell;
    }
}

/* TableView Delegate */

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

/* ScrollView Delegate */

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.tableView.contentOffset.y < 0 && self.tableView.contentOffset.y >= -50)
        [self.tableView setContentOffset:CGPointZero animated:YES];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0) return nil;
    
    UIView * view = [UIView new];
    
    UIImageView * iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hd_home_recommend"]];
    iconView.frame = CGRectMake(8, 8, 24, 24);
    [view addSubview:iconView];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 15)];
    titleLabel.left = iconView.right + 8;
    titleLabel.centerY = iconView.centerY;
    titleLabel.text = NSLocalizedString(@"home_bangumi_recommend_title", 番剧推荐);
    titleLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:titleLabel];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 1) return 40;
    return 0;
}

#pragma mark Encapsulation

- (void)loadData
{
    @weakify(self);
    [BilibiliAPI getBangumiHomeWithDevice:0 success:^(BangumiHomeModel * object, BilibiliResponse * response) {
        @strongify(self)
        if (!self) return;
        
        _data = object;
        _segmentsData = [BangumiSegment v4BangumiSegments:object];
        _dataLoaded = YES;
        
        //设置图片轮播器图片
        NSMutableArray * imageURLs = [NSMutableArray array];
        for (BannerModel * banner in _data.banners)
            [imageURLs addObject:banner.imageurl];
        _imageSlider.urls = imageURLs;
        
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

-(void)loadLatestRecommendData
{
    u_int64_t timestamp;
    if(_recommendData.count == 0)
        timestamp = [NSDate date].timeIntervalSince1970 * 1000;
    else timestamp = _recommendData.lastObject.cursor;
    
    @weakify(self);
    [BilibiliAPI getBangumiRecommendWithCursor:timestamp pageSize:10 success:^(NSArray * object, BilibiliResponse * response) {
        @strongify(self)
        if (!self) return;
        
        [_recommendData addObjectsFromArray:object];
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(BilibiliResponse * response, NSError * error) {
#ifdef DEBUG
        NSLog(@"%@", response);
        NSLog(@"%@", error);
#endif
    }];
}

@end
