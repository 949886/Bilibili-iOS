//
//  UIColorExtension.swift
//  Sakura
//
//  Created by YaeSakura on 16/5/9.
//  Copyright © 2016 Sakura. All rights reserved.
//

#if os(OSX)
    import Cocoa
    public typealias Color = NSColor
#else
    import UIKit
    public typealias Color = UIColor
#endif


//MARK: Common

extension Color
{
    
    /// Color from hex unsigned int value.
    ///
    /// - Parameter hex: e.g. 0xAARRGGBB
    @objc public convenience init(hex : UInt) {
        let r = CGFloat((hex & 0xFF000000) >> 24) / 255.0
        let g = CGFloat((hex & 0x00FF0000) >> 16) / 255.0
        let b = CGFloat((hex & 0x0000FF00) >> 8) / 255.0
        let a = CGFloat(hex & 0x000000FF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    /// Color from hex string.
    ///
    /// - Parameter hexString: #RGB #RGBA #RRGGBB #RRGGBBAA
    @objc public convenience init?(hexString : String) {
        var hexString = hexString.uppercased()
        
        if hexString.hasPrefix("#") {
            hexString = hexString.subString(from: 1)
        } else if hexString.hasPrefix("0X") {
            hexString = hexString.subString(from: 2)
        }
        
        if  hexString.length != 3 &&    //RGB
            hexString.length != 4 &&    //RGBA
            hexString.length != 6 &&    //RRGGBB
            hexString.length != 8 {     //RRGGBBAA
            return nil
        }
        
        if let hex = UInt(hexString, radix: 16) {
            if hexString.length == 3 {
                let r = CGFloat((hex & 0xF00) >> 8) / 255.0
                let g = CGFloat((hex & 0x0F0) >> 4) / 255.0
                let b = CGFloat(hex & 0x00F) / 255.0
                self.init(red: r, green: g, blue: b, alpha: 1.0)
            } else if hexString.length == 4 {
                let r = CGFloat((hex & 0xF000) >> 12) / 255.0
                let g = CGFloat((hex & 0x0F00) >> 8) / 255.0
                let b = CGFloat((hex & 0x00F0) >> 4) / 255.0
                let a = CGFloat(hex & 0x000F) / 255.0
                self.init(red: r, green: g, blue: b, alpha: a)
            } else if hexString.length == 6 {
                let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
                let g = CGFloat((hex & 0x00FF00) >> 8) / 255.0
                let b = CGFloat(hex & 0x0000FF) / 255.0
                self.init(red: r, green: g, blue: b, alpha: 1.0)
            } else if hexString.length == 8 {
                let r = CGFloat((hex & 0xFF000000) >> 24) / 255.0
                let g = CGFloat((hex & 0x00FF0000) >> 16) / 255.0
                let b = CGFloat((hex & 0x0000FF00) >> 8) / 255.0
                let a = CGFloat(hex & 0x000000FF) / 255.0
                self.init(red: r, green: g, blue: b, alpha: a)
            } else { return nil }
        } else { return nil }
    }
    
    /// Get hex formated string (RRGGBB).
    @objc public var hexString: String {
        let rgba = self.rgba
        let r = rgba.r
        let g = rgba.g
        let b = rgba.b
        return String(format: "%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
    }
    
    /// Get rgba components of color.
    public var rgba: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        var r = 0.f, g = 0.f, b = 0.f, a = 0.f
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r, g, b, a)
    }
    
    /// Red component of color.
    @objc public var r: CGFloat {
        var red: CGFloat = 0
        self.getRed(&red, green: nil, blue: nil, alpha: nil)
        return red
    }
    
    /// Green component of color.
    @objc public var g: CGFloat {
        var green: CGFloat = 0
        self.getRed(nil, green: &green, blue: nil, alpha: nil)
        return green
    }
    
    /// Blue component of color.
    @objc public var b: CGFloat {
        var blue: CGFloat = 0
        self.getRed(nil, green: nil, blue: &blue, alpha: nil)
        return blue
    }
    
    /// Alpha component of color.
    @objc public var alpha: CGFloat {
        return self.cgColor.alpha
    }
    
    /// Hue of color.
    @objc public var hue: CGFloat {
        var hue: CGFloat = 0
        self.getHue(&hue, saturation: nil, brightness: nil, alpha: nil)
        return hue
    }
    
    /// Saturation of color.
    @objc public var saturation: CGFloat {
        var saturation: CGFloat = 0
        self.getHue(nil, saturation: &saturation, brightness: nil, alpha: nil)
        return saturation
    }
    
    /// Brightness of color.
    @objc public var brightness: CGFloat {
        var brightness: CGFloat = 0
        self.getHue(nil, saturation: nil, brightness: &brightness, alpha: nil)
        return brightness
    }
    
    /// Grayscale of color.
    @objc public var grayscale: CGFloat {
        let gs = 0.299 * r + 0.587 * g + 0.114 * b
        if gs > 1.0 {
            return 1.f
        }
        return gs
    }
    
}

//MARK: Filters

extension Color
{
    @objc public func multiply(_ color: Color) -> Color {
        return self * color
    }
}

//MARK: Operators

extension Color
{
    
    // Multiply.
    public static func * (c1: Color, c2: Color) -> Color {
        let r = c2.r * (c1.r / 255)
        let g = c2.g * (c1.g / 255)
        let b = c2.b * (c1.b / 255)
        let a = c2.alpha * (c1.alpha / 255)
        return Color(red: r, green: g, blue: b, alpha: a)
    }
    
    // Multiply.
    public static func *= (c1: inout Color, c2: Color) {
        c1 = c1 * c2
    }
    
}

