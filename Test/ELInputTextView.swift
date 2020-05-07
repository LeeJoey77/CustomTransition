//
//  ELInputTextView.swift
//  Test
//
//  Created by JoeyLee on 2020/4/10.
//  Copyright © 2020 JoeyLee. All rights reserved.
//

import UIKit
import SnapKit

class ELInputTextView: UITextView {
    
    var textHeight: CGFloat = 20 /**< 文本高度 */
    
    var maxTextHeight: CGFloat = 20/**< 文本最大高度 */
    
    var placeholderLabel: UILabel = UILabel() /**< 占位文字*/
    
    var autoChangeHeight: Bool = true
    
    var changeTextHeightBlock: ((String, CGFloat, Bool) -> Void)?
    
    var numberOfLines: Int = 4 {
        willSet {
            if newValue == 0 {
                self.maxTextHeight = CGFloat(MAXFLOAT)
            } else {
                self.maxTextHeight = ceil(self.font!.lineHeight * CGFloat(newValue) + self.textContainerInset.top + self.textContainerInset.bottom)
            }
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        self.isScrollEnabled = false
        self.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        // 占位文字
        placeholderLabel.font = self.font
        placeholderLabel.textColor = .gray
        addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(self.textContainerInset.top)
            make.left.equalToSuperview().offset(self.textContainerInset.left + 4)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    @objc func textDidChange() {
        self.placeholderLabel.isHidden = self.text.count > 0 ? true : false // 占位文字的隐藏和显示
        
        let size = CGSize(width: self.bounds.width, height: CGFloat(MAXFLOAT))
        let height: CGFloat = CGFloat(ceilf(Float(self.sizeThatFits(size).height))) // 计算出当前文字高度
        
        if self.textHeight != height { // 高度不一样，行数改变了
            // 是否需要改变 CommentView 的高度
            self.autoChangeHeight = (height <= self.maxTextHeight && self.maxTextHeight > 0)
            self.textHeight = height
            if self.changeTextHeightBlock != nil {
                self.changeTextHeightBlock!(self.text, self.textHeight, self.autoChangeHeight)
            }
        }
    }

    func textHeightDidChange(changeText: ((String, CGFloat, Bool) -> Void)?) {
        changeTextHeightBlock = changeText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

 }
