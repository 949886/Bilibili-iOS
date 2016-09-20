//
//  ConcernedViewController.m
//  Bilibili
//
//  Created by LunarEclipse on 16/9/7.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "ConcernedViewController.h"

@interface ConcernedViewController ()

@end

@implementation ConcernedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

#pragma mark Delegate

/* DataSource */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    return cell;
}

@end
