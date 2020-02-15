//
//  UIViewControllerTransationManager.swift
//  Sakura
//
//  Created by YaeSakura on 2017/7/27.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

// MARK: - UIViewController

public class UIViewControllerTransationManager: NSObject, UIViewControllerTransitioningDelegate
{
    // MARK: Singleton
    
    public static let instance: UIViewControllerTransationManager = {
        let instance = UIViewControllerTransationManager()
        return instance
    }()
    
    //MARK: Delegate
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presented.transitionType = .modal
        return animationController(forAnimation: presented.transitionAnimation)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        dismissed.transitionType = .modal
        return animationController(forAnimation: dismissed.transitionAnimation)
    }
    
//    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        
//    }
//    
//    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        
//    }
    
    //MARK: Private
    
    private func animationController(forAnimation animation: UIViewController.TransitionAnimation) -> UIViewControllerAnimatedTransitioning? {
        switch animation {
        case .default: return nil
        case .fade(let duration):
            let transitioning = UIViewController.FadeAnimatedTransitioning()
            transitioning.duration = duration
            return transitioning
        case .dim(let alpha):
            let transitioning = UIViewController.DimAnimatedTransitioning()
            transitioning.alpha = alpha.f
            return transitioning
        default: return nil
        }
    }
    
    //MARK: Public
    
    public func registerCustomAnimation(_ animation: UIViewControllerAnimatedTransitioning, identifier: String, isInteractable: Bool = false) {
        
    }
    
}


// MARK: - UINavigationController

public class UINavigationControllerTransationManager: NSObject, UINavigationControllerDelegate
{
    // MARK: Singleton
    
    public static let instance: UINavigationControllerTransationManager = {
        let instance = UINavigationControllerTransationManager()
        return instance
    }()
    
    //MARK: Property
    
    /// <#Description#>
    @objc public var delegate: UINavigationControllerDelegate?
    
    //MARK: Delegate
    
    /* Transition */
    
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        toVC.transitionType = .navigation(operation)
        
        var animation: UIViewController.TransitionAnimation = .default
        switch operation {
        case .push: animation = toVC.transitionAnimation
        case .pop:  animation = fromVC.transitionAnimation
        default: break
        }
        
        switch animation {
        case .default: return nil
        case .fade(let duration):
            let transitioning = UIViewController.FadeAnimatedTransitioning()
            transitioning.duration = duration
            return transitioning
        default: return nil
        }
    }
    
//    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        
//    }
    
    /* Delegate */
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let from = navigationController.transitionCoordinator?.viewController(forKey: .from) {
            if navigationController.viewControllers.contains(from) { /* Push */
                print("contain")
                navigationController.addObserver(self, forKeyPath: #keyPath(delegate), options: [.new, .old], context: nil)
            } else { /* Pop */
                print("not contain")
                navigationController.removeObserver(self, forKeyPath: #keyPath(delegate))
            }
        }
        delegate?.navigationController?(navigationController, willShow: viewController, animated: animated)
    }
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        delegate?.navigationController?(navigationController, didShow: viewController, animated: animated)
    }
    
    public func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
        return delegate?.navigationControllerSupportedInterfaceOrientations?(navigationController) ?? .all
    }
    
    public func navigationControllerPreferredInterfaceOrientationForPresentation(_ navigationController: UINavigationController) -> UIInterfaceOrientation {
        return delegate?.navigationControllerPreferredInterfaceOrientationForPresentation?(navigationController) ?? .portrait
    }
    
    //MARK: KVO
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let navigationController = object as? UINavigationController else { return }
        
        if let keyPath = keyPath {
            switch keyPath {
            case #keyPath(delegate):
                if change?[.oldKey] is UINavigationControllerTransationManager &&
                    !(change?[.newKey] is UINavigationControllerTransationManager) {
                    let delegate = change?[.oldKey] as! UINavigationControllerTransationManager
                    delegate.delegate = change?[.newKey] as? UINavigationControllerDelegate
                    navigationController.delegate = delegate
                }
            default: break
            }
        }
    }
    
    //MARK: Public
    
    public func registerCustomAnimation(_ animation: UIViewControllerAnimatedTransitioning, identifier: String, isInteractable: Bool = false) {
        
    }
}


// MARK: - UITabBarController

public class UITabBarControllerTransationManager: NSObject, UITabBarControllerDelegate
{
    // MARK: Singleton
    
    public static let instance: UITabBarControllerTransationManager = {
        let instance = UITabBarControllerTransationManager()
        return instance
    }()
    
    //MARK: Delegate
    
    public func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let fromIndex = tabBarController.viewControllers!.index(of: fromVC)!
        let toIndex = tabBarController.viewControllers!.index(of: toVC)!
        toVC.transitionType = .tab(toIndex < fromIndex ? .left : .right)
        
        let animation = toVC.transitionAnimation
        switch animation {
        case .default: return nil
        case .fade(let duration):
            let transitioning = UIViewController.FadeAnimatedTransitioning()
            transitioning.duration = duration
            return transitioning
        default: return nil
        }
    }
    
//    func tabBarController(_ tabBarController: UITabBarController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?{
//        return interactive ? interactionController : nil
//    }
    
    //MARK: Public
    
    public func registerCustomAnimation(_ animation: UIViewControllerAnimatedTransitioning, identifier: String, isInteractable: Bool = false) {
        
    }
}
