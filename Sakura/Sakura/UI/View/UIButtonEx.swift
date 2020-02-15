//
//  UIButtonEx.swift
//  Sakura
//
//  Created by YaeSakura on 2017/5/17.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import UIKit

open class UIButtonEx: UIButton
{
    
    //MARK: Properties
    
    public var cornerRadius = (topLeft: 0.0, topRight: 0.0, bottomRight: 0.0, bottomLeft: 0.0) { didSet { setNeedsDisplay() } }
    
    private var isTouchInsidePre: Bool = false
    
    private var borderColorMapper = [UInt:UIColor]()
    private var shadowColorMapper = [UInt:UIColor]()
    
    
    //MARK: Override
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let topLeftRadius: CGFloat = CGFloat(cornerRadius.topLeft)
        let topRightRadius: CGFloat = CGFloat(cornerRadius.topRight)
        let bottomRightRadius: CGFloat = CGFloat(cornerRadius.bottomRight)
        let bottomLeftRadius: CGFloat = CGFloat(cornerRadius.bottomLeft)
        if  topLeftRadius == 0 &&
            topRightRadius == 0 &&
            bottomRightRadius == 0 &&
            bottomLeftRadius == 0 {
            return
        }
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.minX + topLeftRadius, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX - topRightRadius, y: bounds.minY))
        path.addArc(withCenter: CGPoint(x: bounds.maxX - topRightRadius, y: bounds.minY + topRightRadius), radius: topRightRadius, startAngle: 3 * .pi / 2, endAngle: 0, clockwise: true)
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY - bottomRightRadius))
        path.addArc(withCenter: CGPoint(x: bounds.maxX - bottomRightRadius, y: bounds.maxY - bottomRightRadius), radius: bottomRightRadius, startAngle: 0, endAngle: .pi / 2, clockwise: true)
        path.addLine(to: CGPoint(x: bounds.minX + bottomLeftRadius, y: bounds.maxY))
        path.addArc(withCenter: CGPoint(x: bounds.minX + bottomLeftRadius, y: bounds.maxY - bottomLeftRadius), radius: bottomLeftRadius, startAngle: .pi / 2, endAngle: .pi, clockwise: true)
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.minY + topLeftRadius))
        path.addArc(withCenter: CGPoint(x: bounds.minX + topLeftRadius, y: bounds.minY + topLeftRadius), radius: topLeftRadius, startAngle: .pi, endAngle: 3 * .pi / 2, clockwise: true)
        path.close()
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        checkControlState()
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        checkControlState()
        isTouchInsidePre = true
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if let isTouchInside = touches.first?.isTouchInside {
            if isTouchInside != isTouchInsidePre {
                checkControlState()
            }
            isTouchInsidePre = isTouchInside
        }
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        checkControlState()
        isTouchInsidePre = false
    }
    
    //MARK: Methods
    
    public func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
        if color != nil {
            self.setBackgroundImage(UIImage(color: color!), for: state)
        } else {
            self.setBackgroundImage(UIImage(), for: state)
        }
    }
    
    public func setBorderColor(_ color: UIColor?, for state: UIControl.State) {
        if self.layer.borderWidth == 0 {
            self.layer.borderWidth = 1
        }
        borderColorMapper[state.rawValue] = color ?? UIColor.clear
    }
    
    public func setShadowColor(_ color: UIColor?, for state: UIControl.State) {
        if self.layer.shadowOpacity == 0 {
            self.layer.shadowOpacity = 1
        }
        shadowColorMapper[state.rawValue] = color ?? UIColor.clear
    }
    
    //MARK: Private
    
    private func checkControlState() {
        
        if let backgroundView = self.value(forKey: "_backgroundView") as? UIImageView {
            if backgroundView.layer.cornerRadius != self.layer.cornerRadius {
                backgroundView.layer.cornerRadius = self.layer.cornerRadius
            }
        }
        
        // Check extra properties.
        if let borderColor = borderColorMapper[self.state.rawValue] {
            self.layer.borderColor = borderColor.cgColor
        }
        if let shadowColor = shadowColorMapper[self.state.rawValue] {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    
}
