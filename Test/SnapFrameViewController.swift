//
//  SnapFrameViewController.swift
//  Test
//
//  Created by JoeyLee on 2020/4/2.
//  Copyright © 2020 JoeyLee. All rights reserved.
//

import UIKit
import SnapKit

class SnapFrameViewController: UIViewController {

    let screenW = UIScreen.main.bounds.width
    
    let screenH = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        
        let viewW = screenW * 0.618
        let viewH = screenH * 0.618
        let customView = CustomView(size: CGSize(width: viewW, height: viewH))
        view.addSubview(customView)
        customView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(viewW)
            make.height.equalTo(viewH)
        }
        
       
    }
}
