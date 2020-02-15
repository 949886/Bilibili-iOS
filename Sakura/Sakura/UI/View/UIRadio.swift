//
//  UIRadio.swift
//  Sakura
//
//  Created by YaeSakura on 2017/1/15.
//  Copyright © 2017 YaeSakura. All rights reserved.
//

import Foundation

open class UIRadio: UIView
{
    @IBInspectable public var defaultSelection: Int = 0
    @IBInspectable public var multipleSelection: Bool = false
    
    @IBInspectable weak public var delegate: UIRadioDelegate?
    
    private var buttons: [UIRadioButton] = []
    
    public var selectedIndexes: [Int] {
        var indexes = [Int]()
        for (index, button) in buttons.enumerated() {
            if button.isSelected {
                indexes.append(index)
            }
        }
        return indexes
    }
    
    open override func addSubview(_ view: UIView) {
        super.addSubview(view)
        if view is UIRadioButton {
            let button = view as! UIRadioButton
            buttons.append(button)
            button.addTarget(self, action: #selector(onClickRadioButton(sender:)), for: .touchUpInside)
        }
    }
    
    public func button(at index: Int) -> UIRadioButton? {
        if index < buttons.count {
            return buttons[index]
        }
        return nil
    }
    
    @objc private func onClickRadioButton(sender: UIRadioButton) {
        if !multipleSelection {
            for button in buttons {
                if button === sender { button.isSelected = true }
                else { button.isSelected = false }
            }
        } else {
            sender.isSelected = !sender.isSelected
            if sender.isSelected == false {
                delegate?.radioView?(self, didDeselectItemAt: buttons.index(of: sender)!)
            }
        }
        
        delegate?.radioView?(self, didSelectItemAt: buttons.index(of: sender)!)
    }
    
    
    public subscript(index: Int) -> UIRadioButton? {
        return self.button(at: index)
    }
    
}

open class UIRadioButton: UIButtonEx
{
    var group: UIRadio?
    
    open override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview is UIRadio {
            group = newSuperview as? UIRadio
        } else { group = nil }
    }
    
}

@objc public protocol UIRadioDelegate
{
    @objc optional func radioView(_ radioView: UIRadio, didSelectItemAt index: Int)
    @objc optional func radioView(_ radioView: UIRadio, didDeselectItemAt index: Int)
}

