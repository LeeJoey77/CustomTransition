//
//  JLTransitionFromController.swift
//  Test
//
//  Created by JoeyLee on 2020/4/22.
//  Copyright © 2020 JoeyLee. All rights reserved.
//

import UIKit
import SnapKit

class JLTransitionFromController: UIViewController {

    lazy var toVC: JLTransitionToController = JLTransitionToController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        button.frame.origin.x = (self.view.bounds.width - 150) / 2
        button.frame.origin.y = (self.view.bounds.height - 40) / 2
        button.backgroundColor = .white
        button.setTitle("click", for: .normal)
        button.addTarget(self, action: #selector(handleClickBtnAction), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func handleClickBtnAction() {
        //modalPresentationStyle,可以自定义动画效果的只有两种：FullScreen和Custom
        toVC.modalPresentationStyle = .custom
        //        toVC.modalPresentationStyle = .fullScreen
        toVC.transitioningDelegate = self
        self.present(toVC, animated: true, completion: nil)
    }
    
}

extension JLTransitionFromController: UIViewControllerTransitioningDelegate {
    // 下面这两个函数定义在UIViewControllerTransitioningDelegate协议中
    // 用于为present和dismiss提供animator
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        //        也可以使用CrossDissolveAnimator，动画效果各有不同
        //        return CrossDissolveAnimator()
        return HalfWaySpringAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CrossDissolveAnimator()
    }
}


