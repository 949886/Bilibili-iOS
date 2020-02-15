//
//  Stack.swift
//  Sakura
//
//  Created by YaeSakura on 2017/7/6.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

public struct Stack<T>//: Collection
{
    fileprivate var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func push(_ element: T) {
        array.append(element)
    }
    
    public mutating func pop() -> T? {
        return array.popLast()
    }
    
    public var top: T? {
        return array.last
    }
}

extension Stack: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        var curr = self
        return AnyIterator { () -> T? in
            return curr.pop()
        }
    }
}
