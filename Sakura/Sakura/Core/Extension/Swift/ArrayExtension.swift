//
//  ArrayExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/6/24.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

//MARK: JSON

extension Array
{
    var json: String {
        let data = (try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)) ?? Data()
        return String(data: data, encoding: .utf8)!
    }
    
    public init?(json: String) {
        if let data = json.data(using: .utf8){
            self.init(jsonData: data)
        } else { return nil }
    }
    
    public init?(jsonData: Data) {
        if  let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments),
            let array = jsonObject as? Array {
            self = array
        } else { return nil }
    }
    
    public init?(file: String) {
        if let array = NSArray(contentsOfFile: file) as? [Element] {
            self = array
        } else { return nil }
    }
}

//MARK: - Predicate

extension Array
{
    ///Evaluate a predicate against an array of objects and return a filtered array.
    public mutating func filter(using predicate: Predicate) {
        let filtered = (self as NSArray).filtered(using: predicate) as? Array
        self = filtered ?? []
    }
    
    ///Evaluates a given predicate against the array’s content and leaves only objects that match.
    public func filtered(using predicate: Predicate) -> [Any] {
        return (self as NSArray).filtered(using: predicate)
    }
}


//MARK: - LINQ

extension Array
{
#if swift(>=4)
    func distinct(for keyPath: KeyPath<Element, Any>) -> Array? {
        return nil
    }
    
    func `where`() {
    
    }
#endif
}
