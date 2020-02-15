//
//  UITabs.swift
//  Sakura
//
//  Created by YaeSakura on 2017/1/5.
//  Copyright © 2017 YaeSakura. All rights reserved.
//

import Foundation

@IBDesignable
open class UITabs: UIView
{
    @IBInspectable public var index: Int = 0
    @IBInspectable public var startIndex: Int = 0
    
    @IBInspectable public var font: UIFont?
    @IBInspectable public var selectedFont: UIFont?
    @IBInspectable public var textColor: UIColor?
    @IBInspectable public var selectedTextColor: UIColor?
    
    @IBInspectable public var isTranslucent: Bool = false
    
    var accessory: UIView?
    var accessoryInsets: UIEdgeInsets?
    
    public let scrollView = UIScrollView()
    public let backgroundView = UIView()
}
