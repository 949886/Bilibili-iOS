//
//  UIApplicationExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2016/12/5.
//  Copyright © 2016 Sakura. All rights reserved.
//

import Foundation

public extension UIApplication {
    public var bundleName : String { return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String }
    public var bundleID : String { return Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as! String }
    public var version : String { return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String }
    public var buildVersion : String { return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String }
}
