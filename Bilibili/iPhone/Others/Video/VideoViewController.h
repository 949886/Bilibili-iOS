//
//  VideoViewController.h
//  Bilibili
//
//  Created by LunarEclipse on 16/9/13.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoViewController : UIViewController <UINavigationControllerDelegate>

-(instancetype)initWithAID:(NSInteger)aid;
-(instancetype)initWithAID:(NSInteger)aid episodeID:(NSInteger)eid;

@end
