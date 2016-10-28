//
//  CommentViewController.m
//  Bilibili
//
//  Created by LunarEclipse on 16/9/18.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentCell.h"

#import "BilibiliAPI.h"

@import YYKit;
@import MJRefresh;

@interface CommentViewController ()

@property (nonatomic, strong) CommentsModel * comments;

@end

@implementation CommentViewController

#pragma mark Initialization

-(instancetype)initWithAID:(NSInteger)aid
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        _aid = aid;
        _page = 1;
    }
    return self;
}

#pragma mark Override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    
    //Tableview.
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.000];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, -44, 0);
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf loadComments];
    }];
    
    MJRefreshAutoFooter * footer = (MJRefreshAutoFooter *)self.tableView.mj_footer;
    footer.triggerAutomaticallyRefreshPercent = -2.5;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    
    [self loadComments];
}

#pragma mark Delegate

/* TableViewDataSource */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _comments.hots.count == 0 ? 1 : 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_comments.hots.count == 0)
        return _comments.replies.count;
    
    switch (section)
    {
        case 0: return _comments.hots.count;
        case 1: return _comments.replies.count;
        default: return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    CommentModel * comment;
    
    if (_comments.hots.count == 0)  //无热评
        comment = _comments.replies[indexPath.row];
    else
    {
        if(indexPath.section == 0)
            comment = _comments.hots[indexPath.row];
        else comment = _comments.replies[indexPath.row];
    }
    
    [cell setup:comment];
    return cell;
}

/* TableViewDelegate */

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) return nil;
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 30)];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.size = CGSizeMake(120, 30);
    button.centerX = view.centerX;
    button.backgroundColor = self.tableView.backgroundColor;
    [button setTitle:NSLocalizedString(@"comment_more_hot_comments", 更多热门评论) forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:1.000 green:0.441 blue:0.671 alpha:1.000] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [button setTarget:self action:@selector(onClickMoreHotCommentsButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * separator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 0.5)];
    separator.backgroundColor = [UIColor lightGrayColor];
    separator.centerY = view.centerY;
    
    [view addSubview:separator];
    [view addSubview:button];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 1: return 30;
        default: return 0.1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

#pragma mark Encapsulation

-(void)loadComments
{
    if(_aid == 0) return;
    
    @weakify(self);
    [BilibiliAPI getCommentsWithAid:_aid page:_page pageSize:20 success:^(CommentsModel * object, BilibiliResponse * response) {
        @strongify(self);
        if(self.comments == nil || self.page == 0)
            self.comments = object;
        else [self.comments.replies addObjectsFromArray:object.replies];
        self.page++;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        if (object.replies.count)
            [self.tableView.mj_footer endRefreshing];
        else [self.tableView.mj_footer endRefreshingWithNoMoreData];
    } failure:^(BilibiliResponse * response, NSError * error) {
        @strongify(self);
        [self.tableView.mj_footer endRefreshing];
#ifdef DEBUG
        NSLog(@"%@", response);
        NSLog(@"%@", error);
#endif
    }];
}

#pragma mark Callback

-(void)onClickMoreHotCommentsButton:(UIButton *)sender
{
    
}

#pragma mark Getter & Setter

-(void)setAid:(NSInteger)aid
{
    _aid = aid;
    [self loadComments];
}

@end
