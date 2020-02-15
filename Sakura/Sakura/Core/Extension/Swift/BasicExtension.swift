//
//  BasicExtension.swift
//  Swifty
//
//  Created by YaeSakura on 16/5/12.
//  Copyright © 2016 Sakura. All rights reserved.
//

import Foundation

// MARK: - Integer

#if swift(>=4)
    
extension BinaryInteger
{
    
    /// Cast Integer to CGFloat.
    public var f: CGFloat {
        switch self {
        case is Int:    return CGFloat(self as! Int)
        case is Int8:   return CGFloat(self as! Int8)
        case is Int16:  return CGFloat(self as! Int16)
        case is Int32:  return CGFloat(self as! Int32)
        case is Int64:  return CGFloat(self as! Int64)
        case is UInt:   return CGFloat(self as! UInt)
        case is UInt8:  return CGFloat(self as! UInt8)
        case is UInt16: return CGFloat(self as! UInt16)
        case is UInt32: return CGFloat(self as! UInt32)
        case is UInt64: return CGFloat(self as! UInt64)
        default:        return 0
        }
    }
    
    /// Digits of integer. e.g. 12450 -> 5, 233 -> 3
    public var digit: Int {
        var num = self, digit = 0
        
        if num == 0 {
            return 1
        }
        
        while num > 0 {
            num /= 10
            digit += 1
        }
        
        return digit
    }
    
}
    
#else
    
extension Integer
{
    
    /// Digit of an integer. e.g. 12450 -> 5
    public var digit: Int {
        var num = self, digit = 0
        while num > 0 {
            num /= 10
            digit += 1
        }
        return digit
    }
    
    /// Cast Integer to CGFloat.
    public var f: CGFloat {
        switch self {
        case is Int:    return CGFloat(self as! Int)
        case is Int8:   return CGFloat(self as! Int8)
        case is Int16:  return CGFloat(self as! Int16)
        case is Int32:  return CGFloat(self as! Int32)
        case is Int64:  return CGFloat(self as! Int64)
        case is UInt:   return CGFloat(self as! UInt)
        case is UInt8:  return CGFloat(self as! UInt8)
        case is UInt16: return CGFloat(self as! UInt16)
        case is UInt32: return CGFloat(self as! UInt32)
        case is UInt64: return CGFloat(self as! UInt64)
        default:        return 0
        }
    }
    
}
    
#endif


// MARK: - Float

#if os(OSX)
extension FloatingPoint
{
    /// Cast float value to CGFloat.
    public var f: CGFloat {
        switch self {
        case is Float:      return CGFloat(self as! Float)
        case is Float80:    return CGFloat(self as! Float80)
        case is Double:     return CGFloat(self as! Double)
        default:            return 0
        }
    }
}
#else
extension FloatingPoint
{
    /// Cast Float value to CGFloat.
    public var f: CGFloat {
        switch self {
        case is Float:      return CGFloat(self as! Float)
        case is Double:     return CGFloat(self as! Double)
        default:            return 0
        }
    }
}
#endif

// MARK: - Double

extension Double
{
    /// Cast Double value to CGFloat.
    public var f: CGFloat {
        return CGFloat(self)
    }
}


// MARK: - Boolean

#if swift(>=4)
extension Bool
{
    init?(_ string: String) {
        self.init(exactly: NSNumber(value: Int(string) ?? 0))
    }
}
#else
extension Bool
{
    init?(_ string: String) {
        if let number = Int(string) {
            self.init(NSNumber(value: number))
        } else {
            return nil
        }
    }
}
#endif
