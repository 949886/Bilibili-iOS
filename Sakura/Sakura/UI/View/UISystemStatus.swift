//
//  UISystemStatus.swift
//  Sakura
//
//  Created by YaeSakura on 2017/2/6.
//  Copyright © 2017 YaeSakura. All rights reserved.
//

import UIKit

open class UISystemStatus: UIView
{

    var fpsLabel: UILabel!
    var displayLink: CADisplayLink!
    
    private var lastTime: TimeInterval = 0.0
    private var frameCount: Double = 0
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    deinit {
        displayLink.invalidate()
    }
    
    private func initialize() {
        self.backgroundColor = UIColor(white: 0, alpha: 0.7)
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        
        fpsLabel = UILabel(frame: self.bounds)
        fpsLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        fpsLabel.font = UIFont(name: "Menlo", size: 14) ?? UIFont(name: "Courier", size: 14)
        fpsLabel.textAlignment = .center
        self.addSubview(fpsLabel)
        
        displayLink = CADisplayLink(target: self, selector: #selector(displayLinkCallback(_:)))
        displayLink.add(to: RunLoop.main, forMode: .common)
        
        self.sizeToFit()
    }
    
    //MARK: Override

    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: 55, height: 20)
    }
    
    //MARK: Private
    
    private func fpsAttributedString(fps: Int) -> NSAttributedString {
        let fpsString = "\(fps) FPS"
        
        let fpsColor = UIColor(hue: CGFloat(0.27 * (Double(fps) / 60 - 0.2)), saturation: 1.0, brightness: 0.9, alpha: 1)
        
        let aString = NSMutableAttributedString(string: fpsString)
        aString.setAttributes([.foregroundColor : fpsColor], range: NSRange(location: 0, length: fps.digit))
        aString.setAttributes([.foregroundColor : UIColor.white], range: NSRange(location: fps.digit + 1, length: 3))
        aString.setAttributes([.font : UIFont.systemFont(ofSize: 4)], range: NSRange(location: fps.digit, length: 1))
        return aString
    }
    
    //MARK: Callback
    
    @objc func displayLinkCallback(_ link: CADisplayLink)  {
        if lastTime == 0 {
            lastTime = displayLink.timestamp
            return
        }
        
        frameCount += 1
        
        let deltaTime = link.timestamp - lastTime
        if deltaTime < 1 { return }
        
        let fps = frameCount / deltaTime
        self.fpsLabel.attributedText = fpsAttributedString(fps: Int(round(fps)))
        
        lastTime = link.timestamp
        frameCount = 0
    }
}
