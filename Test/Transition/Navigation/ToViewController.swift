//
//  ToViewController.swift
//  Test
//
//  Created by JoeyLee on 2020/5/6.
//  Copyright © 2020 JoeyLee. All rights reserved.
//

import UIKit

class ToViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        button.frame.origin.x = (self.view.bounds.width - 150) / 2
        button.frame.origin.y = (self.view.bounds.height - 40) / 2
        button.backgroundColor = .cyan
        button.setTitle("click", for: .normal)
        button.addTarget(self, action: #selector(animationButtonDidClicked(sender:)), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func animationButtonDidClicked(sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
}

