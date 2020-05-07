//
//  InteractivityFirstViewController.swift
//  Test
//
//  Created by JoeyLee on 2020/4/22.
//  Copyright © 2020 JoeyLee. All rights reserved.
//

import UIKit

class InteractivityFirstViewController: UIViewController {

    lazy var secondVC: InteractivitySecondViewController = InteractivitySecondViewController()
    
    lazy var customTransitionDelegate: InteractivityTransitionDelegate = InteractivityTransitionDelegate()
    
    var interactiveTransitionRecognizer: UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        
        /// 添加滑动交互手势
        interactiveTransitionRecognizer.edges = .right
        interactiveTransitionRecognizer.addTarget(self, action: #selector(interactiveTransitionRecognizerAction(sender:)))
        view.addGestureRecognizer(interactiveTransitionRecognizer)
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        button.frame.origin.x = (self.view.bounds.width - 150) / 2
        button.frame.origin.y = (self.view.bounds.height - 40) / 2
        button.backgroundColor = .white
        button.setTitle("click", for: .normal)
        button.addTarget(self, action: #selector(animationButtonDidClicked(sender:)), for: .touchUpInside)
        view.addSubview(button)
        
        /// 设置动画代理
        secondVC.transitioningDelegate = customTransitionDelegate
        secondVC.modalPresentationStyle = .fullScreen
    }
    

    @objc func interactiveTransitionRecognizerAction(sender: UIScreenEdgePanGestureRecognizer) {
        /**
        *  在开始触发手势时，调用animationButtonDidClicked方法，只会调用一次
        */
        if sender.state == .began {
            self.animationButtonDidClicked(sender: sender)
        }
    }
    
    /**
    这个函数可以在按钮点击时触发，也可以在手势滑动时被触发，通过sender的类型来判断具体是那种情况
    如果是通过滑动手势触发，则需要设置customTransitionDelegate的gestureRecognizer属性
    
    :param: sender 事件的发送者，可能是button，也有可能是手势
    */
    @objc func animationButtonDidClicked(sender: AnyObject) {
        if sender.isKind(of: UIGestureRecognizer.self) {
            customTransitionDelegate.gestureRecognizer = interactiveTransitionRecognizer
        } else {
            customTransitionDelegate.gestureRecognizer = nil
        }
        /// 设置targetEdge为右边，也就是检测从右边向左滑动的手势
        customTransitionDelegate.targetEdge = .right
        self.present(secondVC, animated: true, completion: nil)
    }

}
