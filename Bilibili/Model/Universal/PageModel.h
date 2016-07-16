//
//  PageModel.h
//  Bilibili
//
//  Created by LunarEclipse on 16/7/2.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

/**
 *  困扰程序员最大的问题果然还是命名啊，两个类是完全不相关的类
 *  PageModel是VideoModel中分P的数据
 *  PagingModel是单个请求中一页返回数据数和总页数信息等的类
 */

#import <Foundation/Foundation.h>

/*视频分P*/
@interface PageModel : NSObject

@property (nonatomic, copy) NSString * cid;     //剧集ID
@property (nonatomic, copy) NSString * vid;     //来自B站则为vupload_ + cid
@property (nonatomic, copy) NSString * part;    //名字
@property (nonatomic, copy) NSString * from;    //历史原因，视频可能来自sina, youku等，来自B站则为vupload
@property (nonatomic, copy) NSString * link;
@property (nonatomic, copy) NSString * weblink;

@property (nonatomic, assign) NSInteger page;    //第几集

@property (nonatomic, assign) BOOL has_alias;

@end


/*HTTP请求数据分页*/
@interface PagingModel : NSObject

@property (nonatomic, assign) NSInteger results;    //返回的结果数
@property (nonatomic, assign) NSInteger page;       //当前页数
@property (nonatomic, assign) NSInteger pages;      //总页数
@property (nonatomic, assign) NSInteger owner;

@property (nonatomic, assign) BOOL isAdmin;
@property (nonatomic, assign) BOOL needCode;

@end