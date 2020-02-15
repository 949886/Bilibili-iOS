//
//  UINavigationControllerExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/6/21.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

#if os(iOS)

//MARK: - Common

extension UINavigationController
{
    @objc open override class var top: UINavigationController? {
        let rootViewController = UIApplication.shared.windows.first?.rootViewController
        return topMost(of: rootViewController)
    }
    
    private static func topMost(of viewController: UIViewController?) -> UINavigationController? {
        
        var controller: UIViewController?
        
        // UITabBarController
        if  let tabBarController = viewController as? UITabBarController,
            let selectedViewController = tabBarController.selectedViewController {
            controller = self.topMost(of: selectedViewController) ?? viewController
        }
        
        // UINavigationController
        if let navigationController = viewController as? UINavigationController,
            let visibleViewController = navigationController.visibleViewController {
            controller = self.topMost(of: visibleViewController) ?? viewController
        }
        
        // Presented view controller
        if let presentedViewController = viewController?.presentedViewController {
            controller = self.topMost(of: presentedViewController) ?? viewController
        }
        
        // Child view controller
        for subview in viewController?.view?.subviews ?? [] {
            if let childViewController = subview.next as? UIViewController {
                controller = self.topMost(of: childViewController) ?? viewController
            }
        }
        
        if controller is UINavigationController {
            return controller as! UINavigationController
        } else {
            return nil
        }
    }
}

//MARK: - Navigate

extension UINavigationController
{
    
    open func push(viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
    @discardableResult
    open func pop(animated: Bool = true, completion: (() -> Void)? = nil) -> UIViewController? {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        let controller = self.popViewController(animated: animated)
        CATransaction.commit()
        return controller
    }
    
    @discardableResult
    open func pop(to viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) -> [UIViewController]? {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        let controllers = self.popToViewController(viewController, animated: animated)
        CATransaction.commit()
        return controllers
    }
    
    @discardableResult
    open func popToRootViewController(animated: Bool = true, completion: (() -> Void)? = nil) -> [UIViewController]? {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        let controllers = self.popToRootViewController(animated: animated)
        CATransaction.commit()
        return controllers
    }
    
}

#endif
