//
//  UIManagedDocumentExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/11/30.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

extension UIManagedDocument
{
    
    /// Singleton instance of UIManagedDocument.
    public static var `default`: UIManagedDocument {
        struct Static {
            static var managedDocument: UIManagedDocument = {
                let defaultPath =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("ManagedDocuments")
                print(defaultPath.path)
                let document = UIManagedDocument(fileURL: defaultPath)
                if FileManager.default.fileExists(atPath: defaultPath.path, isDirectory: nil) {
                    document.open { isSuccess in
                        assert(isSuccess, "Open default managed document failed.")
                    }
                } else {
                    document.save(to: defaultPath, for: .forCreating) { isSuccess in
                        assert(isSuccess, "Create default managed document failed.")
                    }
                }
                return document
            }()
        }
        return Static.managedDocument
    }
    
}
