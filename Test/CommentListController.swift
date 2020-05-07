//
//  CommentListController.swift
//  Test
//
//  Created by JoeyLee on 2020/4/10.
//  Copyright © 2020 JoeyLee. All rights reserved.
//

import UIKit

class CommentListController: UIViewController {

    lazy var tableView: UITableView = UITableView(frame: UIScreen.main.bounds, style: .plain)

    lazy var commentView = ELCommentView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //列表的contentInsetAdjustmentBehavior失效，需要自己设置底部inset
        view.addSubview(tableView)
        
        commentView.contoller = self
        view.addSubview(commentView)
        commentView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            self.commentView.bottomConstraint = make.bottom.equalToSuperview().constraint
            make.height.equalTo(30)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
}

extension CommentListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "啦啦啦"
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
}
