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

#define LOG_ERROR \
NSLog(@"%@", response);\
NSLog(@"%@", error);

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

- (void)testVideoAPI
{
//    [BilibiliVideoAPI getVideoInfoWithAID:6517788 success:^(VideoModel * _Nonnull object, BilibiliResponse * _Nonnull response) {
//        
//    } failure:nil];
    
//    [BilibiliVideoAPI getPlayURLWithCid:10602259 quality:VideoQuarityLow success:^(PlayURLModel *  object, BilibiliResponse *  response) {
//        
//    } failure:^(BilibiliResponse * response, NSError * error) {
//        LOG_ERROR
//    }];
    
//    [BilibiliAPI getVideoURLWithAID:@"6517788" success:^(NSString * url) {
//        NSLog(@"%@", url);
//    } failure:nil];
//    
    [[NSRunLoop mainRunLoop] run];
}

- (void)testCommentAPI
{
    [BilibiliVideoAPI getCommentsWithAid:6528600 page:1 pageSize:20 success:^(CommentsModel * object, BilibiliResponse * response) {
        
    } failure:^(BilibiliResponse * response, NSError * error) {
        LOG_ERROR
    }];
    
    [[NSRunLoop mainRunLoop] run];
}

- (void)testAddFavoriateAPI
{
    [BilibiliUserAPI loginWithUsername:@"Your Account" password:@"Your password" success:^(LoginResponse * object, BilibiliResponse * response) {
        [BilibiliVideoAPI addFavoriteVideo:5216011 success:^(BilibiliResponse * response) {
            
        } failure:^(BilibiliResponse * response, NSError * error) {
            LOG_ERROR
        }];
    } failure:^(BilibiliResponse * response, NSError * error) {
        LOG_ERROR
    }];
    
    [[NSRunLoop mainRunLoop] run];
}


- (void)testDanmakuAPI
{
    [BilibiliVideoAPI getDanmakuWithCid:10602259 success:^(NSString * xml) {
        NSLog(@"%@", xml);
    } failure:^{
        
    }];
    
    [[NSRunLoop mainRunLoop] run];
}

- (void)testDownloader
{
//    [BilibiliVideoAPI getVideoURLWithAID:6517788 page:1 quality:VideoQuarityLow success:^(NSString * url) {
//        [[Downloader downloader] download:url tag:@"Low" progress:nil success:nil failure:nil];
//    } failure:^{
//        
//    }];
    
    [[NSRunLoop mainRunLoop] run];
}

- (void)testUserAPI
{
    [BilibiliUserAPI getUserWithID:282994 success:^(UserModel * user, BilibiliResponse * response) {
        
    } failure:^(BilibiliResponse * response, NSError * error) {
        LOG_ERROR
    }];
    
    [[NSRunLoop mainRunLoop] run];
}

- (void)testAppAPI
{
    [BilibiliAppAPI getBangumiRecommendWithCursor:1472724000279 pageSize:10 success:^(NSArray * object, BilibiliResponse * response) {
        
    } failure:^(BilibiliResponse * response, NSError * error) {
        LOG_ERROR
    }];
    
    [[NSRunLoop mainRunLoop] run];
}

-(void)testLiveAPI
{
    //    [BilibiliAppAPI getLiveHomeWithSuccess:^(LiveHomeModel * object, BilibiliResponse * response) {
    //
    //    } failure:nil];
    //
    //    [BilibiliAppAPI getRecommendHomeWithDevice:0 success:^(NSArray * object, BilibiliResponse * response) {
    //
    //    } failure:nil];
    
//    [BilibiliAppAPI getLiveRoomIndexWithRoomID:34756 success:^(LiveRoomModel * object, BilibiliResponse * response) {
//        
//    } failure:^(BilibiliResponse * response, NSError * error) {
//        LOG_ERROR
//    }];
    
    [BilibiliAppAPI getLiveRoomMessagesWithRoomID:43088 success:^(LiveMessagesModel * object, BilibiliResponse * response) {
        
    } failure:^(BilibiliResponse * response, NSError * error) {
        LOG_ERROR
    }];
    
    [[NSRunLoop mainRunLoop] run];
}

-(void)testBangumiAPI
{
//    [BilibiliAppAPI getBangumiInfoWithSid:842 success:^(BangumiModel * object, BilibiliResponse * response) {
//        
//    } failure:^(BilibiliResponse * response, NSError * error) {
//       LOG_ERROR
//    }];

    [BilibiliAppAPI getRelativeBangumisWithSid:5532 success:^(RelativeBangumisModel * object, BilibiliResponse * response) {
        
    } failure:^(BilibiliResponse * response, NSError * error) {
        LOG_ERROR
    }];
    
    [[NSRunLoop mainRunLoop] run];
}

@end
