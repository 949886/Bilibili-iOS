//
//  BaseViewController.m
//  Bilibili
//
//  Created by LunarEclipse on 16/9/6.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "BaseViewController.h"

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
    if (_tableView == nil) {
        UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView = tableView;
        _tableView.frame = self.view.bounds;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:tableView];
    }
    _tableView.contentSize = CGSizeMake(_tableView.contentSize.width, 1000);
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView.backgroundColor = [UIColor clearColor];
    _tableView.estimatedRowHeight = 600;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.dataSource = self;
    _tableView.delegate = self;

    //小电视发射电波（哔~哔~）
    DenpakuView * denpakuView = [[DenpakuView alloc] initWithFrame:_tableView.bounds];
    denpakuView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    denpakuView.top -= 50;
    denpakuView.layer.cornerRadius = 5;
    denpakuView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.000];
    self.denpakuView = denpakuView;
    [_tableView addSubview:denpakuView];
    [_tableView sendSubviewToBack:denpakuView];
    [_tableView rac_observeKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew observer:nil block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
        denpakuView.height = _tableView.contentSize.height + kScreenHeight;
    }];
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_tableView sendSubviewToBack:_denpakuView];
}

-(UINavigationController *)navigationController
{
    return self.view.superview.viewController.navigationController;
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
