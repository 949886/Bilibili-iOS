//
//  UnicodeScalarExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/12/21.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

extension UnicodeScalar
{
    
    /// Is character a emoji.
    /// From: https://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
    public var isEmoji: Bool {
        switch value {
        case 0x1F600...0x1F64F, // Emoticons
        0x1F300...0x1F5FF,      // Misc Symbols and Pictographs
        0x1F680...0x1F6FF,      // Transport and Map
        0x1F1E6...0x1F1FF,      // Regional country flags
        0x2600...0x26FF,        // Misc symbols
        0x2700...0x27BF,        // Dingbats
        0xFE00...0xFE0F,        // Variation Selectors
        0x1F900...0x1F9FF,      // Supplemental Symbols and Pictographs
        65024...65039,          // Variation selector
        8400...8447:            // Combining Diacritical Marks for Symbols
            return true
            
        default: return false
        }
    }
    
    /// If the character is zero-width joiner.
    /// From: https://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
    public var isZeroWidthJoiner: Bool {
        return value == 8205
    }
    
}
