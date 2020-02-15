//
//  CharacterExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/12/21.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

extension Character
{
    public var isEmoji: Bool {
        return self.unicodeScalars.first?.isEmoji ?? false
    }
}
