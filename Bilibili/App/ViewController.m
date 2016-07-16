//
//  ViewController.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/4.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "ViewController.h"
#import "VideoPlayer.h"

#define BILIBILI_URL  @"http://cn-hncs-dx-v-01.acgvideo.com/vg4/3/83/8412227-1-hd.mp4?expires=1467636300&ssig=DRjtnbW-Rukar3ofkQuanw&oi=1778673096&internal=1&or=993353635&rate=0"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSURL * url = [[NSBundle mainBundle]URLForResource:@"01-知识回顾.mp4" withExtension:nil];
//    NSURL * url = [NSURL URLWithString:BILIBILI_URL];
//    VideoPlayer * videoPlayer = [VideoPlayer videoPlayerWithURL:url];
//    [videoPlayer showInView:self.view withRect:CGRectMake(0, 0, 300, 300)];
//    [videoPlayer play];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;;
}

@end
