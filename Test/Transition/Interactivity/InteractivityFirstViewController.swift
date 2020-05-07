//
//  InteractivityFirstViewController.swift
//  Test
//
//  Created by JoeyLee on 2020/4/22.
//  Copyright © 2020 JoeyLee. All rights reserved.
//

import UIKit

class InteractivityFirstViewController: UIViewController {
   
    @IBOutlet var interactiveTransitionRecognizer: UIScreenEdgePanGestureRecognizer!
    
    let customTransitionDelegate: InteractivityTransitionDelegate = InteractivityTransitionDelegate()

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func interactiveTransitionRecognizerAction(_ sender: UIScreenEdgePanGestureRecognizer) {
        // 在开始触发手势时，调用animationButtonDidClicked方法，只会调用一次
        if sender.state == .began {
            self.animationButtonDidClicked(sender)
        }
    }
    
    /**
    这个函数可以在按钮点击时触发，也可以在手势滑动时被触发，通过sender的类型来判断具体是那种情况
    如果是通过滑动手势触发，则需要设置customTransitionDelegate的gestureRecognizer属性
    
    :param: sender 事件的发送者，可能是button，也有可能是手势
    */
    @IBAction func animationButtonDidClicked(_ sender: AnyObject) {
        if let secondVC = storyboard?.instantiateViewController(identifier: "InteractivitySecondViewController") as? InteractivitySecondViewController {
            
            if sender.isKind(of: UIGestureRecognizer.self) {
                customTransitionDelegate.gestureRecognizer = interactiveTransitionRecognizer
            } else {
                customTransitionDelegate.gestureRecognizer = nil
            }
            // 设置targetEdge为右边，也就是检测从右边向左滑动的手势
            customTransitionDelegate.targetEdge = .right
            
            // 设置动画代理
            secondVC.transitioningDelegate = customTransitionDelegate
            secondVC.modalPresentationStyle = .fullScreen
            self.present(secondVC, animated: true, completion: nil)
        }
    }
}
