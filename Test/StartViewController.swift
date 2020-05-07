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
    
    @IBAction func clickTransitionBtn(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(identifier: "TransitionViewController") as? TransitionViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
