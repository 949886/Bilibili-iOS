//
//  CommentViewController.h
//  Bilibili
//
//  Created by LunarEclipse on 16/9/18.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentViewController : UITableViewController

@property (nonatomic, assign) NSInteger aid;
@property (nonatomic, assign) NSInteger page;

-(instancetype)initWithAID:(NSInteger)aid;

@end
