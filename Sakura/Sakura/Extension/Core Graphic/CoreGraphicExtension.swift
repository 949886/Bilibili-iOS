//
//  CoreGraphicExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/1/14.
//  Copyright © 2017 Sakura. All rights reserved.
//

import Foundation

extension CGRect {
    
    var x: CGFloat {
        get { return self.origin.x }
        set { self.origin.x = newValue }
    }
    
    var y: CGFloat {
        get { return self.origin.y }
        set { self.origin.y = newValue }
    }
    
    var width: CGFloat {
        get { return self.size.width }
        set { self.size.width = newValue }
    }
    
    var height: CGFloat {
        get { return self.size.height }
        set { self.size.height = newValue }
    }
    
}
