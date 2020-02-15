//
//  PointerExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/5/24.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

typealias Pointer<T> = UnsafeMutablePointer<T>

prefix operator %   //Equal to '&' (address-of operator) in C.
prefix operator *   //Equal to '*' (value of pointer) in C.

/// Get header pointer for struct, enum, etc...
prefix func % <T>( instance: inout T) -> UnsafeMutablePointer<T> {
    var pointer: UnsafeMutablePointer<T>!
    withUnsafeMutablePointer(to: &instance) {
        pointer = $0
    }
    return pointer
}

/// Get head pointer for object.
prefix func % <T>(object: inout T) -> UnsafeMutablePointer<T> where T: AnyObject {
    let opaque = Unmanaged<T>.passUnretained(object).toOpaque()
    let pointer = opaque.assumingMemoryBound(to: T.self)
    return pointer
}

/// Get value of point (just like C).
public prefix func * <T>(pointer: UnsafePointer<T>) -> T {
    return pointer.pointee
}

/// Get value of point (just like C).
public prefix func * <T>(pointer: UnsafeMutablePointer<T>) -> T {
    return pointer.pointee
}
