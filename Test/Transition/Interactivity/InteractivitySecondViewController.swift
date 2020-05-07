//
//  InteractivitySecondViewController.swift
//  Test
//
//  Created by JoeyLee on 2020/4/22.
//  Copyright © 2020 JoeyLee. All rights reserved.
//

import UIKit

class InteractivitySecondViewController: UIViewController {

    @IBOutlet var interactiveTransitionRecognizer: UIScreenEdgePanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func interactiveTransitionRecognizerAction(_ sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .began {
            self.clickButton(sender)
        }
    }
    
    @IBAction func clickButton(_ sender: AnyObject) {
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
