//
//  Danmakus.m
//  Danmaku
//
//  Created by LunarEclipse on 16/9/9.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "Danmakus.h"

@interface Danmakus ()

@property (nonatomic, copy) NSArray<Danmaku *> * sortedDMs;

@end

@implementation Danmakus

#pragma mark Initialization

- (instancetype)init
{
    if (self = [super init])
        [self initialize];
    return self;
}

-(void)initialize
{
    _danmakus = [NSMutableArray array];
}

#pragma mark Getter & Setter

-(void)setDanmakus:(NSArray<Danmaku *> *)danmakus
{
    _danmakus = danmakus.mutableCopy;
    _sortedDMs = nil;
}

-(NSArray<Danmaku *> *)sortedDanmakus
{
    return self.sortedDMs;
}

- (NSArray<Danmaku *> *)sortedDMs
{
	if (_sortedDMs != nil) return _sortedDMs;
    
    _sortedDMs = [_danmakus sortedArrayUsingComparator:^NSComparisonResult(Danmaku * danmaku1, Danmaku * danmaku2) {
        if(danmaku1.time < danmaku2.time)
            return NSOrderedAscending;
        else return NSOrderedDescending;
    }];
    
    return _sortedDMs;
}

#pragma mark Methods

-(void)addDanmaku:(Danmaku *)danmaku
{
    NSMutableArray * danmakus = (NSMutableArray *)_danmakus;
    
    if (danmaku != nil)
    {
        [danmakus addObject:danmaku];
        _sortedDMs = nil;
    }
}

-(Danmakus *)subWithStartTime:(double)startTime endTime:(double)endTime
{
    assert(startTime <= endTime); //startTime must less than endTime...
    
    NSArray * sortedArray = self.sortedDanmakus;
    
    int startIndex = [self binarySearch:startTime sortedArray:sortedArray];
    int endIndex = [self binarySearch:endTime sortedArray:sortedArray];
    
    Danmakus * danmakus = [Danmakus new];
    danmakus.danmakus = [sortedArray subarrayWithRange:NSMakeRange(startIndex, endIndex - startIndex)].mutableCopy;
    
    return danmakus;
}

#pragma mark Encapsulation

/**
 *  Binary search first danmaku after specific time.
 *
 *  @param time          Specific time.
 *  @param sortedArray SORTED array (if arraty not sorted, the result will be undefined).
 *
 *  @return The index of first danmaku in sorted array after specific time.
 *      If time < 0 will return 0, else if time > the time of last danmaku will return the index of last danmaku.
 */

-(int)binarySearch:(double)time sortedArray:(NSArray<Danmaku *> *)sortedArray
{
    int min = 0;
    int max = (int)sortedArray.count - 1;
    
    while (min <= max)
    {
        int mid = (min + max) / 2;
        
        if (time == sortedArray[mid].time)
            return mid;
        else if (time > sortedArray[mid].time)
            min = mid + 1;
        else max = mid - 1;
    }
    
    if(min >= sortedArray.count)
        return (int)sortedArray.count - 1;
    return min;
}

@end
