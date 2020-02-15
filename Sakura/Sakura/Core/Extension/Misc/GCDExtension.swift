//
//  GCDExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/3/2.
//  Copyright © 2017 YaeSakura. All rights reserved.
//

import Foundation

extension DispatchQueue
{
    
    /// Executes a block object once and only once for the lifetime of an application with a specific identifier.
    ///
    /// - Parameters:
    ///   - token: Block identifier.
    ///   - block: The block to execute once.
    public static func once(token: String, execute closure:()->Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        if _onceTracker.contains(token) { return }
        _onceTracker.append(token)
        closure()
    }
    private static var _onceTracker = [String]()
    
    /// Executes a block after a certain time.
    ///
    /// - Parameters:
    ///   - milliseconds: Delay time (millisecond).
    ///   - closure: The block to execute once.
    public func asyncAfter(_ milliseconds: TimeInterval, execute closure: @escaping () -> Void) {
        asyncAfter(deadline: .now() + milliseconds * 0.001, execute: closure)
    }
    
}
