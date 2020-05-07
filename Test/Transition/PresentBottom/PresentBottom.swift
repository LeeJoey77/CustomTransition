//
//  PresentBottom.swift
//  Test
//
//  Created by JoeyLee on 2020/5/7.
//  Copyright © 2020 JoeyLee. All rights reserved.
//

import Foundation
import UIKit

protocol PresentBottomVCProtocol {
    var controllerHeight: CGFloat { get }
}

class PresentBottomVC: UIViewController, PresentBottomVCProtocol {
    var controllerHeight: CGFloat {
        return 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(presentBottomShouldHide), name: NSNotification.Name(PresentBottomHideKey), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(PresentBottomHideKey), object: nil)
    }
    
    @objc func presentBottomShouldHide() {
        self.dismiss(animated: true, completion: nil)
    }
}


public let PresentBottomHideKey = "ShouldHidePresentBottom"

class PresentBottom: UIPresentationController {
    lazy var blackView: UIView = {
        let view = UIView()
        if let frame = self.containerView?.bounds {
            view.frame = frame
        }
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(sendHideNotification))
        view.addGestureRecognizer(gesture)
        return view
    }()
    
    var controllerHeigth: CGFloat
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        if case let vc as PresentBottomVC = presentedViewController {
            controllerHeigth = vc.controllerHeight
        } else {
            controllerHeigth = UIScreen.main.bounds.width
        }
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    override func presentationTransitionWillBegin() {
        blackView.alpha = 0
        containerView?.addSubview(blackView)
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 1
        }
    }
    
    override func dismissalTransitionWillBegin() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            blackView.removeFromSuperview()
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        return CGRect(x: 0, y: UIScreen.main.bounds.height - controllerHeigth, width: UIScreen.main.bounds.width, height: controllerHeigth)
    }
    
    @objc func sendHideNotification() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: PresentBottomHideKey), object: nil)
    }
}

extension PresentBottom: UIViewControllerTransitioningDelegate {
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self
    }
}



















