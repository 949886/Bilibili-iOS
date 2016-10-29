//
//  CommentViewController.h
//  Bilibili
//
//  Created by LunarEclipse on 16/9/18.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate>

@property (nonatomic, assign) NSInteger aid;
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) UITableView * tableView;

-(instancetype)initWithAID:(NSInteger)aid;

@end
