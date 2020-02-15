//
//  DateExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2016/11/22.
//  Copyright © 2016 Sakura. All rights reserved.
//

import Foundation

// MARK: - Common

extension Date
{
    //Date components.
    public var era : Int { return Date.calendar.component(.era, from: self) }
    public var year : Int { return Date.calendar.component(.year, from: self) }
    public var month : Int { return Date.calendar.component(.month, from: self) }
    public var day : Int { return Date.calendar.component(.day, from: self) }
    public var weekday : Int { return Date.calendar.component(.weekday, from: self) }
    public var hour : Int { return Date.calendar.component(.hour, from: self) }
    public var minute : Int { return Date.calendar.component(.minute, from: self) }
    public var second : Int { return Date.calendar.component(.second, from: self) }
    public var millisecond : Int { return Date.calendar.component(.nanosecond, from: self) / 1000000 }
    public var microsecond : Int { return Date.calendar.component(.nanosecond, from: self) / 1000 }
    public var nanosecond : Int { return Date.calendar.component(.nanosecond, from: self) }
    public var dayOfYear : Int { return _dayOfYear() }
    public var weekOfMonth : Int { return Date.calendar.component(.weekOfMonth, from: self) }
    public var weekOfYear : Int { return Date.calendar.component(.weekOfYear, from: self) }
    public var quarter : Int { return Date.calendar.component(.quarter, from: self) }
    
    //Total days of current month (gregorian).
    public var daysOfCurrentMonth: Int { return Date.calendar.range(of: .day, in:.month, for: self)!.upperBound }
    
    //Timestamp
    public var timestamp: Int64 { return Int64(Date().timeIntervalSince1970) }
    
    // MARK: - Public
    
    public func isLeapYear() -> Bool { return (year % 4) != 0 && (year % 400) != 0 }
    public func isLeapMonth() -> Bool { return Date.calendar.dateComponents([.month], from: self).isLeapMonth ?? false }
    public func isToday() -> Bool { return year == Date().year && month == Date().month && day == Date().day }
    public func isPast() -> Bool { return self.compare(Date()) == .orderedAscending }
    public func isFuture() -> Bool { return self.compare(Date()) == .orderedDescending }
    
//    func zeroOclock() -> Date {
//        let date = self + 10000
//        return Date()
//    }
    
    // MARK: - Private
    
    private func _dayOfYear() -> Int {
        var total = 0
        switch month - 1
        {
        case 12: total += 31; fallthrough
        case 11: total += 30; fallthrough
        case 10: total += 31; fallthrough
        case 9: total += 30; fallthrough
        case 8: total += 31; fallthrough
        case 7: total += 31; fallthrough
        case 6: total += 30; fallthrough
        case 5: total += 31; fallthrough
        case 4: total += 30; fallthrough
        case 3: total += 31; fallthrough
        case 2: total += self.isLeapYear() ? 29 : 28; fallthrough
        case 1: total += 31
        default: break
        }
        total += day
        return total
    }

}


// MARK: - Static


extension Date
{
    public static let SEC_PER_MIN = 60.0
    public static let SEC_PER_HOUR = 3600.0
    public static let SEC_PER_DAY = 86400.0
    public static let SEC_PER_WEEK = 604800.0
    
    public static var calendar = Calendar.current
    
    // MARK: - Formatter
    
    //About format you can refer to:
    //http://userguide.icu-project.org/formatparse/datetime
    
    public static func parse(date: String, format: String) -> Date?
    {
        return Date.parse(date: date, format: format, locale: "en_US")
    }
    
    public static func parse(date: String, format: String, locale: String) -> Date?
    {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: locale)
        let parsedDate = formatter.date(from: date)
        return parsedDate
    }
    
    public static func format(date: Date, format: String) -> String
    {
        return Date.format(date: date, format: format, locale: "en_US")
    }
    
    public static func format(date: Date, format: String, locale: String) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: locale)
        return formatter.string(from: date)
    }
}
