//
//  HalfWaySpringAnimator.swift
//  Test
//
//  Created by JoeyLee on 2020/4/22.
//  Copyright © 2020 JoeyLee. All rights reserved.
//

import Foundation
import UIKit

class HalfWaySpringAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }
    
    /// 设置动画的进行方式，附有详细注释，demo中其他地方的这个方法不再解释
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)

        // 需要关注一下from/to和presented/presenting的关系
        // For a Presentation:
        //      fromView = The presenting view.
        //      toView   = The presented view.
        // For a Dismissal:
        //      fromView = The presented view.
        //      toView   = The presenting view.
        
        var fromView = fromVC?.view
        var toView = toVC?.view
        // iOS8引入了viewForKey方法，尽可能使用这个方法而不是直接访问controller的view属性
        // 比如在form sheet样式中，我们为presentedViewController的view添加阴影或其他decoration，animator会对整个decoration view
        // 添加动画效果，而此时presentedViewController的view只是decoration view的一个子视图
        
        // Currently only two keys are defined by the system -
        // UITransitionContextFromViewKey, and UITransitionContextToViewKey
        // viewForKey: may return nil which would indicate that the animator should not
        // manipulate the associated view controller's view.
        if let tmpView = transitionContext.view(forKey: UITransitionContextViewKey.from) {
            fromView = tmpView
        }
        if let tmpView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
            toView = tmpView
        }
        guard fromView != nil, toView != nil, toVC != nil else {
            return
        }
        // 我们让toview的origin.y在屏幕的一半处，这样它从屏幕的中间位置弹起而不是从屏幕底部弹起，弹起过程中逐渐变为不透明
        toView?.frame = CGRect(x: fromView!.frame.origin.x, y: fromView!.frame.maxY / 2, width: fromView!.frame.width, height: fromView!.frame.height)
        toView?.alpha = 0.0
        
        let containerView = transitionContext.containerView
        // 在present和，dismiss时，必须将toview添加到视图层次中
        containerView.addSubview(toView!)
        
        let transitionDuration = self.transitionDuration(using: transitionContext)
        // 使用spring动画，有弹簧效果，动画结束后一定要调用completeTransition方法
        UIView.animate(withDuration: transitionDuration, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveLinear, animations: {
            toView?.alpha = 1
            toView?.frame = transitionContext.finalFrame(for: toVC!)
            // 移动到指定位置
        }) { (finished) in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
    }
}
