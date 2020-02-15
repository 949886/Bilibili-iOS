//
//  UIRatingBar.swift
//  Sakura
//
//  Created by YaeSakura on 2017/1/15.
//  Copyright © 2017 YaeSakura. All rights reserved.
//

import Foundation

@IBDesignable
open class UIRatingBar: UIView {
    
    @IBInspectable public var rating: CGFloat = 0  { didSet { setNeedsDisplay() } }
    @IBInspectable public var minimum: CGFloat = 0 { didSet { setNeedsDisplay() } }
    @IBInspectable public var maximum: CGFloat = 5 { didSet { setNeedsDisplay() } }
    @IBInspectable public var stepSize: CGFloat = 0 { didSet { setNeedsDisplay() } }
    @IBInspectable public var spacing: CGFloat = 5 { didSet { setNeedsDisplay() } }
    @IBInspectable public var emptyImage: UIImage? { didSet { setNeedsDisplay() } }
    @IBInspectable public var filledImage: UIImage? { didSet { setNeedsDisplay() } }
    
}

