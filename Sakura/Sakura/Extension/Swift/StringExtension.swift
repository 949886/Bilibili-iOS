//
//  StringExtension.swift
//  Swifty
//
//  Created by YaeSakura on 16/5/9.
//  Copyright © 2016 Sakura. All rights reserved.
//

import Foundation

//MARK: - Misc

extension String
{
    var nsstring: NSString { return self as NSString }
    var length: Int { return self.characters.count }

    public func subString(from index : Int) -> String {
        let index = self.index(self.startIndex, offsetBy: String.IndexDistance(index))
        return self.substring(from: index)
    }
    
    public func subString(to index : Int) -> String {
        let index = self.index(self.startIndex, offsetBy: String.IndexDistance(index))
        return self.substring(to: index)
    }
    
    public func substring(start: String?, end: String?) -> String?
    {
        if nil != start && !self.contains(start!) { return nil }
        if nil != end && !self.contains(end!) { return nil }
        
        var result : NSString? = nil
        let scanner = Scanner(string: self)
        if nil != start {
            scanner.scanUpTo(start!, into: &result)
            scanner.scanString(start!, into: &result)
        }
        scanner.scanUpTo((nil == end) ? "\0" : end!, into: &result)
        
        return result as? String
    }

}

//MARK: - Unicode

extension String
{
    public var unicodeLength: Int {
        var length: Int = 0
        for character in self.utf16 {
            length += self.unicodeCharacterLength(character)
        }
        return length
    }
    
    public func substring(withinUnicodeLength length: Int) -> String {
        var unicodeLength: Int = 0
        var index: Int = 0
        
        for character in self.utf16 {
            unicodeLength += self.unicodeCharacterLength(character)
            if unicodeLength > length { break }
            index += 1
        }
        
        return self.subString(to: index)
    }
    
    private func unicodeCharacterLength(_ uc: unichar) -> Int {
        var length: Int = 0
        
        switch uc {
        case 0x0000...0x0019: length += 0
        case 0x0020...0x1fff: length += 1
        case 0x2000...0xff60: length += 2
        case 0xff61...0xff9f: length += 1
        default: length += 2
        }
        
        return length
    }
}

//MARK: - UI

extension String
{
    //Size calculating
    public func size(limit: CGSize, font : UIFont) -> CGRect {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 0
        style.alignment = .left
        
        return self.size(limit: limit, font: font, style: style)
    }
    
    public func size(limit: CGSize, font : UIFont, style : NSMutableParagraphStyle) -> CGRect {
        let attribute = [NSFontAttributeName : font, NSParagraphStyleAttributeName : style]
        return self.boundingRect(with: limit, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attribute, context: nil)
    }
}

