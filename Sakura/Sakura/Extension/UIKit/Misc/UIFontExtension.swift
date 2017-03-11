//
//  UIFontExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/2/28.
//  Copyright © 2017 Sakura. All rights reserved.
//

import Foundation

extension UIFont
{
    static func lightSystemFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Light", size: fontSize)!
    }
    
    static func ultraLightSystemFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-UltraLight", size: fontSize)!
    }
}
