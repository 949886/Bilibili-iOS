//
//  UITextFieldExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/1/14.
//  Copyright © 2017 Sakura. All rights reserved.
//

import Foundation

// MARK: - Stored Property

public extension UITextField {
    
    public var placeholderColor: UIColor {
        get { return _getPlaceholderColor() }
        set { _setPlaceholderColor(color: newValue) }
    }
    
}

// MARK: - Private

extension UITextField {
    
    struct AssociatedKey {
        static var placeholderColor: Void?
    }
    
    func _getPlaceholderColor() -> UIColor {
        return objc_getAssociatedObject(self, &AssociatedKey.placeholderColor) as? UIColor ?? UIColor.clear
    }
    
    func _setPlaceholderColor(color: UIColor) {
        objc_setAssociatedObject(self, &AssociatedKey.placeholderColor, color, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        if let placeholder = self.placeholder {
            let attributes = [NSForegroundColorAttributeName : color]
            self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        }
    }
    
}


// MARK: - Common

extension UITextField {
    
}

