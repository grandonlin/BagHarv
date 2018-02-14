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
    
    var post: Post
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return
    }
    
    
}
