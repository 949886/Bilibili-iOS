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
    var year : Int { return Date.calendar.component(.year, from: self) }
    var month : Int { return Date.calendar.component(.month, from: self) }
    var day : Int { return Date.calendar.component(.day, from: self) }
    var weekday : Int { return Date.calendar.component(.weekday, from: self) }
    var hour : Int { return Date.calendar.component(.hour, from: self) }
    var minute : Int { return Date.calendar.component(.minute, from: self) }
    var second : Int { return Date.calendar.component(.second, from: self) }
    var millisecond : Int { return Date.calendar.component(.nanosecond, from: self) / 1000000 }
    var microsecond : Int { return Date.calendar.component(.nanosecond, from: self) / 1000 }
    var nanosecond : Int { return Date.calendar.component(.nanosecond, from: self) }
    var dayOfYear : Int { return _dayOfYear() }
    var weekOfMonth : Int { return Date.calendar.component(.weekOfMonth, from: self) }
    var weekOfYear : Int { return Date.calendar.component(.weekOfYear, from: self) }
    var quarter : Int { return Date.calendar.component(.quarter, from: self) }
    
    //Total days of current month (gregorian).
    var daysOfCurrentMonth : Int { return Date.calendar.range(of: .day, in:.month, for: self)!.upperBound }
    
    
    // MARK: - Public
    
    private func isLeapYear() -> Bool
    {
        return (year % 4) != 0 && (year % 400) != 0
    }
    
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
    static let SEC_PER_MIN = 60.0
    static let SEC_PER_HOUR = 3600.0
    static let SEC_PER_DAY = 86400.0
    static let SEC_PER_WEEK = 604800.0
    
    static var calendar = Calendar.current
    
    // MARK: - Public
    
    static func parse(date : String, format: String) -> Date?
    {
        return Date.parse(date: date, format: format, locale: "en_US")
    }
    
    static func parse(date : String, format: String, locale: String) -> Date?
    {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: locale)
        let parsedDate = formatter.date(from: date)
        return parsedDate
    }
    
    static func format(date : Date, format: String) -> String
    {
        return Date.format(date: date, format: format, locale: "en_US")
    }
    
    static func format(date : Date, format: String, locale: String) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: locale)
        return formatter.string(from: date)
    }
}
