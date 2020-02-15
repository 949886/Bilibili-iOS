//
//  UITextFieldExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/1/14.
//  Copyright © 2017 YaeSakura. All rights reserved.
//

import Foundation

// MARK: - Stored Property

extension UITextField
{
    
    public var selectedText: String? {
        if let range = self.selectedTextRange {
            return self.text(in: range)
        }
        return nil
    }
    
    // Stored Property
    
    public var placeholderColor: UIColor {
        get { return _getPlaceholderColor() }
        set { _setPlaceholderColor(color: newValue) }
    }
    
}

// MARK: - Methods

extension UITextField
{
    
    public func selectAll() {
        self.selectedTextRange = self.textRange(from: self.beginningOfDocument, to: self.endOfDocument)
    }

}

// MARK: - Private

extension UITextField
{
    
    struct AssociatedKey {
        static var placeholderColor: Void?
    }
    
    func _getPlaceholderColor() -> UIColor {
        return objc_getAssociatedObject(self, &AssociatedKey.placeholderColor) as? UIColor ?? UIColor.clear
    }
    
    func _setPlaceholderColor(color: UIColor) {
        objc_setAssociatedObject(self, &AssociatedKey.placeholderColor, color, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        if let placeholder = self.placeholder {
            let attributes = [NSAttributedString.Key.foregroundColor : color]
            self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        }
    }
    
}
