//
//  FileManagerExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/1/15.
//  Copyright © 2017 Sakura. All rights reserved.
//

import Foundation

extension FileManager {
    
    public static func fileSize(path: String) -> UInt64?
    {
        var manager = FileManager.default
        if !manager.fileExists(atPath: path) { return 0 }
        return (try? manager.attributesOfItem(atPath: path) as NSDictionary)?.fileSize()
    }
    
    public static func folderSize(path: String) -> UInt64?
    {
        var size: UInt64 = 0
        var manager = FileManager.default
        if !manager.fileExists(atPath: path) { return 0 }
        
        var subpaths = manager.subpaths(atPath: path)
        for subpath in subpaths! where subpath != nil {
            var fullpath: String = URL(fileURLWithPath: path).appendingPathComponent(subpath).absoluteString
            if let fileSize = FileManager.fileSize(path: fullpath) {
                size += fileSize
            }
        }
        return size
    }
    
}
