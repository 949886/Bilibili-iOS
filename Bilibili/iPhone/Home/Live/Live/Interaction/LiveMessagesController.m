//
//  LiveMessagesController.m
//  Bilibili
//
//  Created by LunarEclipse on 16/10/17.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "LiveMessagesController.h"
#import "LiveMessagesCell.h"

#import "BilibiliAPI.h"

@import YYKit;

@interface LiveMessagesController ()

@property (nonatomic, assign) NSInteger roomID;

@property (nonatomic, strong) LiveMessagesModel * messages;
@property (nonatomic, copy) NSArray<LiveMessagesCellModel *> * viewModels;

@end

@implementation LiveMessagesController

- (instancetype)initWithRoomID:(NSInteger)roomID
{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        _roomID = roomID;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(8, 0, 8, 0);
    [self.tableView registerClass:[LiveMessagesCell class] forCellReuseIdentifier:@"Cell"];
    
    [self loadRoomMessages];
}

#pragma mark Delegate

/* UITableViewDataSource */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _messages.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LiveMessagesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    [cell setup:_viewModels[indexPath.row]];
    
    return cell;
}

/* UITableViewDelegate */

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _viewModels[indexPath.row].size.height + 8;
}

#pragma mark Encapsulation

-(void)loadRoomMessages
{
    @weakify(self);
    [BilibiliAPI getLiveRoomMessagesWithRoomID:_roomID success:^(LiveMessagesModel * object, BilibiliResponse * response) {
        @strongify(self)
        if (!self) return;
        
        self.messages = object;
        
        [self initializeViewModels];
        [self.tableView reloadData];
    } failure:^(BilibiliResponse * response, NSError * error) {
#ifdef DEBUG
        NSLog(@"%@", response);
        NSLog(@"%@", error);
#endif
    }];
}

-(void)initializeViewModels
{
    NSMutableArray * array = [NSMutableArray new];
    
    for (LiveMessageModel * message in _messages.messages)
    {
        LiveMessagesCellModel * viewModel = [[LiveMessagesCellModel alloc]initWithLiveMessage:message];
        [array addObject:viewModel];
    }
    
    _viewModels = array;
}

@end
