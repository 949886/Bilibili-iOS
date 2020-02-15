//
//  CGPointExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/12/13.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

extension CGPoint
{
    
    /// Addition.
    public static func + (p1: CGPoint, p2: CGPoint) -> CGPoint {
        return CGPoint(x: p1.x + p2.x, y: p1.y + p2.y)
    }
    
    /// Addition.
    public static func += (p1: inout CGPoint, p2: CGPoint) {
        p1 = CGPoint(x: p1.x + p2.x, y: p1.y + p2.y)
    }
    
    /// Subtraction.
    public static func - (p1: CGPoint, p2: CGPoint) -> CGPoint {
        return CGPoint(x: p1.x - p2.x, y: p1.y - p2.y)
    }
    
    /// Subtraction.
    public static func -= (p1: inout CGPoint, p2: CGPoint) {
        p1 = CGPoint(x: p1.x - p2.x, y: p1.y - p2.y)
    }
    
    /// Scalar multiplication.
    public static func * (p1: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: p1.x * scalar, y: p1.y * scalar)
    }
    
    /// Scalar multiplication.
    public static func *= (point: inout CGPoint, scalar: CGFloat) {
        point = point * scalar
    }
    
    /// Dot product.
    public static func · (p1: CGPoint, p2: CGPoint) -> CGFloat {
        return p1.x * p2.x + p1.y * p2.y
    }
    
}

