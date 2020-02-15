//
//  OptionalExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/12/21.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

infix operator <- : OptionalAssignPrecedence

precedencegroup OptionalAssignPrecedence {
    associativity: left
    higherThan: AdditionPrecedence
}

/// Assign.
public func <- <T> (t1: inout T, t2: Optional<T>) {
    if let t = t2 {
        t1 = t
    }
}

