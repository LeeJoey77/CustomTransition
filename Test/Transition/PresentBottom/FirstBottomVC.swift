//
//  FirstBottomVC.swift
//  Test
//
//  Created by JoeyLee on 2020/5/7.
//  Copyright © 2020 JoeyLee. All rights reserved.
//

import UIKit

class FirstBottomVC: PresentBottomVC {

    override var controllerHeight: CGFloat {
        return 200.0
    }
    
    lazy var closeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 15, y: 50, width: 80, height: 30))
        button.setTitle("close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        view.addSubview(closeButton)
    }
    
    @objc func closeButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }

}
