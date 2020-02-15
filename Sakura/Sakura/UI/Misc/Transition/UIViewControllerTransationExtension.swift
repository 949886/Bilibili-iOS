//
//  UIViewControllerTransationExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/7/26.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

//MARK: - UIViewController

extension UIViewController
{
    public enum TransitionAnimation {
        case `default`
        case none
        case present(edge: UIEdgeInsets)
        case dim(alpha: Float)
        case fade(duration: TimeInterval)
        case custom(_: String)
    }
    
    public enum TransitionType {
        case modal
        case navigation(UINavigationController.Operation)
        case tab(TabTransitionDirection)
        
        public enum ModalTransitionOperation {
            case present
            case dismiss
        }
        
        public enum TabTransitionDirection {
            case left
            case right
        }
    }

    public var transitionAnimation: TransitionAnimation {
        get { return getAssociatedObject(key: "transitionAnimation") as? TransitionAnimation ?? .default }
        set {
            switch self {
            case is UINavigationController:
                let nav = self as! UINavigationController
                nav.navigationTranstionDelegate = UINavigationControllerTransationManager.instance
            case is UITabBarController:
                let controller = self as! UITabBarController
                controller.tabTranstionDelegate = UITabBarControllerTransationManager.instance
            default: /* is UIViewController */
                self.transitioningDelegate = UIViewControllerTransationManager.instance
            }
            setAssociatedObject(key: "transitionAnimation", value: newValue)
        }
    }
    
    var transitionType: TransitionType {
        get { return getAssociatedObject(key: "transitionType") as? TransitionType ?? .modal }
        set { setAssociatedObject(key: "transitionType", value: newValue) }
    }
    
    public func present(_ controller: UIViewController, animation: TransitionAnimation, completion: (() -> Void)? = nil) {
        let transitioningDelegate = controller.transitioningDelegate
        controller.transitioningDelegate = UIViewControllerTransationManager.instance
        controller.modalPresentationStyle = .custom
        controller.transitionAnimation = animation
        if case .none = animation {
            self.present(controller, animated: false, completion: completion ?? {})
        } else {
            self.present(controller, animated: true, completion: completion ?? {})
        }
//        controller.transitioningDelegate = transitioningDelegate
    }
    
    public func dismiss(animation: TransitionAnimation, completion: (() -> Void)? = nil) {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        } else { self.dismiss(animated: true, completion: nil) }
    }
    
}

//MARK: - UINavigationController

extension UINavigationController
{
    
    public var navigationTranstionDelegate: UINavigationControllerDelegate? {
        get { return getAssociatedObject(key: "navigationTranstionDelegate") as? UINavigationControllerDelegate }
        set { setAssociatedObject(key: "navigationTranstionDelegate", value: newValue) }
    }
    
    public func push(_ controller: UIViewController, animation: TransitionAnimation, completion: (() -> Void)? = nil) {
        self.delegate = {
            let delegate = UINavigationControllerTransationManager.instance
            if !(self.delegate is UINavigationControllerTransationManager) {
                delegate.delegate = self.delegate
            }
            return delegate
        }()
        self.navigationTranstionDelegate = UINavigationControllerTransationManager.instance
        controller.transitionAnimation = animation
        if case .none = animation {
            self.push(viewController: controller, animated: false, completion: completion)
        } else {
            self.push(viewController: controller, animated: true, completion: completion)
        }
    }
    
    @discardableResult
    open func pop(animation: TransitionAnimation, completion: (() -> Void)? = nil) -> UIViewController? {
        self.delegate = {
            let delegate = UINavigationControllerTransationManager.instance
            if !(self.delegate is UINavigationControllerTransationManager) {
                delegate.delegate = self.delegate
            }
            return delegate
        }()
        self.navigationTranstionDelegate = UINavigationControllerTransationManager.instance
        
        var secondController: UIViewController?
        for i in 0..<self.viewControllers.count {
            if i == self.viewControllers.count - 2 {
                secondController = self.viewControllers[i]
                secondController?.transitionAnimation = animation
            }
        }
        
        if case .none = animation {
            return self.pop(animated: false, completion: {
                completion?()
                secondController?.transitionAnimation = .default
            })
        } else {
            return self.pop(animated: true, completion: {
                completion?()
                secondController?.transitionAnimation = .default
            })
        }
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let keyPath = keyPath {
            switch keyPath {
            case #keyPath(delegate):
                print("observe")
                if object is UINavigationControllerTransationManager {
                    
                } else {
                    
                }
            default: break
            }
        }
    }
    
}


//MARK: - UITabBarController

extension UITabBarController
{
    public var tabTranstionDelegate: UITabBarControllerDelegate? {
        get { return getAssociatedObject(key: "tabTranstionDelegate") as? UITabBarControllerDelegate }
        set { setAssociatedObject(key: "tabTranstionDelegate", value: newValue) }
    }
    
    public func setTransitionAnimation(_ animation: TransitionAnimation, fromIndex from: Int, toIndex to: Int) {
        
    }
}
