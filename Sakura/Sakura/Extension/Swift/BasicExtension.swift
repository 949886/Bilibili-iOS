//
//  BasicExtension.swift
//  Swifty
//
//  Created by YaeSakura on 16/5/12.
//  Copyright © 2016 Sakura. All rights reserved.
//

import Foundation

extension Integer {
    
    var digit: Int {
        var num = self, digit = 0
        while num > 0 {
            num /= 10
            digit += 1
        }
        return digit
    }
    
}
