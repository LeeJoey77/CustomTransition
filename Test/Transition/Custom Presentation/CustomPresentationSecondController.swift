//
//  CustomPresentationSecondController.swift
//  Test
//
//  Created by JoeyLee on 2020/4/27.
//  Copyright © 2020 JoeyLee. All rights reserved.
//

import UIKit

class CustomPresentationSecondController: UIViewController {

    lazy var slider = UISlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        
        let popButton =  UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        popButton.frame.origin.x = (self.view.bounds.width - 150) / 2
        popButton.frame.origin.y = 50
        popButton.backgroundColor = .white
        popButton.setTitle("click", for: .normal)
        popButton.addTarget(self, action: #selector(buttonDidClicked), for: .touchUpInside)
        view.addSubview(popButton)
        
        
        slider.frame = CGRect(x: 20, y: popButton.frame.maxY, width: UIScreen.main.bounds.width - 40, height: 30)
        slider.addTarget(self, action: #selector(sliderValueChange(sender:)), for: .valueChanged)
        view.addSubview(slider)

        self.updatePreferredContentSizeWithTraitCollection(traitCollection: self.traitCollection)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        self.updatePreferredContentSizeWithTraitCollection(traitCollection: newCollection)
    }
    
    func updatePreferredContentSizeWithTraitCollection(traitCollection: UITraitCollection) {
        self.preferredContentSize = CGSize(width: view.bounds.width, height: traitCollection.verticalSizeClass == .compact ? 270 : 420)
        slider.maximumValue = Float(self.preferredContentSize.height)
        slider.minimumValue = 220
        slider.value = self.slider.maximumValue
    }
    
}

extension CustomPresentationSecondController {
    
    @objc func buttonDidClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func sliderValueChange(sender: UISlider) {
        self.preferredContentSize = CGSize(width: view.bounds.width, height: CGFloat(sender.value))
    }
}
