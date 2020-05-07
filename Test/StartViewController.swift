//
//  StartViewController.swift
//  Test
//
//  Created by JoeyLee on 2020/5/7.
//  Copyright © 2020 JoeyLee. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickButton(_ sender: UIButton) {
        
        let vc = FirstBottomVC()
        vc.modalPresentationStyle = .custom
        let presentation = PresentBottom(presentedViewController: vc, presenting: self)
        vc.transitioningDelegate = presentation
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func handleCustomPresentationBtn(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(identifier: "CustomPresentationFirstController") as? CustomPresentationFirstController {
            self.present(vc, animated: true, completion: nil)
        }
    }
}
