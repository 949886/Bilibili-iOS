//
//  FileManagerExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/1/15.
//  Copyright © 2017 YaeSakura. All rights reserved.
//

import Foundation

extension FileManager
{
    
    /// Get file size (not a directory).
    ///
    /// - Parameter path: Path of a certain file.
    /// - Returns: File size in byte.
    public static func fileSize(path: String) -> UInt64?
    {
        let manager = FileManager.default
        if !manager.fileExists(atPath: path) { return 0 }
        return (try? manager.attributesOfItem(atPath: path) as NSDictionary)?.fileSize()
    }
    
    /// Get folder size (not a file).
    ///
    /// - Parameter path: Directory of folder.
    /// - Returns: Folder size in byte.
    public static func folderSize(path: String) -> UInt64?
    {
        var size: UInt64 = 0
        let manager = FileManager.default
        if !manager.fileExists(atPath: path) { return 0 }
        
        let subpaths = manager.subpaths(atPath: path)
        for subpath in subpaths! where subpaths != nil {
            let fullpath: String = URL(fileURLWithPath: path).appendingPathComponent(subpath).absoluteString
            if let fileSize = FileManager.fileSize(path: fullpath) {
                size += fileSize
            }
        }
        return size
    }
    
}
