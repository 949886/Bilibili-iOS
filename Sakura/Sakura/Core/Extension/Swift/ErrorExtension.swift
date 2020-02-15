//
//  ErrorExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/5/3.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

extension Error
{
    /* NSError */
    
    public var code: Int { return (self as NSError).code }
    public var domain: String { return (self as NSError).domain }
    public var userInfo: [AnyHashable:Any] { return (self as NSError).userInfo }
    public var localizedDescription: String { return (self as NSError).localizedDescription }
}
