//
//  ProfileContentViewController.m
//  Bilibili
//
//  Created by LunarEclipse on 16/10/12.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "ProfileContentViewController.h"
#import "ProfileSegmentCell.h"

@import YYKit;

@interface ProfileContentViewController ()

@property (nonatomic, strong) NSArray * icons1;
@property (nonatomic, strong) NSArray * titles1;
@property (nonatomic, strong) NSArray * classes1;

@property (nonatomic, strong) NSArray * icons2;
@property (nonatomic, strong) NSArray * titles2;
@property (nonatomic, strong) NSArray * classes2;

@end

@implementation ProfileContentViewController

#pragma mark Override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _icons1 = @[@"mine_download", @"mine_history", @"mine_favourite", @"mine_follow",
               @"mine_pocketcenter", @"mine_gamecenter", @"mine_theme"];
    _titles1 = @[NSLocalizedString(@"profile_download", 离线缓存), NSLocalizedString(@"profile_history", 历史记录),
               NSLocalizedString(@"profile_favoriate", 我的收藏), NSLocalizedString(@"profile_follow", 我的关注),
               NSLocalizedString(@"profile_pocketcenter", 我的钱包), NSLocalizedString(@"profile_gamecenter", 游戏中心),
               NSLocalizedString(@"profile_theme", 主题选择)];
    _classes1 = @[];
    
    _icons2 = @[@"mine_answerMessage", @"mine_shakeMe", @"mine_gotPrise", @"mine_privateMessage",
               @"mine_systemNotification"];
    _titles2 = @[NSLocalizedString(@"profile_answerMessage", 回复我的), NSLocalizedString(@"profile_shakeMe", @我),
               NSLocalizedString(@"profile_gotPrise", 收到的赞), NSLocalizedString(@"profile_privateMessage", 私信),
               NSLocalizedString(@"profile_systemNotification", 系统通知)];
    _classes2 = @[];
    
    self.tableView.rowHeight = kScreenWidth / 2;
    self.tableView.contentInset = UIEdgeInsetsZero;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[ProfileSegmentCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"Header"];
    
    self.denpakuView.top = 0;
}

#pragma mark Delegate


/* UITableViewDatasource */

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileSegmentCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    switch (indexPath.section)
    {
        case 0: [cell setIcons:_icons1 titles:_titles1 classes:_classes1]; break;
        case 1: [cell setIcons:_icons2 titles:_titles2 classes:_classes2]; break;
        default: break;
    }
    
//    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0: return kScreenWidth / 2;
        case 1: return kScreenWidth / 2;
        default: return 0;
    }
}

/* UITableViewDelegate */

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView * view = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView * headerView = (UITableViewHeaderFooterView *)view;
    
    headerView.backgroundView = ({
        UIView * view = [[UIView alloc] initWithFrame:headerView.bounds];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    
    NSString * text = @"";
    switch (section)
    {
        case 0: text = NSLocalizedString(@"profile_user_center", 个人中心); break;
        case 1: text = NSLocalizedString(@"profile_user_message", 我的消息); break;
        default: break;
    }
    NSDictionary * attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:16 weight:UIFontWeightLight],
                                  NSForegroundColorAttributeName : [UIColor blackColor]};
    NSAttributedString * headerText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    headerView.textLabel.attributedText = headerText;
}

@end
