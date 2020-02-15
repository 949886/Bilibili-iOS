//
//  ChineseExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/2/28.
//  Copyright © 2017 YaeSakura. All rights reserved.
//

import Foundation

extension String
{

    /// E.G.
    ///「氷菓」-> 「bing guo」
    ///「氷iscream菓」 -> 「bing iscream guo」
    ///「氷。菓」 -> 「bing。guo」
    public var pinyin: String {
        let cfstring = CFStringCreateMutableCopy(nil, 0, self as CFString)
        CFStringTransform(cfstring, nil, kCFStringTransformMandarinLatin, false)
        CFStringTransform(cfstring, nil, kCFStringTransformStripCombiningMarks, false)
        return String(describing: cfstring)
    }
    
}


#if swift(>=4)
extension BinaryInteger
{
    public func toChinese() -> String {
        return self.toChinese(precision: 2)
    }
    
    public func toChinese(precision: Int) -> String {
        let num = Double(Int.max)
        
        if self >= 1_0000 { return String(format: "%.*f万", precision, num / 1_0000) }
        else if self >= 1_0000_0000 { return String(format: "%.*f亿", precision, num / 1_0000_0000) }
        else { return "\(self)" }
    }
}
#else
extension Integer
{
    public func toChinese() -> String {
        return self.toChinese(precision: 2)
    }
    
    public func toChinese(precision: Int) -> String {
        let num = Double(self.toIntMax())
        
        if self >= 1_0000 { return String(format: "%.*f万", precision, num / 1_0000) }
        else if self >= 1_0000_0000 { return String(format: "%.*f亿", precision, num / 1_0000_0000) }
        else { return "\(self)" }
    }
}
#endif


extension Float
{
    public func toChinese() -> String {
        return self.toChinese(precision: 2)
    }
    
    public func toChinese(precision: Int) -> String {
        if self >= 1_0000 { return String(format: "%.*f万", precision, self / 1_0000)}
        else if self >= 1_0000_0000 { return String(format: "%.*f亿", precision, self / 1_0000_0000)}
        else { return "\(self)" }
    }
}

extension Double
{
    public func toChinese() -> String {
        return self.toChinese(precision: 2)
    }
    
    public func toChinese(precision: Int) -> String {
        if self >= 1_0000 { return String(format: "%.*f万", precision, self / 1_0000)}
        else if self >= 1_0000_0000 { return String(format: "%.*f亿", precision, self / 1_0000_0000)}
        else { return "\(self)" }
    }
}
