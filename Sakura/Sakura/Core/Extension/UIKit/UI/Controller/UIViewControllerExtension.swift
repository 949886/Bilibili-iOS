//
//  UIViewControllerExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/5/22.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

extension UIViewController
{
    
    /// Top most view controller in hierachy.
    @objc open class var top: UIViewController? {
        let rootViewController = UIApplication.shared.windows.first?.rootViewController
        return topMost(of: rootViewController)
    }
    
}

extension UIViewController
{
    private static func topMost(of viewController: UIViewController?) -> UIViewController? {
        
        // UITabBarController
        if  let tabBarController = viewController as? UITabBarController,
            let selectedViewController = tabBarController.selectedViewController {
            return self.topMost(of: selectedViewController)
        }
        
        // UINavigationController
        if let navigationController = viewController as? UINavigationController,
            let visibleViewController = navigationController.visibleViewController {
            return self.topMost(of: visibleViewController)
        }
        
        // Presented view controller
        if let presentedViewController = viewController?.presentedViewController {
            return self.topMost(of: presentedViewController)
        }
        
        // Child view controller
        for subview in viewController?.view?.subviews ?? [] {
            if let childViewController = subview.next as? UIViewController {
                return self.topMost(of: childViewController)
            }
        }
        
        return viewController
    }
}

public protocol UIViewControllerNavigationDelegate: class {
    
}
