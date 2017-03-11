//
//  ChineseExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/2/28.
//  Copyright © 2017 Sakura. All rights reserved.
//

import Foundation

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
