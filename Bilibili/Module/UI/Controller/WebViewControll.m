//
//  WebViewControll.m
//  Bilibili
//
//  Created by LunarEclipse on 16/7/16.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "WebViewControll.h"

@interface WebViewControll ()

@property (nonatomic, copy) NSString * url;

@end

@implementation WebViewControll

-(instancetype)initWithURL:(NSString *)url
{
    if (self = [super initWithNibName:nil bundle:nil])
    {
        self.hidesBottomBarWhenPushed = YES;
        
        _url = url;
        _webView = [UIWebView new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    _webView.frame = self.view.bounds;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    [self.view addSubview: _webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
