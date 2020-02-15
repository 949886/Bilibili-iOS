//
//  CGAffineTransformExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/12/12.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

extension CGAffineTransform
{
    /// Radian of rotation.
    var routation: CGFloat {
        return CGFloat(atan2f(Float(self.b), Float(self.a)))
    }
    
    /// Translation.
    var translation: CGPoint {
        return CGPoint(x: self.tx, y: self.ty)
    }
    
    /// Translation.
    var scale: CGFloat {
        return CGFloat(sqrt(Double(self.a * self.a + self.c * self.c)))
    }
}
