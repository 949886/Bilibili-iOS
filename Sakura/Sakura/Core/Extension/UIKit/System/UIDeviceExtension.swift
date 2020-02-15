//
//  UIDeviceExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2016/12/7.
//  Copyright © 2016 Sakura. All rights reserved.
//

import UIKit

extension UIDevice {
    
    public var type: UIUserInterfaceIdiom {
        struct Static {
            static var idiom: UIUserInterfaceIdiom = UI_USER_INTERFACE_IDIOM()
        }
        return Static.idiom
    }
    
    public var isSimulator: Bool {
        #if TARGET_OS_SIMULATOR
            return true
        #else
            return false
        #endif
    }
    
//    var isJailBroken: Bool {
//        return false
//    }
//
//    public var isProxying: Bool {
//        let unmanaged = CFNetworkCopySystemProxySettings()
//        let setting = unmanaged?.takeUnretainedValue()
//        if let dict = setting as? [String : Any] {
//
//        }
//
//        return false
//    }
    
    public var machineModel: String {
        var size: size_t = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        let machine = malloc(size)
        sysctlbyname("hw.machine", machine, &size, nil, 0)
        let pmachine = machine!.assumingMemoryBound(to: CChar.self)
        let model = String(validatingUTF8:pmachine) ?? ""
        free(machine)
        return model
    }
    
    public var machineName: String {
        struct Static {
            static var name: String? = nil
        }
        
        if Static.name == nil {
            let mapper = ["Watch1,1" : "Apple Watch",
                          "Watch1,2" : "Apple Watch",
                          "Watch2,3" : "Apple Watch Series 2 38mm",
                          "Watch2,4" : "Apple Watch Series 2 42mm",
                          "Watch2,6" : "Apple Watch Series 1 38mm",
                          "Watch1,7" : "Apple Watch Series 1 42mm",
                          
                          "iPod1,1" : "iPod touch 1",
                          "iPod2,1" : "iPod touch 2",
                          "iPod3,1" : "iPod touch 3",
                          "iPod4,1" : "iPod touch 4",
                          "iPod5,1" : "iPod touch 5",
                          "iPod7,1" : "iPod touch 6",
                          
                          "iPhone1,1" : "iPhone 1G",
                          "iPhone1,2" : "iPhone 3G",
                          "iPhone2,1" : "iPhone 3GS",
                          "iPhone3,1" : "iPhone 4 (GSM)",
                          "iPhone3,2" : "iPhone 4",
                          "iPhone3,3" : "iPhone 4 (CDMA)",
                          "iPhone4,1" : "iPhone 4S",
                          "iPhone5,1" : "iPhone 5",
                          "iPhone5,2" : "iPhone 5",
                          "iPhone5,3" : "iPhone 5c",
                          "iPhone5,4" : "iPhone 5c",
                          "iPhone6,1" : "iPhone 5s",
                          "iPhone6,2" : "iPhone 5s",
                          "iPhone7,1" : "iPhone 6 Plus",
                          "iPhone7,2" : "iPhone 6",
                          "iPhone8,1" : "iPhone 6s",
                          "iPhone8,2" : "iPhone 6s Plus",
                          "iPhone8,4" : "iPhone SE",
                          "iPhone9,1" : "iPhone 7",
                          "iPhone9,2" : "iPhone 7 Plus",
                          "iPhone9,3" : "iPhone 7",
                          "iPhone9,4" : "iPhone 7 Plus",
                          "iPhone10,1" : "iPhone 8",
                          "iPhone10,4" : "iPhone 8",
                          "iPhone10,2" : "iPhone 8 Plus",
                          "iPhone10,5" : "iPhone 8 Plus",
                          "iPhone10,3" : "iPhone X",
                          "iPhone10,6" : "iPhone X",
                          
                          "iPad1,1" : "iPad 1",
                          "iPad2,1" : "iPad 2 (WiFi)",
                          "iPad2,2" : "iPad 2 (GSM)",
                          "iPad2,3" : "iPad 2 (CDMA)",
                          "iPad2,4" : "iPad 2",
                          "iPad2,5" : "iPad mini 1",
                          "iPad2,6" : "iPad mini 1",
                          "iPad2,7" : "iPad mini 1",
                          "iPad3,1" : "iPad 3 (WiFi)",
                          "iPad3,2" : "iPad 3 (4G)",
                          "iPad3,3" : "iPad 3 (4G)",
                          "iPad3,4" : "iPad 4",
                          "iPad3,5" : "iPad 4",
                          "iPad3,6" : "iPad 4",
                          "iPad4,1" : "iPad Air",
                          "iPad4,2" : "iPad Air",
                          "iPad4,3" : "iPad Air",
                          "iPad4,4" : "iPad mini 2",
                          "iPad4,5" : "iPad mini 2",
                          "iPad4,6" : "iPad mini 2",
                          "iPad4,7" : "iPad mini 3",
                          "iPad4,8" : "iPad mini 3",
                          "iPad4,9" : "iPad mini 3",
                          "iPad5,1" : "iPad mini 4",
                          "iPad5,2" : "iPad mini 4",
                          "iPad5,3" : "iPad Air 2",
                          "iPad5,4" : "iPad Air 2",
                          "iPad6,3" : "iPad Pro (9.7 inch)",
                          "iPad6,4" : "iPad Pro (9.7 inch)",
                          "iPad6,7" : "iPad Pro (12.9 inch)",
                          "iPad6,8" : "iPad Pro (12.9 inch)",
                          
                          "AppleTV2,1" : "Apple TV 2",
                          "AppleTV3,1" : "Apple TV 3",
                          "AppleTV3,2" : "Apple TV 3",
                          "AppleTV5,3" : "Apple TV 4",
                          
                          "i386" : "Simulator x86",
                          "x86_64" : "Simulator x64"]
            
            Static.name = mapper[machineModel]
        }
        
        return Static.name ?? ""
    }
}
