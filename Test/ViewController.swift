//
//  ViewController.swift
//  Test
//
//  Created by JoeyLee on 2020/3/13.
//  Copyright © 2020 JoeyLee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let screenW: CGFloat = UIScreen.main.bounds.width
    
    let screenH: CGFloat = UIScreen.main.bounds.height
    
    lazy var scrollView: UIScrollView = setupScrollView()
    
    lazy var imageView = setupImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
    }

    private func setupScrollView() -> UIScrollView {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenW, height: screenH * 3 / 5))
        scrollView.delegate = self
        scrollView.backgroundColor = .white
        scrollView.alwaysBounceHorizontal = true
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.maximumZoomScale = 3
        scrollView.contentSize = imageView.frame.size
        scrollView.addSubview(imageView)
        return scrollView
    }
    
    private func setupImageView() -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenW, height: screenH))
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "1.png")
        let tapGesture = setupTapGestureRecoginzer()
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }
    
    private func setupTapGestureRecoginzer() -> UITapGestureRecognizer {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        tapGesture.numberOfTapsRequired = 2
        return tapGesture
    }

    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        if scrollView.zoomScale > 1.0 {
            scrollView.setZoomScale(1, animated: true)
        } else {
            let touchPoint = gesture.location(in: imageView)
            let currentZoomScale = scrollView.maximumZoomScale
            let xSize = self.view.frame.width / currentZoomScale
            let ySize = self.view.frame.height / currentZoomScale
            scrollView.zoom(to: CGRect(x: touchPoint.x - xSize * 0.5, y: touchPoint.y - ySize * 0.5, width: xSize, height: ySize), animated: true)
        }
        
    }
}

extension ViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}

