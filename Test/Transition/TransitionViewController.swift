//
//  TransitionViewController.swift
//  Test
//
//  Created by JoeyLee on 2020/5/7.
//  Copyright © 2020 JoeyLee. All rights reserved.
//

import UIKit

class TransitionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
   
    @IBAction func clickNoneInteractAnimatorButton(_ sender: Any) {
        let vc = JLTransitionFromController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickInteractiveAnimatorButton(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(identifier: "InteractivityFirstViewController") as? InteractivityFirstViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func clickCustomPresentationButton(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(identifier: "CustomPresentationFirstController") as? CustomPresentationFirstController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func clickNaviButton(_ sender: Any) {
        let vc = FromViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickPresentBottomButton(_ sender: UIButton) {

        let vc = FirstBottomVC()
        vc.modalPresentationStyle = .custom
        let presentation = PresentBottom(presentedViewController: vc, presenting: self)
        vc.transitioningDelegate = presentation
        self.present(vc, animated: true, completion: nil)
    }


}
