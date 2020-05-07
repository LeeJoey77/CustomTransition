//
//  JLTransitionToController.swift
//  Test
//
//  Created by JoeyLee on 2020/4/22.
//  Copyright © 2020 JoeyLee. All rights reserved.
//

import UIKit

class JLTransitionToController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        button.frame.origin.x = (self.view.bounds.width - 150) / 2
        button.frame.origin.y = (self.view.bounds.height - 40) / 2
        button.backgroundColor = .white
        button.setTitle("click", for: .normal)
        button.addTarget(self, action: #selector(handleClickBtnAction), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func handleClickBtnAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
