//
//  BilibiliAPITests.m
//  Bilibili
//
//  Created by LunarEclipse on 16/8/20.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

#import "BilibiliAPI.h"
#import "BilibiliVideoAPI.h"
#import "BilibiliUserAPI.h"
#import "BilibiliAppAPI.h"

#import "BilibiliRequest.h"
#import "Downloader.h"
#import "models.h"

@interface BilibiliAPITests : XCTestCase

@end

@implementation BilibiliAPITests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
}

- (void)testBilibiliAPI
{
    //    [BilibiliAPI getBangumiHomepageDataWithDevice:0 success:nil failure:nil];
    //    [BilibiliDanmakuParser parse];
}

- (void)testBilibiliVideoAPI
{
    [BilibiliAPI getVideoURLWithAID:@"5976369" success:^(NSString * url) {
        NSLog(@"%@", url);
    } failure:nil];
    
    [[NSRunLoop mainRunLoop] run];
}

- (void)testDownloader
{
    [BilibiliVideoAPI getVideoURLWithAID:5976369 page:1 quality:VideoQuarityLow success:^(NSString * url) {
        [[Downloader downloader] download:url tag:@"Low" progress:nil success:nil failure:nil];
    } failure:^{
        
    }];
    
    [[NSRunLoop mainRunLoop] run];
}

- (void)testUserAPI
{
    [BilibiliUserAPI getUserWithID:@"10000" success:^(UserModel * user, BilibiliResponse * response) {
        
    } failure:nil];
    
    [[NSRunLoop mainRunLoop] run];
}

- (void)testAppAPI
{
//    [BilibiliAppAPI getLiveHomeWithSuccess:^(LiveHomeModel * object, BilibiliResponse * response) {
//        
//    } failure:nil];
    
    [BilibiliAppAPI getRecommendHomeWithDevice:0 success:^(NSArray * object, BilibiliResponse * response) {
        
    } failure:nil];
    
    [[NSRunLoop mainRunLoop] run];
}

@end
