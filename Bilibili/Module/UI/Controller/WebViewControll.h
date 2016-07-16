//
//  WebViewControll.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/16.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewControll : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView * webView;

-(instancetype)initWithURL:(NSString *)url;

@end
