//
//  RelativeBangumisModel.h
//  Bilibili
//
//  Created by LunarEclipse on 16/10/22.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BangumiModel.h"

@interface RelativeBangumisModel : NSObject

@property (nonatomic, assign) NSInteger season_id;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSArray<BangumiModel *> * list;

@end

/*
 "result":{
 "season_id": "5532",
 "title": "少女编号"
 "list": [{
 "bangumi_id": "1918",
 "cover": "http://i0.hdslb.com/bfs/bangumi/bc5be2ddaa1fedc3d6d05a4bcf013ff18af46f00.jpg",
 "follow": "4895",
 "isfinish": "1",
 "season_id": "2895",
 "title": "RWBY Volume2 1080P",
 "total_count": "12"
 } ...]
 }
 */
