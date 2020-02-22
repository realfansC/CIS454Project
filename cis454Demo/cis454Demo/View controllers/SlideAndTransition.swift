//
//  SlideAndTransition.swift
//  cis454Demo
//
//  Created by Yian Yu on 2/22/20.
//  Copyright © 2020 张尧. All rights reserved.
//

import UIKit

class SlideAndTransition: NSObject,UIViewControllerAnimatedTransitioning{
    var isPresenting = false
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey:.to),
            let fromViewController = transitionContext.viewController(forKey:.from)
        else {return}
        
        let containerView = transitionContext.containerView
        
        let finalWidth = toViewController.view.bounds.width * 0.8
        let finalHeight = toViewController.view.bounds.height
        
        if isPresenting{
       containerView.addSubview(toViewController.view)
           toViewController.view.frame =  CGRect(x:-finalWidth,y:0, width:finalWidth, height:finalHeight)
        }
        let transform = {toViewController.view.transform = CGAffineTransform(translationX:finalWidth, y:0)
        }
            let identity = {fromViewController.view.transform = .identity}
        //Animation of the transition
        let duration = transitionDuration(using:transitionContext)
        let isCancelled = transitionContext.transitionWasCancelled
        UIView.animate(withDuration: duration,animations:{self.isPresenting ? transform() : identity()}){(_)in
            transitionContext.completeTransition(!isCancelled)
        }
        }
}



