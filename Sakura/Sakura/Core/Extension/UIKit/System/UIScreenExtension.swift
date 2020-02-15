//
//  UIScreenExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/1/15.
//  Copyright © 2017 YaeSakura. All rights reserved.
//

import Foundation

extension UIScreen
{
    
    /// Length of one pixel.
    @objc public static var pixel: CGFloat {
        return 1.0 / UIScreen.main.scale
    }
    
    // Screen width.
    @objc public var width: CGFloat {
        return self.bounds.size.width
    }
    
    // Screen height.
    @objc public var height: CGFloat {
        return self.bounds.size.height
    }
    
    /// Status bar height (Common: 20, iPhoneX: 44)
    @objc public var statusBarHeight: CGFloat {
        struct Static {
            static var height: CGFloat = UIScreen.main.type == .p2436x1125 ? 44.0 : 20.0
        }
        return Static.height
    }
    
    /// Top bar height (Common: 64, iPhoneX: 88)
    @objc public var topBarHeight: CGFloat {
        struct Static {
            static var height: CGFloat = UIScreen.main.type == .p2436x1125 ? 88.0 : 64.0
        }
        return Static.height
    }
    
    /// Tab bar height (Common: 49, iPhoneX: 83)
    @objc public var tabBarHeight: CGFloat {
        struct Static {
            static var height: CGFloat = UIScreen.main.type == .p2436x1125 ? 83.0 : 49.0
        }
        return Static.height
    }
    
    public var type: ScreenType {
        struct Static {
            static var screenType: ScreenType = {
                let size = UIScreen.main.bounds.size
                let scale = UIScreen.main.scale
                switch (size.height, size.width, scale) {
                case (812, 375, 3): return .p2436x1125
                case (736, 414, 3): return .p1920x1080
                case (667, 375, 2): return .p1334x750
                case (568, 320, 2): return .p1136x640
                case (480, 320, 2): return .p960x640
                case (480, 320, 1): return .p480x320
                case (1366, 1024, 2): return .p2732x2048
                case (1024, 768, 2): return .p2048x1536
                case (1024, 768, 1): return .p1024x768
                default: return .unknown
                }
            }()
        }
        return Static.screenType
    }
    
    public enum ScreenType: Int {
        
        //iPhone
        case p2436x1125     //iPhone X
        case p1920x1080     //iPhone 6shang plus
        case p1334x750      //iPhone 6+
        case p1136x640      //iPhone SE
        case p960x640       //iPhone 4/4s
        case p480x320       //iPhone 4-
        
        //iPad
        case p2732x2048     //iPad pro 12.9"
        case p2048x1536     //iPad air
        case p1024x768      //old iPad
        
        //Other
        case unknown
        
    }
    
}
