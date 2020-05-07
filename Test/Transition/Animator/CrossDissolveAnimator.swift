//
//  CrossDissolveAnimator.swift
//  Test
//
//  Created by JoeyLee on 2020/4/22.
//  Copyright © 2020 JoeyLee. All rights reserved.
//

import Foundation
import UIKit

class CrossDissolveAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        var fromView = fromVC?.view
        var toView = toVC?.view
        // iOS8引入了viewForKey方法，尽可能使用这个方法而不是直接访问controller的view属性
        // 比如在form sheet样式中，我们为presentedViewController的view添加阴影或其他decoration，animator会对整个decoration view
        // 添加动画效果，而此时presentedViewController的view只是decoration view的一个子视图
        if let tmpView = transitionContext.view(forKey: UITransitionContextViewKey.from) {
            fromView = tmpView
        }
        if let tmpView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
            toView = tmpView
        }
        guard fromVC != nil, toVC != nil, fromView != nil, toView != nil else {
            return
        }
        fromView?.frame = transitionContext.initialFrame(for: fromVC!)
        toView?.frame = transitionContext.finalFrame(for: toVC!)
        fromView?.alpha = 1.0
        toView?.alpha = 0.0
        let containerView = transitionContext.containerView
        //
        if (fromVC!.modalPresentationStyle == .fullScreen) || (fromVC!.navigationController?.delegate != nil) {
            containerView.addSubview(toView!)
        }
        
        let transitionDuration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: transitionDuration, animations: {
            fromView?.alpha = 0.0
            toView?.alpha = 1.0
        }) { (finished) in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }

    }
    
    
}
