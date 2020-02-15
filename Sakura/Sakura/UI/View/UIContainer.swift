//
//  UIContainer.swift
//  Sakura
//
//  Created by YaeSakura on 2017/9/19.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

/// ContainerView don not handle any touch event by itself where there is no subview.
/// All touch events will be passed to its superview or subviews.
open class UIContainer: UIView
{
    // Only handle touches in subviews.
    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        for subview in subviews {
            let p = subview.convert(point, from: self)
            if subview.bounds.contains(p) {
                return subview.hitTest(p, with: event)
            }
        }
        return nil
    }
}

