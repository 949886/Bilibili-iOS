//
//  UIImageExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2016/11/24.
//  Copyright © 2016 Sakura. All rights reserved.
//

import Foundation

extension UIImage {
    
    public var centerStretchableImage : UIImage? {
        return self.stretchableImage(withLeftCapWidth: Int(self.size.width * 0.5), topCapHeight: Int(self.size.height * 0.5))
    }
    
} 
