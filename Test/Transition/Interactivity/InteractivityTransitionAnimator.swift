//
//  InteractivityTransitionAnimator.swift
//  Test
//
//  Created by JoeyLee on 2020/4/22.
//  Copyright © 2020 JoeyLee. All rights reserved.
//

import Foundation
import UIKit

class InteractivityTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let targetEdge: UIRectEdge
    
    init(targetEdge: UIRectEdge) {
        self.targetEdge = targetEdge
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let containerView = transitionContext.containerView
        
        var fromView = fromViewController?.view
        var toView = toViewController?.view
        
        
        fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        guard fromView != nil, toView != nil, fromViewController != nil, toViewController != nil else {
            return
        }
        
        /// isPresenting用于判断当前是present还是dismiss
        let isPresenting = (toViewController?.presentingViewController == fromViewController)
        let fromFrame = transitionContext.initialFrame(for: fromViewController!)
        let toFrame = transitionContext.finalFrame(for: toViewController!)
        
        /// offset结构体将用于计算toView的位置
        let offset: CGVector
        switch self.targetEdge {
        case .top: offset = CGVector(dx: 0, dy: 1)
        case .bottom: offset = CGVector(dx: 0, dy: -1)
        case .left: offset = CGVector(dx: 1, dy: 0)
        case .right: offset = CGVector(dx: -1, dy: 0)
        default:fatalError("targetEdge must be one of UIRectEdgeTop, UIRectEdgeBottom, UIRectEdgeLeft, or UIRectEdgeRight.")
        }
        
        /// 根据当前是dismiss还是present，横屏还是竖屏，计算好toView的初始位置以及结束位置
        if isPresenting {
            fromView?.frame = fromFrame
            toView?.frame = toFrame.offsetBy(dx: toFrame.size.width * offset.dx * -1,
                                             dy: toFrame.size.height * offset.dy * -1)
            containerView.addSubview(toView!)
        } else {
            fromView?.frame = fromFrame
            toView?.frame = toFrame
            containerView.insertSubview(toView!, belowSubview: fromView!)
        }
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: { () -> Void in
            if isPresenting {
                toView?.frame = toFrame
            } else {
                fromView?.frame = fromFrame.offsetBy(dx: fromFrame.size.width * offset.dx,
                                                     dy: fromFrame.size.height * offset.dy)
            }
            }) { (finished: Bool) -> Void in
                let wasCanceled = transitionContext.transitionWasCancelled
                if wasCanceled {toView?.removeFromSuperview()}
                transitionContext.completeTransition(!wasCanceled)
        }
    }
}
