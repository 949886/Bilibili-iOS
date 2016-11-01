//
//  IPadRecHomeViewController.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/10.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "IPadRecHomeViewController.h"
#import "IPadHomeCell.h"
#import "TabBarController.h"
#import "WebViewControll.h"

#import "BilibiliAPI.h"
#import "ImageSlider.h"
#import "models.h"

#import "YYKit.h"

#define LIVE_CELL @"LiveCell"
#define RECOMMEND_CELL @"RecommendCell"
#define BANGUMI_CELL @"BangumiCell"
#define REGION_CELL @"RegionCell"
#define TOPIC_CELL @"TopicCell"

@interface IPadRecHomeViewController ()

@property (nonatomic, weak) ImageSlider * imageSlider;

@property (nonatomic, strong) RecommendHomeModel * data;

@property (nonatomic, copy) NSDictionary * type2CellID;

@end

@implementation IPadRecHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //TableView
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);    //not hided by tab bar, it's necessary.
    
    _type2CellID = @{@"live" : LIVE_CELL,
                     @"recommend" : RECOMMEND_CELL,
                     @"bangumi" : BANGUMI_CELL,
                     @"region" : REGION_CELL,
                     @"topic" : TOPIC_CELL};
    
    [_type2CellID enumerateKeysAndObjectsUsingBlock:^(NSString * key, NSString * value, BOOL * stop) {
        [self.tableView registerNib:[UINib nibWithNibName:@"IPadHomeCell" bundle:nil] forCellReuseIdentifier:value];
    }];
    
    //初始化图片轮播器
    ImageSlider * imageSlider = [[ImageSlider alloc]initWithType:ImageSliderTypeNone];
    imageSlider.frame = CGRectMake(0, 0, self.tableView.width, 200);
//    imageSlider.images = @[@"1.jpg", @"2.jpg", @"3.jpg"];
    imageSlider.imageSize = CGSizeMake(720, 200);
    self.imageSlider = imageSlider;
    self.tableView.tableHeaderView = imageSlider;
    
    
    //加载数据(1:iPad)
    @weakify(self);
    [BilibiliAPI getRecommendationHomepageDataWithDevice:1 success:^(RecommendHomeModel * model)
    {
        @strongify(self);
        if (!self) return;
        
        self.data = model;

        //设置图片轮播器图片 & 点击事件
        NSMutableArray * imageURLs = [NSMutableArray array];
        for (BannerModel * banner in _data.banners)
            [imageURLs addObject:banner.imageurl];
        self.imageSlider.urls = imageURLs;
        
        [self.imageSlider handleClickEvent:^(NSInteger index) {
            //对不同类型的banner进行不同的操作(bangumi:番剧 weblink:网页 apk:游戏广告)
            BannerModel * banner = _data.banners[index];
            
            //weblink
            if ([banner.type isEqualToString:@"weblink"])
            {
                WebViewControll * controller = [[WebViewControll alloc] initWithURL:banner.url];
                UINavigationController * navigationController = self.view.superview.viewController.navigationController;
                [navigationController pushViewController:controller animated:YES];
            }
            
            //TODO: 跳转到Video和bangumi
            
        }];
        
        [self.tableView reloadData];
    } failure:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIViewController * controller = self.view.superview.viewController;
    controller.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Button" style:UIBarButtonItemStylePlain target:self action:@selector(callfunc)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Delegate

/* ScrollView Delegate */

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //imageSlider离开屏幕则不工作
    if (scrollView.contentOffset.y >= 200)
        [_imageSlider deactivate];
    else [_imageSlider activate];
}


/* Tableview Datasource */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(_data) return _data.segments.count;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    clock_t clock_start = clock();
    NSString * ID = self.type2CellID[_data.segments[indexPath.section].type];
    IPadHomeCell * cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.segmentTitle.text = _data.segments[indexPath.section].title;
    [cell setup:_data.segments[indexPath.section]];
    clock_t clock_end = clock();
    NSLog(@"Time: %f",(clock_end-clock_start)/(double)CLOCKS_PER_SEC);
    return cell;
}


/* Tableview Delegate */

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_data && [_data.segments[indexPath.section].type isEqualToString:@"topic"])
        return 200;
    if(_data && _data.segments[indexPath.section].elements.count >= 5 )
        return 500;
    if (_data && [_data.segments[indexPath.section].type isEqualToString:@"bangumi"])
        return 400;
    return 300;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

#pragma mark Callback

-(void)callfunc
{
    clock_t clock_start = clock();
    [self.tableView reloadData];
    clock_t clock_end = clock();
    NSLog(@"Time: %f",(clock_end-clock_start)/(double)CLOCKS_PER_SEC);
}


@end
