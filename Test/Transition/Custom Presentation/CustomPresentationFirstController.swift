//
//  CustomPresentationFirstController.swift
//  Test
//
//  Created by JoeyLee on 2020/4/27.
//  Copyright © 2020 JoeyLee. All rights reserved.
//

import UIKit

class CustomPresentationFirstController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        
    }
    
    @IBAction func animationButtonDidClicked(_ sender: Any) {
        let secondVC = CustomPresentationSecondController()
        let customPresentationController: CustomPresentationController = CustomPresentationController(presentedViewController: secondVC, presenting: self)
        secondVC.transitioningDelegate = customPresentationController
        self.present(secondVC, animated: true, completion: nil)
    }
}



