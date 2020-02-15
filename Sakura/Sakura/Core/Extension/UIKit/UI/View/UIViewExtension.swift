//
//  UIViewExtension.swift
//  SwiftyUI
//
//  Created by YaeSakura on 16/5/5.
//  Copyright © 2016 Sakura. All rights reserved.
//

import UIKit

// MARK: - Stored Property

extension UIView
{
    /// Set extra hit test area.
    /// e.g. (-8, -8, -8, -8) will extend 8 point of hit area of all direction.
    /// e.g. (8, 8, 8, 8) will shrink 8 point of hit area of all direction.
    @objc public var extraHitInsets: UIEdgeInsets {
        get { return getAssociatedObject(key: "extraHitInsets") as? UIEdgeInsets ?? .zero }
        set { UIView.swizzling(); setAssociatedObject(key: "extraHitInsets", value: newValue) }
    }
}

//MARK: - Layout

extension UIView
{
    
    @objc public var x: CGFloat {
        get { return self.frame.origin.x }
        set { self.frame.origin.x = newValue }
    }
    
    @objc public var y: CGFloat {
        get { return self.frame.origin.y }
        set { self.frame.origin.y = newValue }
    }
    
    @objc public var width: CGFloat {
        get { return self.frame.size.width }
        set { self.frame.size.width = newValue }
    }
    
    @objc public var height: CGFloat {
        get { return self.frame.size.height }
        set { self.frame.size.height = newValue }
    }
    
    @objc public var centerX: CGFloat {
        get { return self.frame.origin.x + self.frame.size.width * 0.5 }
        set { self.frame.origin.x = newValue - self.frame.size.width * 0.5 }
    }
    
    @objc public var centerY: CGFloat {
        get { return self.frame.origin.y + self.frame.size.height * 0.5 }
        set { self.frame.origin.y = newValue - self.frame.size.height * 0.5 }
    }

    @objc public var size: CGSize {
        get { return self.frame.size }
        set { self.frame = CGRect(origin: self.frame.origin, size: size) }
    }
    
    /// Get constraint by identifier.
    ///
    /// - Parameter identifier: Constraint identifier
    /// - Returns: A constraint.
    @objc func getConstraint(by identifier: String?) -> NSLayoutConstraint? {
        return self.constraints.filter { $0.identifier == identifier }.first
    }
    
    /// Remove all constraints(excluding subviews).
    @objc public func clearConstraints() {
        self.removeConstraints(self.constraints)
    }
    
    /// Remove all constraints recursively.
    @objc public func clearConstraintsRecursively() {
        for subview in self.subviews {
            subview.clearConstraintsRecursively()
        }
        self.removeConstraints(self.constraints)
    }
    
    //MARK: Controllers
    
    // Get nearest view controller of this view.
    @objc public var viewController: UIViewController? {
        var view: UIView? = self
        while view != nil {
            if (view?.next is UIViewController) {
                return (view?.next as? UIViewController)!
            }
            view = view?.superview
        }
        return nil
    }
    
    // Get nearest navigation controller of this view.
    @objc public var navigationController: UINavigationController? {
        var view: UIView? = self
        while view != nil {
            let nextResponder = view?.next
            if (nextResponder is UIViewController) {
                let viewController: UIViewController? = (nextResponder as? UIViewController)
                if viewController?.navigationController != nil {
                    return viewController?.navigationController
                }
            }
            view = view?.superview
        }
        return nil
    }
    
    // Get deepest tab bar controller of this view.
    @objc public var tabBarController: UITabBarController? {
        var tabBarController: UITabBarController? = nil
        
        //Scan rootViewController.
        let rootViewContrller = UIApplication.shared.keyWindow?.rootViewController
        if (rootViewContrller is UINavigationController) {
            let controller = (rootViewContrller as? UINavigationController)
            if (controller?.topViewController is UITabBarController) {
                tabBarController = controller?.topViewController as? UITabBarController
            }
        }
        
        //Traverse all response to find tab bar controller.
        if tabBarController == nil {
            var view: UIView? = self
            while view != nil {
                if (view?.next is UITabBarController) {
                    tabBarController = (view?.next as? UITabBarController)
                }
                view = view?.superview
            }
        }
        return tabBarController
    }
    
}

// MARK: - Readonly

extension UIView
{
    @available(iOS 9.0, *)
    var layoutGuide: UILayoutGuide {
        if self.layoutGuides.count == 0 {
            let layoutGuide = UILayoutGuide()
            self.addLayoutGuide(layoutGuide)
            return layoutGuide
        }
        return self.layoutGuides.first!
    }
}

//MARK: - Image

extension UIView
{   	
    /// Capture a image from whole current view.
    ///
    /// - Returns: A image from current view.
    @objc public func captureImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

//MARK: - Misc

extension UIView
{
    
    /// Remove all subviews of self.
    public func clearSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    
    /// Traverse all subviews including self.
    @objc public func traverseSubviews(_ callback: (UIView) -> Void) {
        callback(self)
        
        for subview in subviews {
            subview.traverseSubviews(callback)
        }
    }
    
    /// Print all subviews recursively in the view hierarchy including self.
    @objc public func printHierarchy() {
        
        struct Static { static var depth = 0 }
        
        for _ in 0 ..< Static.depth { print("\t", terminator: "") }
        
        let className = NSStringFromClass(type(of:self))
        let frame = NSCoder.string(for: self.frame)
        
        print("\(className): \(frame)")
        
        Static.depth += 1
        for subview in self.subviews {
            subview.printHierarchy()
        }
        Static.depth -= 1
    }
    
}

//MARK: - Corner Mask

extension UIView
{
    
    /// Corner mask radius.
    @objc public var omaskRadius: CGFloat {
        get { return getAssociatedObject(key: "omaskRadius") as? CGFloat ?? (self.bounds.width * 0.5) }
        set {
            setAssociatedObject(key: "omaskRadius", value: newValue)
            needUpdateOmask()
        }
    }
    
    /// Corner mask background color.
    @objc public var omaskColor: UIColor {
        get { return getAssociatedObject(key: "omaskColor") as? UIColor ?? .white }
        set {
            setAssociatedObject(key: "omaskColor", value: newValue)
            needUpdateOmask()
        }
    }
    
    /// Corner mask border color.
    @objc public var omaskBorderColor: UIColor {
        get { return getAssociatedObject(key: "omaskBorderColor") as? UIColor ?? .gray }
        set {
            setAssociatedObject(key: "omaskBorderColor", value: newValue)
            needUpdateOmask()
        }
    }
    
    /// Corner mask border width.
    @objc public var omaskBorderWidth: CGFloat {
        get { return getAssociatedObject(key: "omaskBorderWidth") as? CGFloat ?? 0 }
        set {
            setAssociatedObject(key: "omaskBorderWidth", value: newValue)
            needUpdateOmask()
        }
    }
    
    /// Corner mask image view.
    @objc public var omaskImageView: UIImageView {
        get {
            if let imageView = getAssociatedObject(key: "omaskImageView") as? UIImageView {
                return imageView
            }
            let imageView = UIImageView(frame: self.bounds)
            imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            imageView.image = UIView.omaskImage(withRadius: omaskRadius, cornerColor: omaskColor, borderWidth: omaskBorderWidth, borderColor: omaskBorderColor)
            self.omaskImageView = imageView
            return imageView
        }
        set {
            setAssociatedObject(key: "omaskImageView", value: newValue)
        }
    }
    
    private var isNeedUpdateOmask: Bool {
        get { return getAssociatedObject(key: "needUpdateOmask") as? Bool ?? false }
        set {
            //Get rid of reduplicative task.
            if newValue && isNeedUpdateOmask != newValue {
                updateOmask()
            }
            
            setAssociatedObject(key: "needUpdateOmask", value: newValue)
        }
    }
    
    private func needUpdateOmask() {
        isNeedUpdateOmask = true
    }
    
    private func updateOmask() {
        //Update mask image view.
        DispatchQueue.main.async { [weak self] in
            if self == nil {
                return
            }
            
            let radius = self!.omaskRadius
            let color = self!.omaskColor
            let borderWidth = self!.omaskBorderWidth
            let borderColor = self!.omaskBorderColor
            
            if radius <= 0 {
                self!.omaskImageView.removeFromSuperview()
            } else if self!.omaskImageView.superview == nil {
                self!.addSubview(self!.omaskImageView)
            }
            
            self!.omaskImageView.image = UIView.omaskImage(withRadius: radius, cornerColor: color, borderWidth: borderWidth, borderColor: borderColor)
            self!.isNeedUpdateOmask = false
        }
    }
    
    public class func omaskImage(withRadius radius: CGFloat, cornerColor color: UIColor, borderWidth: CGFloat, borderColor: UIColor) -> UIImage? {
        let boundingRect = CGRect(x: 0, y: 0, width: radius * 2 + borderWidth + 1, height: radius * 2 + borderWidth + 1)
        let innerRect: CGRect = boundingRect.inset(by: UIEdgeInsets(top: borderWidth / 2, left: borderWidth / 2, bottom: borderWidth / 2, right: borderWidth / 2))
        UIGraphicsBeginImageContextWithOptions(boundingRect.size, false, 0)
        if let context = UIGraphicsGetCurrentContext() {
            context.addRect(boundingRect)
            let path = CGPath(roundedRect: innerRect, cornerWidth: radius, cornerHeight: radius, transform: nil)
            context.addPath(path)
            context.setFillColor(color.cgColor)
            context.setStrokeColor(color.cgColor)
            context.setLineWidth(borderWidth)
            context.drawPath(using: .eoFillStroke)
            context.addPath(path)
            context.setStrokeColor(borderColor.cgColor)
            context.strokePath()
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image?.resizableImage(withCapInsets: UIEdgeInsets(top: radius, left: radius, bottom: radius, right: radius))
        }
        return nil
    }
}

//MARK: - Swizzling

extension UIView
{
    
    // Swizzle methods.
    @objc static func swizzling() {
        DispatchQueue.once(token: "UIView.swizzling") {
            self.swizzle(#selector(point(inside:with:)), #selector(swizzledPoint(inside:with:)))
        }
    }
    
    /// The method used to exchang IMP with drawText(in:)
    @objc func swizzledPoint(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if extraHitInsets == .zero {
            return swizzledPoint(inside: point, with: event)
        } else {
            return self.bounds.inset(by: extraHitInsets).contains(point)
        }
    }
    
}
