//
//  BaseViewController.m
//  Bilibili
//
//  Created by LunarEclipse on 16/9/6.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "BaseViewController.h"

#import "DenpakuView.h"

@import YYKit;
@import MJRefresh;
@import SDWebImage;
@import ReactiveCocoa;

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Initialize tableview.
    _tableView.contentSize = CGSizeMake(_tableView.contentSize.width, 1000);
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView.backgroundColor = [UIColor clearColor];
    _tableView.estimatedRowHeight = 600;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerNib: [UINib nibWithNibName:@"SegmentCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    __weak typeof(self) weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    
    //小电视发射电波（哔~哔~）
    DenpakuView * denpakuView = [[DenpakuView alloc] initWithFrame:_tableView.bounds];
    denpakuView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    denpakuView.top -= 50;
    denpakuView.layer.cornerRadius = 5;
    denpakuView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.000];
    [_tableView addSubview:denpakuView];
    [_tableView sendSubviewToBack:denpakuView];
    [_tableView rac_observeKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew observer:nil block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
        denpakuView.height = _tableView.contentSize.height + kScreenHeight;
    }];
}

-(UINavigationController *)navigationController
{
    return self.view.superview.viewController.navigationController;
}

- (void)loadData
{
    //Leave blank to override.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
