//
//  BaseViewController.h
//  Bilibili
//
//  Created by LunarEclipse on 16/9/6.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DenpakuView.h"

@interface BaseViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView * tableView;
@property (nonatomic, weak) DenpakuView * denpakuView;

@end
