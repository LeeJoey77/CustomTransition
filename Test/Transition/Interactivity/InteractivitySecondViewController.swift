//
//  InteractivitySecondViewController.swift
//  Test
//
//  Created by JoeyLee on 2020/4/22.
//  Copyright © 2020 JoeyLee. All rights reserved.
//

import UIKit

class InteractivitySecondViewController: UIViewController {

    var interactiveTransitionRecognizer: UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple

        interactiveTransitionRecognizer.edges = .left
        interactiveTransitionRecognizer.addTarget(self, action: #selector(interactiveTransitionRecognizerAction(sender:)))
        view.addGestureRecognizer(interactiveTransitionRecognizer)
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        button.frame.origin.x = (self.view.bounds.width - 150) / 2
        button.frame.origin.y = (self.view.bounds.height - 40) / 2
        button.backgroundColor = .white
        button.setTitle("click", for: .normal)
        button.addTarget(self, action: #selector(buttonDidClicked(sender:)), for: .touchUpInside)
        view.addSubview(button)
    }
    

    @objc func interactiveTransitionRecognizerAction(sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .began {
            self.buttonDidClicked(sender: sender)
        }
    }
    
    @objc func buttonDidClicked(sender: AnyObject) {
        // 和FirstViewController中的代码是类似的，不过返回时手势应该是从左向右
        if let transitionDelegate = self.transitioningDelegate as? InteractivityTransitionDelegate {
            if sender.isKind(of: UIGestureRecognizer.self) {
                transitionDelegate.gestureRecognizer = interactiveTransitionRecognizer
            }
            else {
                transitionDelegate.gestureRecognizer = nil
            }
            transitionDelegate.targetEdge = .left
        }
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }

}
