//
//  TimerExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/2/28.
//  Copyright © 2017 Sakura. All rights reserved.
//

import Foundation

extension Timer
{
    public func pause() { self.fireDate = Date.distantFuture }
    public func resume() { self.fireDate = Date() }
}
