//
//  UIToggle.swift
//  Sakura
//
//  Created by YaeSakura on 2017/1/15.
//  Copyright © 2017 YaeSakura. All rights reserved.
//

import Foundation

open class UIToggle : UIButtonEx
{
    init() {
        super.init(frame: .zero)
        self.initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    private func initialize() {
        self.addTarget(self, action: #selector(_onClick(sender:)), for: .touchUpInside)
    }
    
    @objc private func _onClick(sender: UIRadioButton) {
        self.isSelected = !self.isSelected
    }
    
}
