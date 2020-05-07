//
//  FromViewController.swift
//  Test
//
//  Created by JoeyLee on 2020/5/6.
//  Copyright © 2020 JoeyLee. All rights reserved.
//

import UIKit

class FromViewController: UIViewController {

    lazy var toVC: ToViewController = ToViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        //与present/dismiss不同的时，现在视图控制器实现的是UINavigationControllerDelegate协议，让自己成为navigationController的代理。这个协议类似于此前的UIViewControllerTransitioningDelegate协议。
        
        //至于animator，就和此前没有任何区别了。可见，一个封装得很好的animator，不仅能在present/dismiss时使用，甚至还可以在push/pop时使用。
        view.backgroundColor = .purple
        self.navigationController?.delegate = self
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        button.frame.origin.x = (self.view.bounds.width - 150) / 2
        button.frame.origin.y = (self.view.bounds.height - 40) / 2
        button.backgroundColor = .white
        button.setTitle("click", for: .normal)
        button.addTarget(self, action: #selector(animationButtonDidClicked(sender:)), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func animationButtonDidClicked(sender: AnyObject) {
        self.navigationController?.pushViewController(toVC, animated: true)
    }
}

extension FromViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return HalfWaySpringAnimator()
        }
        if operation == .pop {
            return HalfWaySpringAnimator()
        }
        return nil
    }
}
