//
//  ZXScanCodeViewController.h
//  Coding_iOS
//
//  Created by Ease on 15/7/2.
//  Copyright (c) 2015年 Coding. All rights reserved.
//

//#import "BaseViewController.h"

@import UIKit;
@import AVFoundation;

@interface ScanBGView : UIView
@property (assign, nonatomic) CGRect scanRect;
@end


@interface Helper : NSObject

/**
 * 检查系统"照片"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
 */
+ (BOOL)checkPhotoLibraryAuthorizationStatus;

/**
 * 检查系统"相机"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
 */
+ (BOOL)checkCameraAuthorizationStatus;

@end

@interface ZXScanCodeViewController : UIViewController
@property (strong, nonatomic, readonly) AVCaptureVideoPreviewLayer *videoPreviewLayer;
- (BOOL)isScaning;
- (void)startScan;
- (void)stopScan;

@property (copy, nonatomic) void(^scanResultBlock)(ZXScanCodeViewController *vc, NSString *resultStr);

@end
