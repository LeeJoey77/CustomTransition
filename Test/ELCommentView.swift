//
//  ELCommentView.swift
//  Test
//
//  Created by JoeyLee on 2020/4/10.
//  Copyright © 2020 JoeyLee. All rights reserved.
//

import UIKit
import SnapKit

class ELCommentView: UIView {

    var contoller: UIViewController!
    
    var bottomConstraint: Constraint!
    
    var contentScrollView: UIScrollView = UIScrollView()
    
    var contentView: UIView = UIView()
    
    var textView: ELInputTextView = ELInputTextView(frame: .zero)
    
    var chooseImageButton: UIButton = UIButton()
    
    var commentHeight: CGFloat = 30
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardChange(notifi:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardChange(notifi:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // 选择照片
        chooseImageButton.backgroundColor = .blue
        chooseImageButton.addTarget(self, action: #selector(handleSendBtnAction), for: .touchUpInside)
        addSubview(chooseImageButton)
        
        addSubview(contentScrollView)
        contentScrollView.addSubview(contentView)
        textView.numberOfLines = 3
        textView.placeholderLabel.text = "请输入内容"
        contentView.addSubview(textView)
        textView.textHeightDidChange { [weak self](text, height, autoChangeHeight) in
            guard let strongSelf = self else { return }
            strongSelf.updateHeightWithHeight(height: height, autoChangeHeight: autoChangeHeight)
        }
        // 选择照片
        chooseImageButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-12)
            make.width.height.equalTo(commentHeight)
            make.bottom.equalToSuperview()
        }
        // ScrollView
        contentScrollView.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.right.equalTo(chooseImageButton.snp.left).offset(-12)
        }
        // contentView
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(commentHeight)
        }
        // textView
        textView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
            make.height.equalTo(commentHeight)
        }
    }
    
    func updateHeightWithHeight(height: CGFloat, autoChangeHeight: Bool) {
        
        if (autoChangeHeight) {
            // 设置输入框的高度
            self.snp.makeConstraints { (make) in
                make.height.equalTo(height)
            }
        }
        // 设置文字可滚动范围
        self.contentView.snp.makeConstraints { (make) in
            make.height.equalTo(height)
        }
        self.textView.snp.makeConstraints { (make) in
            make.height.equalTo(height)
        }
        self.layoutIfNeeded()
    }
    
    @objc func handleSendBtnAction() {
        
    }
    
    /**
     键盘通知
     */
    @objc func keyboardChange(notifi: Notification) {
        let userInfo = notifi.userInfo
        guard let duration = userInfo?["UIKeyboardAnimationDurationUserInfoKey"] as? CGFloat else { return }
        guard let keyboardHeight = (userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect)?.size.height else { return }
        if notifi.name == UIResponder.keyboardWillShowNotification {
            // 键盘弹起
            self.updateBottomConstraintsWithHeight(height: keyboardHeight, duration: duration)
        } else if notifi.name == UIResponder.keyboardWillHideNotification {
            // 键盘收起
            self.updateBottomConstraintsWithHeight(height: keyboardHeight, duration: duration)
        }
    }

    /**
     更新底部约束
     */
    func updateBottomConstraintsWithHeight(height: CGFloat, duration: CGFloat) {
        bottomConstraint.update(offset: -height)
        UIView.animate(withDuration: TimeInterval(duration)) {
            self.superview?.layoutIfNeeded()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
