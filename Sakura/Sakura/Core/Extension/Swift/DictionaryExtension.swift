//
//  DictionaryExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/6/24.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation


extension Dictionary
{
    public var json: String {
        let data = (try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)) ?? Data()
        return String(data: data, encoding: .utf8)!
    }
    
    public init?(json: String) {
        if let data = json.data(using: .utf8) {
            self.init(jsonData: data)
        } else { return nil }
    }
    
    public init?(jsonData: Data) {
        if  let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments),
            let dict = jsonObject as? Dictionary {
            self = dict
        } else { return nil }
    }
    
    public init?(file: String) {
        if let dict = NSDictionary(contentsOfFile: file) as? [Key:Value] {
            self = dict
        } else { return nil }
    }
    
    @discardableResult
    public func write(toFile: String) -> Bool {
        let dict = self as NSDictionary
        return dict.write(toFile: toFile, atomically: true)
    }
}

extension Dictionary where Key == String
{
    
    /// If a dictionary contains dictionary, use this method to fetch value by key path.
    /// e.g. for dict { "aaa" : { "bbb" : "ccc" } } ,
    /// dict.value(forKeyPath: "aaa.bbb") == "ccc"
    ///
    /// - Parameter keyPath: Key path in dictionay.
    /// - Returns: Value for a certain key path.
    public func value(forKeyPath keyPath: String?) -> Any? {
        if keyPath == nil { return self }
        
        let keys = keyPath!.components(separatedBy: ".")
        
        var dict: Dictionary<String, Any> = self
        for (index, key) in keys.enumerated() {
            let value = dict[key]
            if value != nil && index == keys.count - 1 {
                return value
            } else if value != nil && value is Dictionary<String, Any> {
                dict = value as! Dictionary<String, Any>
            } else { break }
        }
        
        return self
    }
    
}
