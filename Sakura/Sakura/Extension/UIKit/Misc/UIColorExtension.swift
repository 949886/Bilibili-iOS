//
//  UIColorExtension.swift
//  Swifty
//
//  Created by YaeSakura on 16/5/9.
//  Copyright © 2016 Sakura. All rights reserved.
//

import UIKit

extension UIColor
{
    convenience init(hexString : String)
    {
        let rgba = UIColor.hex2RGB("")
        self.init(red: rgba.0, green: rgba.1, blue: rgba.2, alpha: rgba.3)
    }
    
    static func hex2RGB(_ hexString : String) -> (CGFloat, CGFloat, CGFloat, CGFloat)
    {
        var hex = hexString.uppercased()
        
        if hex.hasPrefix("#") {
            hex = hex.subString(from: 1)
        }
        if hex.hasPrefix("0X") {
            hex = hex.subString(from: 2)
        }

        return (0, 0, 0, 0)
    }
}
