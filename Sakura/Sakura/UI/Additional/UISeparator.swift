//
//  UISeparator.swift
//  Sakura
//
//  Created by YaeSakura on 2017/1/5.
//  Copyright © 2017 Sakura. All rights reserved.
//

import Foundation

@IBDesignable
open class UISeparator: UIView {
    
    public var pattern: [CGFloat] = [4, 4]  { didSet { setNeedsDisplay() } }
    
    @IBInspectable public var color: UIColor?  { didSet { setNeedsDisplay() } }
    @IBInspectable public var parse: CGFloat = 0 { didSet { setNeedsDisplay() } }
    @IBInspectable public var patternString: String = "" { didSet { setNeedsDisplay() } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.isOpaque = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
        self.isOpaque = false
    }

    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.drawDashLine()
    }
    
    private func drawDashLine() {
        let width = self.bounds.size.width
        let height = self.bounds.size.height
        let isHorizontal = width >= height
        
        if !patternString.isEmpty {
            setPatternString(patternString)
        }
        
        if let context = UIGraphicsGetCurrentContext() {
            context.move(to: CGPoint(x: isHorizontal ? 0 : width * 0.5 , y: isHorizontal ? height * 0.5 : 0))
            context.addLine(to: CGPoint(x: isHorizontal ? width : width * 0.5, y: isHorizontal ? height * 0.5 : height))
            context.setLineDash(phase: parse, lengths: pattern)
            context.setLineWidth(isHorizontal ? height : width)
            context.setStrokeColor(color?.cgColor ?? UIColor.gray.cgColor)
            context.drawPath(using: .stroke)
        }
    }
    
    private func setPatternString(_ string: String) {
        if string.isEmpty { return }
        
        var splits = (string as NSString).components(separatedBy: " ")
        if splits.isEmpty { splits = (string as NSString).components(separatedBy: ",") }
        
        var pattern = [CGFloat]()
        for string in splits {
            if let double = Double(string){
                pattern.append(CGFloat(double))
            }
        }
        self.pattern = pattern
    }
    
}
