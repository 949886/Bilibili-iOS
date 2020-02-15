//
//  UIFontExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/2/28.
//  Copyright © 2017 YaeSakura. All rights reserved.
//

import Foundation

extension UIFont
{
    @objc public static func lightSystemFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Light", size: fontSize)!
    }
    
    @objc public static func ultraLightSystemFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-UltraLight", size: fontSize)!
    }
}
