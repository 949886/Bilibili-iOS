//
//  StringExtension.swift
//  Swifty
//
//  Created by YaeSakura on 16/5/9.
//  Copyright © 2016 Sakura. All rights reserved.
//

import Foundation

//MARK: - Common

extension String
{

    /// Convert string to Int or nil.
    public var int: Int? {
        return Int(self)
    }
    
    /// Convert string to Int8 or nil.
    public var int8: Int8? {
        return Int8(self)
    }
    
    /// Convert string to Int16 or nil.
    public var int16: Int16? {
        return Int16(self)
    }
    
    /// Convert string to Int32 or nil.
    public var int32: Int32? {
        return Int32(self)
    }
    
    /// Convert string to Int64 or nil.
    public var int64: Int64? {
        return Int64(self)
    }
    
    /// Convert string to Float or nil.
    public var float: Float? {
        return Float(self)
    }
    
    /// Convert string to Double or nil.
    public var double: Double? {
        return Double(self)
    }
    
    /// Convert string to CGFloat or nil.
    public var cgfloat: CGFloat? {
        if let number = self.double {
            return CGFloat(number)
        }
        return nil
    }
    
    /// Substring from a certain index to the end of string.
    ///
    /// - Parameter index: Upper bound.
    /// - Returns: Substring.
    public func subString(from: Int) -> String {
        var from = from
        if from < 0 { from = 0 }
        if from > self.length { from = self.length }
        let index = self.index(self.startIndex, offsetBy: String.IndexDistance(from))
        return self.substring(from: index)
    }
    
    /// Substring from start of string to a certain index.
    ///
    /// - Parameter to: Lower bound.
    /// - Returns: Substring.
    public func subString(to: Int) -> String {
        var to = to
        if to < 0 { to = 0 }
        if to > self.length { to = self.length }
        let index = self.index(self.startIndex, offsetBy: String.IndexDistance(to))
        return self.substring(to: index)
    }
    
    /// Substring from a certain index to the another index.
    ///
    /// - Parameters:
    ///   - from: Upper bound.
    ///   - to: Lower bound.
    /// - Returns: Substring (if from > to) will return empty string.
    public func subString(from: Int, to: Int) -> String {
        let string = self.subString(from: from)
        return string.subString(to: to - from + 1)
    }
    
    
    /// Get substring with a range.
    ///
    /// - Parameter range: Substring range.
    public subscript(range: Range<Int>) -> String {
        return self.subString(from: range.lowerBound, to: range.upperBound - 1)
    }
    
    /// Get substring with a closed range.
    ///
    /// - Parameter range: Closed substring range.
    public subscript(range: ClosedRange<Int>) -> String {
        return self.subString(from: range.lowerBound, to: range.upperBound)
    }
    
    /// Substring between start and end(excluding start & end).
    ///
    /// - Parameters:
    ///   - start: Truncate string from start. If start is nil, substring will start from the head of string.
    ///   - end: Truncate string to end. If end is nil, substring will end to the tail of string.
    /// - Returns: Substring between start and end(excluding start & end). If the string not contains start or end, return nil.
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
        
        return result as String?
    }
    
    /// Replace all space characters to non-breaking space characters.
    public func nonBreakingSpaceString() -> String {
        return replacingOccurrences(of: " ", with: "\u{00a0}")
    }
    
    /// Split string with a character.
    ///
    /// - Parameter string: Separator.
    /// - Returns: All string splited by inputed string.
    public func split(_ char: CharacterSet) -> [String] {
        return self.components(separatedBy: char)
    }
    
    /// Split string with a string.
    ///
    /// - Parameter string: Separator.
    /// - Returns: All string splited by inputed string.
    public func split(_ string: String) -> [String] {
        return self.components(separatedBy: string)
    }
    
    /// Reverse current string.
    public mutating func reverse() {
        self = reversedString()
    }
    
    /// Get reversed string of current string.
    public func reversedString() -> String {
        return String(reversed())
    }
    
    /// Convenient method of trimmingCharacters.
    public mutating func trim() {
        self = trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// Convenient method of trimmingCharacters.
    public func trimmed() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// Convenient method of removingPercentEncoding.
    public mutating func urlDecode() {
        self = urlDecoded()
    }
    
    /// Convenient method of removingPercentEncoding.
    public func urlDecoded() -> String {
        return removingPercentEncoding ?? self
    }
    
    /// Convenient method of addingPercentEncoding.
    public mutating func urlEncode() {
        self = urlEncoded()
    }
    
    /// Convenient method of addingPercentEncoding.
    public func urlEncoded() -> String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    /// Convert string to base64 encoded string.
    public mutating func base64Encode() {
        self = base64Encoded()
    }
    
    /// Get base64 encoded string of current string.
    public func base64Encoded() -> String {
        return self.data(using: .utf8)!.base64EncodedString()
    }
    
     /// Convert base64 encoded string to normal string.
    public mutating func base64Decode() {
        self = base64Decoded()
    }
    
    /// Get normal string from base64 encoded string.
    public func base64Decoded() -> String {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8) ?? ""
        }
        return ""
    }
    
    /// Check if string matches the regex pattern.
    ///
    /// - Parameter pattern: Regex pattern.
    /// - Returns: true if string matches the pattern.
    public func matches(pattern: String) -> Bool {
        return range(of: pattern, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    public var isURL: Bool {
        return matches(pattern: "[a-zA-z]+://[^\\s]*")
    }
    
    public var isEmail: Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: self)
    }
    
}

//MARK: - Unicode

extension String
{
    /**
     Like PHP function mb_strwidth().
     Caculate length of string including unicode characters. Algorithm:
     U+0000 - U+0019	0   0
     U+0020 - U+1FFF	1   1
     U+2000 - U+FF60	2   2
     U+FF61 - U+FF9F	1   1
     U+FFA0 - ???       2
     */
    public var unicodeLength: Int {
        var length: Int = 0
        for character in self.utf16 {
            length += self.unicodeCharacterLength(character)
        }
        return length
    }

    /// Substring which unicode length not exceed specific length.
    ///
    /// - Parameter length: length specific length.
    /// - Returns: Truncated string.
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
    
    /* Normalization */
    
    /// Change normalization form.
    public mutating func normalize(to form: CFStringNormalizationForm) {
        let mString = (self as NSString).mutableCopy() as! NSMutableString
        CFStringNormalize(mString, form)
        self = mString as String
    }
    
    /// Get string of specific normalization form.
    public func normalized(to form: CFStringNormalizationForm) -> String {
        let mString = (self as NSString).mutableCopy() as! NSMutableString
        CFStringNormalize(mString, form)
        return mString as String
    }
    
}

//MARK: - Emoji
//From: https://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji

extension String
{
    /// "🐸🐸🐸".glyphCount is 3
    /// "🐸🐸🐸".count is 8
    public var glyphCount: Int {
        let richText = NSAttributedString(string: self)
        let line = CTLineCreateWithAttributedString(richText)
        return CTLineGetGlyphCount(line)
    }
    
    // If string contains any emoji return true.
    public var hasEmoji: Bool {
        return unicodeScalars.contains {
            $0.isEmoji
        }
    }
    
    // If string only have emoji.
    public var isAllEmoji: Bool {
        return !isEmpty
            && !unicodeScalars.contains(where: {
                !$0.isEmoji && !$0.isZeroWidthJoiner
            })
    }
    
    /// Get string that is consisted of all emojis in current string.
    var emojiString: String {
        return emojiScalars.map { String($0) }.reduce("", +)
    }
    
    /// Get all emojis in current string.
    var emojis: [String] {
        var scalars: [[UnicodeScalar]] = []
        var currentScalarSet: [UnicodeScalar] = []
        var previousScalar: UnicodeScalar?
        
        for scalar in emojiScalars {
            if let prev = previousScalar, !prev.isZeroWidthJoiner && !scalar.isZeroWidthJoiner {
                scalars.append(currentScalarSet)
                currentScalarSet = []
            }
            currentScalarSet.append(scalar)
            previousScalar = scalar
        }
        scalars.append(currentScalarSet)
        
        return scalars.map { $0.map{ String($0) } .reduce("", +) }
    }
    
    fileprivate var emojiScalars: [UnicodeScalar] {
        var chars: [UnicodeScalar] = []
        var previous: UnicodeScalar?
        for cur in unicodeScalars {
            if let previous = previous, previous.isZeroWidthJoiner && cur.isEmoji {
                chars.append(previous)
                chars.append(cur)
            } else if cur.isEmoji {
                chars.append(cur)
            }
            previous = cur
        }
        return chars
    }
}

//MARK: - Encoding

extension String
{
    /// Convert String to NSString.
    public var nsstring: NSString {
        return self as NSString
    }
    
    /// Convert String to C String pointer.
    public var cstring: UnsafePointer<CChar>? {
        return (self as NSString).utf8String
    }
    
    /// Totoal character count of string.
    public var length: Int {
        #if swift(>=4)
            return self.count
        #else
            return self.characters.count
        #endif
    }
}


//MARK: - UI

#if os(iOS)
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
            let attribute = [NSAttributedString.Key.font : font, NSAttributedString.Key.paragraphStyle : style]
            return self.boundingRect(with: limit, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attribute, context: nil)
        }
    }
#endif
