//
//  DiscussionVC.swift
//  BagHarv
//
//  Created by Grandon Lin on 2018-01-22.
//  Copyright © 2018 Grandon Lin. All rights reserved.
//

import UIKit

class DiscussionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var discussionTopicLabel: UILabel!
    @IBOutlet weak var discussionBodyLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var discussionCommentTextField: UITextField!
    
    var discussion: Discussion!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        initialize()
    }
    
    func initialize() {
        discussionCommentTextField.heightCircle()
        discussionTopicLabel.text = discussion.topic
        discussionBodyLabel.text = discussion.body
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discussion.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = discussion.comments[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DiscussionDetailTableViewCell", for: indexPath) as? DiscussionDetailTableViewCell {
            cell.configureCell(user: <#T##User#>, comment: <#T##Comment#>)
        }
    }
}
