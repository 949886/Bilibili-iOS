//
//  AnimatedTransitionings.swift
//  Sakura
//
//  Created by YaeSakura on 2017/8/1.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

extension UIViewController
{
    //MARK: - Fade
    
    open class FadeAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning
    {
        var duration: TimeInterval = 1.0
        
        public func animateTransition(using context: UIViewControllerContextTransitioning) {
            if  let from = context.viewController(forKey: .from),
                let to = context.viewController(forKey: .to) {
                
                if to.view.superview == nil {
                    context.containerView.addSubview(to.view)
                    context.containerView.sendSubviewToBack(to.view)
                }
                to.view.frame = context.finalFrame(for: to)
                to.view.alpha = 0
                
                let duration = self.transitionDuration(using: context)
                UIView.animate(withDuration: duration, animations: {
                    from.view.alpha = 0
                    to.view.alpha = 1
                }, completion: { bool in
                    from.view.alpha = 1.0
                    context.completeTransition(true)
                })
            }
        }
        
        public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
            return duration
        }
    }
    
    //MARK: - Dim
    
    open class DimAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning
    {
        var duration: TimeInterval = 1.0
        var alpha: CGFloat = 0.4
        
        public func animateTransition(using context: UIViewControllerContextTransitioning) {
            if  let from = context.viewController(forKey: .from),
                let to = context.viewController(forKey: .to) {
                
                let width = context.containerView.frame.width * 2 / 3
                let height = context.containerView.frame.height * 2 / 3
                
                if to.isBeingPresented {
                    context.containerView.addSubview(to.view)
                    context.containerView.sendSubviewToBack(to.view)
                    
                    to.view.center = context.containerView.center
                    to.view.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
                    to.view.bounds = CGRect(x: 0, y: 0, width: 0 , height: height)
                    
                    let duration = self.transitionDuration(using: context)
                    UIView.animate(withDuration: duration, animations: {
                        to.view.bounds = CGRect(x: 0, y: 0, width: width , height: height)
                    }, completion: { bool in
                        context.completeTransition(true)
                    })
                }
                
                if to.isBeingDismissed {
                    UIView.animate(withDuration: duration, animations: {
                        to.view.bounds = CGRect(x: 0, y: 0, width: 0 , height: height)
                    }, completion: { bool in
                        context.completeTransition(true)
                    })
                }

            }
        }
        
        public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
            return duration
        }
    }
    
}

