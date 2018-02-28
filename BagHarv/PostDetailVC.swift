//
//  PostDetailVC.swift
//  BagHarv
//
//  Created by Grandon Lin on 2018-02-11.
//  Copyright © 2018 Grandon Lin. All rights reserved.
//

import UIKit

class PostDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var post: Post!
    var postComponents: [PostComponent]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        
        postComponents = post.postComponents
        print("PostDetailVC: \(postComponents.count)")
        print(post.postID)

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return postComponents.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PostScenarioCell", for: indexPath) as? PostScenarioCell {
                cell.configureCell(post: post)
                return cell
            }
        } else {
            if let postDetailcell = tableView.dequeueReusableCell(withIdentifier: "PostDetailCell", for: indexPath) as? PostDetailCell {
                let postComponent = postComponents[indexPath.row]
                print("PostDetailVC: is there anything here?")
                postDetailcell.configureCell(postComponent: postComponent)
                return postDetailcell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Tell Us What Happened"
        }
        else {
            return "Beinging Section 2"
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
    
}
