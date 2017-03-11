//
//  UIButtonExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2016/12/6.
//  Copyright © 2016 Sakura. All rights reserved.
//

import Foundation

// MARK: - Stored Property

public extension UIButton
{
    struct AssociatedKey {
        static var textLayout: Void?
        static var textLayoutSpacing: Void?
        static var isTextLayoutNeeded: Void?
    }
    
    
    /// The position of button's textLabel relative to button's imageView, change this value to set textLabel's position.
    /// You can set it to top, bottom, left or right, then the textLabel will show in corresponding position relative to imageView.
    public var textLayout: TextLayout {
        get { return _getTextLayout() }
        set { _setTextLayout(textLayout: newValue) }
    }
    
    public var textLayoutSpacing: Double {
        get { return _getTextLayoutSpacing() }
        set { _setTextLayoutSpacing(spacing: newValue) }
    }
    
    public var isTextLayoutNeeded: Bool {
        get { return _isTextLayoutNeeded() }
        set { _setIsTextLayoutNeeded(boolean: newValue) }
    }
}

// MARK: - Enumeration

extension UIButton {
    public enum TextLayout : Int {
        case top
        case bottom
        case left
        case right
    }
}

// MARK: - Common

extension UIButton {
    
    
}


// MARK: - INTERNAL

extension UIButton {
    
    func _getTextLayout() -> TextLayout {
        return objc_getAssociatedObject(self, &AssociatedKey.textLayout) as? TextLayout ?? .right
    }
    
    func _setTextLayout(textLayout: TextLayout) {
        objc_setAssociatedObject(self, &AssociatedKey.textLayout, textLayout, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        _needLayoutText()
    }
    
    func _getTextLayoutSpacing() -> Double {
        return objc_getAssociatedObject(self, &AssociatedKey.textLayoutSpacing) as? Double ?? 0
    }
    
    func _setTextLayoutSpacing(spacing: Double) {
        objc_setAssociatedObject(self, &AssociatedKey.textLayoutSpacing, spacing, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        _needLayoutText()
    }
    
    
    /// Ensure that layout text only once whenever set textLayout or textLayoutSpacing property any times in a once runloop.
    func _needLayoutText() {
        
        if self.isTextLayoutNeeded { return }
        
        self.isTextLayoutNeeded = true
        DispatchQueue.main.async {
            [weak self] in
            self?._layoutText()
            self?.isTextLayoutNeeded = false
        }
    }
    
    /// Layout textLabel & imageView according to textLayout or textLayoutSpacing property.
    func _layoutText() {
        if let imageView = self.imageView {
            
            // 1. 得到imageView和titleLabel的宽、高
            var imageWith: CGFloat = imageView.frame.size.width
            var imageHeight: CGFloat = imageView.frame.size.height
            var labelWidth: CGFloat = 0.0
            var labelHeight: CGFloat = 0.0
            if #available(iOS 8.0, *) {
                // 由于iOS8中titleLabel的size为0，用下面的这种设置
                labelWidth = self.titleLabel?.intrinsicContentSize.width ?? 0
                labelHeight = self.titleLabel?.intrinsicContentSize.height ?? 0
            } else {
                labelWidth = self.titleLabel?.frame.size.width ?? 0
                labelHeight = self.titleLabel?.frame.size.height ?? 0
            }
            
            // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
            var imageEdgeInsets: UIEdgeInsets = .zero
            var labelEdgeInsets: UIEdgeInsets = .zero
            
            // 3. 根据style和_spacing得到imageEdgeInsets和labelEdgeInsets的值
            let spacing = CGFloat(self.textLayoutSpacing)
            switch textLayout {
            case .top:
                imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight - spacing / 2.0, -labelWidth)
                labelEdgeInsets = UIEdgeInsetsMake(-imageHeight - spacing / 2.0, -imageWith, 0, 0)
            case .bottom:
                imageEdgeInsets = UIEdgeInsetsMake(-labelHeight - spacing / 2.0, 0, 0, -labelWidth)
                labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight - spacing / 2.0, 0)
            case .left:
                imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing / 2.0, 0, -labelWidth - spacing / 2.0)
                labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith - spacing / 2.0, 0, imageWith + spacing / 2.0)
            case .right:
                imageEdgeInsets = UIEdgeInsetsMake(0, -spacing / 2.0, 0, spacing / 2.0)
                labelEdgeInsets = UIEdgeInsetsMake(0, spacing / 2.0, 0, -spacing / 2.0)
            }
            
            self.titleEdgeInsets = labelEdgeInsets
            self.imageEdgeInsets = imageEdgeInsets
        }
    }
    
    func _isTextLayoutNeeded() -> Bool {
        return objc_getAssociatedObject(self, &AssociatedKey.isTextLayoutNeeded) as? Bool ?? false
    }
    
    func _setIsTextLayoutNeeded(boolean: Bool) {
        objc_setAssociatedObject(self, &AssociatedKey.isTextLayoutNeeded, boolean, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
}

