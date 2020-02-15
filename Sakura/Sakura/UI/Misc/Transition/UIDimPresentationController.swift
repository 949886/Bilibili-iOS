//
//  UIDimPresentationController.swift
//  Sakura
//
//  Created by YaeSakura on 2017/7/27.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

class UIDimPresentationController: UIPresentationController
{
    var alpha: CGFloat = 0.4
    
    private let dimmingView = UIView()
    
    override func presentationTransitionWillBegin() {
        containerView?.addSubview(dimmingView)
        
        let dimmingViewWidth = containerView!.frame.width * 2 / 3
        let dimmingViewHeight = containerView!.frame.height * 2 / 3
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: alpha)
        dimmingView.center = containerView!.center
        dimmingView.bounds = CGRect(x: 0, y: 0, width: dimmingViewWidth , height: dimmingViewHeight)
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.bounds = self.containerView!.bounds
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
        }, completion: nil)
    }
    
    override func containerViewWillLayoutSubviews(){
        dimmingView.center = containerView!.center
        dimmingView.bounds = containerView!.bounds
        
        let width = containerView!.frame.width * 2 / 3, height = containerView!.frame.height * 2 / 3
        presentedView?.center = containerView!.center
        presentedView?.bounds = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
}
