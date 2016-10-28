//
//  BilibiliVideoAPI.m
//  Bilibili
//
//  Created by LunarEclipse on 16/8/23.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "BilibiliVideoAPI.h"

#import "BilibiliURL.h"
#import "BilibiliAuth.h"

#import "YYKit.h"
#import "AFNetworking.h"

@implementation BilibiliVideoAPI

#pragma mark GET

//[API]http://app.bilibili.com/x/v2/view?aid=6024746&appkey=c1b107428d337928&build=3600&device=phone&mobi_app=iphone&platform=ios&ts=1472409128&sign=fe95c6be47d5ccddfd8d0cfcdbd05779
+(void)getVideoInfoWithAID:(NSInteger)aid
                   success:(SuccessBlock(VideoModel))success
                   failure:(FailureBlock)failure;
{
    NSMutableDictionary * parameters = @{@"aid" : @(aid),
                                         @"appkey" : APP_KEY,
                                         @"build" : @(3600),
                                         @"device" : @"phone",
                                         @"mobi_app" : @"iphone",
                                         @"platform" : PLATFORM}.mutableCopy;
    parameters[@"sign"] = [BilibiliAuth generateSign:parameters];
    
    [BilibiliRequest GET:BILIBILI_VIDEO_INFO parameters:parameters clazz:[VideoModel class] progress:nil success:success failure:failure];
}

//[API]http://interface.bilibili.com/playurl?appkey=6f90a59ac58a4123&cid=10602259&otype=json&quality=1&type=mp4&sign=7d888135da593bdf822cedfa8bab44d4
+(void)getPlayURLWithCid:(NSInteger)cid
                     vid:(NSInteger)vid
               videoType:(BilibiliVideoType)type
                 quality:(VideoQuarityOptions)quality
                 success:(SuccessBlock(PlayURLModel))success
                 failure:(FailureBlock)failure
{
    [self getPlayURLWithCid:cid vid:vid videoType:type format:@"mp4" quality:quality success:success failure:failure];
}

/* Private */
+(void)getPlayURLWithCid:(NSInteger)cid
                     vid:(NSInteger)vid
               videoType:(BilibiliVideoType)type
                  format:(NSString *)format // "mp4" "hdmp4" "flv"
                 quality:(VideoQuarityOptions)quality
                 success:(SuccessBlock(PlayURLModel))success
                 failure:(FailureBlock)failure
{
    NSDictionary * headers;
    if (type == BilibiliVideoTypeNormal)
        headers = @{@"Referer" : [NSString stringWithFormat:BILIBILI_LINK_AV, @(vid)],
                    @"Origin" : @"http://www.bilibili.com",
                    @"User-Agent" : @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36",
                    @"Accept-Language" : @"en-US,en;q=0.8",
                    @"Cookie" : @"fts=1476616618; pgv_pvi=5704434688; pgv_si=s6333356032; sid=7smc8t1u"};
    else headers = @{@"Referer" : [NSString stringWithFormat:BILIBILI_LINK_BANGUMI, @(vid)]};
    
    NSMutableDictionary * parameters = @{@"appkey" : APP_KEY,
                                         @"cid" : @(cid),
                                         @"otype" : @"json",
                                         @"quality" : @(quality),
                                         @"type" : format }.mutableCopy;
    parameters[@"sign"] = [BilibiliAuth generateSign:parameters];
    
    [BilibiliRequest GET:BILIBILI_VIDEO_PLAYURL parameters:parameters extraHeaders:headers clazz:[PlayURLModel class] progress:nil success:success failure:failure];
}

+(void)getDanmakuWithAid:(NSInteger)aid
                    page:(NSInteger)page /* 分p，从1开始 */
                 success:(void(^ _Nullable)(NSString * _Nullable xml))success
                 failure:(void(^ _Nullable)(void))failure
{
    
}

+(void)getDanmakuWithCid:(NSInteger)cid
                 success:(void(^ _Nullable)(NSString * _Nullable xml))success
                 failure:(void(^ _Nullable)(void))failure
{
    NSString * url = [NSString stringWithFormat:@"%@%@.xml", BILIBILI_DANMAKU, @(cid)];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * task, id  responseObject) {
        NSString * result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if(result != nil && [result isNotBlank])
            if(success) success(result);
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
#ifdef DEBUG
        NSLog(@"%@", error);
#endif
        if(failure) failure();
    }];
}

+(void)getCommentsWithAid:(NSInteger)aid
                    page:(NSInteger)page
                pageSize:(NSInteger)pageSize
                 success:(SuccessBlock(CommentsModel))success
                 failure:(FailureBlock)failure
{
    NSDictionary * parameters = @{@"oid" : @(aid),
                                  @"pn" : @(page),
                                  @"ps" : @(pageSize),
                                  @"sort" : @0,
                                  @"type" : @1};
    
    [BilibiliRequest GET:BILIBILI_VIDEO_COMMENTS parameters:parameters clazz:[CommentsModel class] progress:nil success:success failure:failure];
}


#pragma mark POST

+(void)commentVideo:(NSInteger)aid
            content:(NSString * _Nonnull)text
            success:(SuccessBlock)success
            failure:(FailureBlock)failure
{
    
}

+(void)sendDanmaku:(NSString * _Nonnull)text
          videoCid:(NSInteger)cid
              time:(NSTimeInterval)time
              type:(NSUInteger)type
          fontSize:(NSUInteger)fontSize
          hexColor:(NSUInteger)hexColor
           success:(SuccessBlock)success
           failure:(FailureBlock)failure
{
    
}

+(void)addFavoriteVideo:(NSInteger)aid
                success:(SuccessBlock)success
                failure:(FailureBlock)failure
{
    NSDictionary * parameters = @{@"aid" : @(aid)};
    [BilibiliRequest POST:BILIBILI_ADD_FAVOURIATE_VIDEO parameters:parameters progress:nil success:success failure:failure];
}

+(void)deleteFavoriteVideo:(NSInteger)aid
                   success:(SuccessBlock)success
                   failure:(FailureBlock)failure
{
    NSDictionary * parameters = @{@"aid" : @(aid)};
    [BilibiliRequest POST:BILIBILI_DELETE_FAVOURIATE_VIDEO parameters:parameters progress:nil success:success failure:failure];
}

#pragma mark BILIBILJJ

+(void)getAVInfoWithAID:(NSInteger)aid
                success:(void(^ _Nullable)(JJAVModel * _Nullable video))success
                failure:(void(^ _Nullable)(void))failure
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    
    NSString * url = [NSString stringWithFormat:@"%@%ld", BILIBILIJJ_AV2CID, (long)aid];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * task, id responseObject) {
        JJAVModel * videoModel = [JJAVModel modelWithDictionary:responseObject];
        if (videoModel.code == 0 && success)
            success(videoModel);
        else if(failure) failure();
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
#ifdef DEBUG
        if (error) NSLog(@"%@", error);
#endif
        if(failure) failure();
    }];
}

+(void)getVideoURLWithAID:(NSInteger)aid
                     page:(NSInteger)page
                  success:(void(^ _Nullable)(NSString * _Nullable url))success
                  failure:(void(^ _Nullable)(void))failure
{
    [self getNormalQualityVideoURLWithAID:aid page:page success:success failure:failure];
}

//+ (void)getLowQualityVideoURLWithAID:(NSInteger)aid
//                                page:(NSInteger)page
//                             success:(void(^ _Nullable)(NSString * _Nullable url))success
//                             failure:(void(^ _Nullable)(void))failure
//{
//    NSDictionary * parameters = @{@"aid" : @(aid),
//                                  @"page" : @(page)};
//    
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    [manager GET:BILIBILI_VIDEO_PLAYURL_M parameters:parameters progress:nil success:^(NSURLSessionDataTask * task, id responseObject) {
//        MPlayURLModel * mplayurl = [MPlayURLModel modelWithDictionary:responseObject];
//        if(mplayurl.code != 0);
//        else if(success) success(mplayurl.src);
//    } failure:^(NSURLSessionDataTask * task, NSError * error) {
//        if(failure) failure();
//    }];
//}

+ (void)getNormalQualityVideoURLWithAID:(NSInteger)aid
                                   page:(NSInteger)page
                                success:(void(^ _Nullable)(NSString * _Nullable url))success
                                failure:(void(^ _Nullable)(void))failure
{
    [self getAVInfoWithAID:aid success:^(JJAVModel * video) {
        //Get unredirected url
        NSString * jjurl = nil;
        if ((page - 1) < video.list.count)
            jjurl = video.list[page - 1].mp4Url;
        
        if (jjurl == nil)
        {
#ifdef DEBUG
            NSLog(@"%s Can not redirect.", __func__);
#endif
            if (failure) failure();
            return;
        }
        
        //Redirect to real playurl.
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        [manager HEAD:jjurl parameters:nil success:^(NSURLSessionDataTask * task) {
            if(success) success(task.currentRequest.URL.absoluteString);
        } failure:^(NSURLSessionDataTask * task, NSError * error) {
            if (failure) failure();
        }];
        
    } failure:failure];
}

@end
