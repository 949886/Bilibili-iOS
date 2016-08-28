//
//  Downloader.m
//  Bilibili
//
//  Created by LunarEclipse on 16/8/23.
//  Copyright © 2016年 LunarEclipse. All rights reserved.
//

#import "Downloader.h"

#define CACHE_PATH NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject
#define FILE_PATH(__FILE_NAME__) [CACHE_PATH stringByAppendingFormat:@"/Download/%@", __FILE_NAME__]
#define FILE_SIZE(__FILE_NAME__) [[NSFileManager defaultManager] attributesOfItemAtPath:FILE_PATH(__FILE_NAME__) error:nil].fileSize

#define DOWNLOAD_LOG @"DownloadLog.plist"

@interface FileInfo : NSObject

@property (nonatomic, copy) NSString * name;
@property (nonatomic, assign) NSInteger * size;

@end

@implementation FileInfo

@end


@interface Downloader ()

@property (nonatomic, strong) NSURLSession * session;
@property (nonatomic, strong) NSURLSessionDataTask * task;

@property (assign) NSInteger downloadedBytes;
@property (assign) NSInteger totalBytes;

@property (nonatomic, strong) NSOutputStream * ostream;

@property (nonatomic, copy) NSString * filename;
@property (nonatomic, copy) NSString * tag;
//如果tag相同，则下载任务也相同。一般一个url可以标志唯一的一个的下载任务，当然也有例外，如请求同一个视频下次请求的url就可能与上一次的不相同（动态变化），这时就需要相同的indicator来标志两个下载任务下载的是同一个文件。

@property (nonatomic, copy) DownloadProgressBlock progress;
@property (nonatomic, copy) DownloadSuccessBlock success;
@property (nonatomic, copy) DownloadFailureBlock failure;

@property (nonatomic, strong) NSProgress * downloadProgress;

@end

@implementation Downloader

+ (instancetype)downloader
{
    return [Downloader new];
}

- (instancetype)init
{
    if (self = [super init])
    {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc]init]];
        _downloadProgress = [NSProgress new];
        
        //目录不存在则创建目录
        if (![[NSFileManager defaultManager] fileExistsAtPath:FILE_PATH(@"")])
            [[NSFileManager defaultManager] createDirectoryAtPath:FILE_PATH(@"") withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return self;
}

- (void)download:(NSString * _Nonnull)urlString
             tag:(NSString * _Nonnull)tag
        progress:(DownloadProgressBlock)progress
         success:(DownloadSuccessBlock)success
         failure:(DownloadFailureBlock)failure
{
    _tag = tag;
    _progress = progress;
    _success = success;
    _failure = failure;
    
    //获取已下载大小和文件总大小
    NSDictionary * log = [NSDictionary dictionaryWithContentsOfFile:FILE_PATH(DOWNLOAD_LOG)][_tag];
    _downloadedBytes = FILE_SIZE(log[@"Filename"]);
    _totalBytes = [log[@"Size"] integerValue];
    
    if(_totalBytes && _totalBytes == _downloadedBytes)
    {
#ifdef DEBUG
        NSLog(@"%s File has already been downloaded.", __func__);
#endif
        return;
    }
    
    //创建下载请求
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setValue:[NSString stringWithFormat:@"bytes=%ld-", (long)_downloadedBytes] forHTTPHeaderField:@"Range"];
    
    _task = [_session dataTaskWithRequest:request];
    [_task resume];
}

- (void)resume
{
    [_task resume];
}

- (void)suspend
{
    [_task suspend];
}

#pragma mark Delegate

/* NSURLSessionDataDelegate */

//Start
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSHTTPURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler;
{
    //文件名
    _filename = response.suggestedFilename;
    
    //文件总大小
    _totalBytes = _downloadedBytes;
    _totalBytes += [[response allHeaderFields][@"Content-Length"] integerValue];
    
    _downloadProgress.totalUnitCount = _totalBytes;
    
    //缓存HTTP响应首部及文件名
    NSMutableDictionary * fileInfo = [NSMutableDictionary dictionary];
    fileInfo[@"Filename"] = _filename;
    fileInfo[@"Size"] = @(_totalBytes);
    
    NSMutableDictionary * log = [NSMutableDictionary dictionaryWithContentsOfFile:FILE_PATH(DOWNLOAD_LOG)];
    if(log == nil) log = [NSMutableDictionary dictionary];
    log[_tag] = fileInfo;
    [log writeToFile:FILE_PATH(DOWNLOAD_LOG) atomically:YES];
    
    //Output Stream
    _ostream = [NSOutputStream outputStreamToFileAtPath:FILE_PATH(_filename) append:YES];
    [_ostream open];
    
    completionHandler(NSURLSessionResponseAllow);
}

//Download process
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    _downloadedBytes += data.length;
    [_ostream write:data.bytes maxLength:data.length];
    
    _downloadProgress.completedUnitCount = _downloadedBytes;
    if (_progress) _progress(_downloadProgress);
}

//End
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionDataTask *)task didCompleteWithError:(nullable NSError *)error
{
    [_ostream close];
    
    if (error)
    {
        if (_failure) _failure(task, error);
    }
    else if(_success) _success(task, [NSURL URLWithString:FILE_PATH(_filename)]);
}

@end
