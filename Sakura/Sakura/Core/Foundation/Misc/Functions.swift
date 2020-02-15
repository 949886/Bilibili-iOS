//
//  Functions.swift
//  Sakura
//
//  Created by YaeSakura on 2017/7/5.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

/// Queries size of the object or type just like sizeof operator in C.
/// E.G. sizeof(UInt64.self) is 8.
///
/// - Parameter type: Any type.
/// - Returns: Size of a certain type.
public func sizeof<T>(_ type: T) -> Int {
    return MemoryLayout<T>.size
}
