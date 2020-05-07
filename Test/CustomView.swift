//
//  CustomView.swift
//  Test
//
//  Created by JoeyLee on 2020/4/2.
//  Copyright © 2020 JoeyLee. All rights reserved.
//

import UIKit

class CustomView: UIView {

    private var fitSize: CGSize = .zero
    
    init(size: CGSize) {
        super.init(frame: .zero)
        self.fitSize = size
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
