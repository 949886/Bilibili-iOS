//
//  CALayerExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/2/28.
//  Copyright © 2017 Sakura. All rights reserved.
//

import Foundation

extension CALayer
{
    func pauseAnimation()
    {
        var pausedTime = self.convertTime(CACurrentMediaTime(), from: nil)
        self.speed = 0.0
        self.timeOffset = pausedTime
    }
    
    func resumeAnimation()
    {
        var pausedTime = self.timeOffset
        self.speed = 1.0
        self.timeOffset = 0.0
        self.beginTime = 0.0
        var timeSincePause = self.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        self.beginTime = timeSincePause
    }
}
