//
//  LocaleExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/7/5.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

extension Locale
{
    /* NSLocale */
    
    var identifier: String { return (self as NSLocale).object(forKey: .identifier) as? String ?? "en-US" }
    var countryCode: String { return (self as NSLocale).object(forKey: .countryCode) as? String ?? "US" }
    var scriptCode: String? { return (self as NSLocale).object(forKey: .scriptCode) as? String }
    var currencyCode: String? { return (self as NSLocale).object(forKey: .currencyCode) as? String }
}
