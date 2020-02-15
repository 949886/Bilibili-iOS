//
//  UIBanner.swift
//  Sakura
//
//  Created by YaeSakura on 2017/1/15.
//  Copyright © 2017 YaeSakura. All rights reserved.
//

import Foundation

open class UIBanner : UIView
{
    
    var scrollInterval: Double = 2.5
    var scrollAutomatically: Bool = true
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    private func initialize() {
        
    }
    
    //MARK: Override
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    open override func willMove(toSuperview newSuperview: UIView?) {
        
    }
    
    open override func willRemoveSubview(_ subview: UIView) {
        
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return self
    }
    
    
    //MARK: - Inner Class
    
    public class Cell: UIView
    {
        
        let imageView = UIImageView()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.initialize()
        }
        
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            self.initialize()
        }
        
        private func initialize() {
            imageView.frame = self.bounds
            imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.addSubview(imageView)
        }
        
    }
    
    public class ScrollView: UIScrollView
    {
        
        public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            var view: UIView = self
            for subview in subviews {
                let p = subview.convert(point, from: self)
                if subview.bounds.contains(p) {
                    view = subview
                }
            }
            return view
        }
        
    }
}
