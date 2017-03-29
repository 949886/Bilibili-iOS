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
        _webView.delegate = self;
    }
    return self;
}

+ (WebViewControll *)controllerWithURL:(NSString *)url
{
    return [[self alloc] initWithURL:url];
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

#pragma mark Delegate

/* UIWebViewDelegate */

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return true;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title;"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}


@end
