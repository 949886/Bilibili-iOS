//
//  BilibiliTests.m
//  BilibiliTests
//
//  Created by LunarEclipse on 16/7/2.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <XCTest/XCTest.h>



#define CACHE_PATH NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject
#define FILE_PATH(__FILE_NAME__) [CACHE_PATH stringByAppendingString:@"/Download/"#__FILE_NAME__]


@interface BilibiliTests : XCTestCase

@end

@implementation BilibiliTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    dict[@"aaaf"] = @"fas";
    [dict writeToFile:@"/Users/LunarEclipse/Desktop/aaa.plist" atomically:YES];
    
//    NSString * path  = [CACHE_PATH stringByAppendingPathComponent:@"Download"];
//    path  = [path stringByAppendingPathComponent:@"xxx.txt"];
//    NSLog(@"%@", path);
//    [[NSFileManager defaultManager] createDirectoryAtPath:FILE_PATH() withIntermediateDirectories:NO attributes:nil error:nil];
//    
//    NSOutputStream * ostream = [NSOutputStream outputStreamToFileAtPath:path append:YES];
//    [ostream open];
//    NSData * data = [@"data" dataUsingEncoding:NSUTF8StringEncoding];
//    [ostream write:data.bytes maxLength:data.length];
//    [ostream close];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


@end
