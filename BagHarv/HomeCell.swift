//
//  HomeCell.swift
//  BagHarv
//
//  Created by Grandon Lin on 2018-01-22.
//  Copyright © 2018 Grandon Lin. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {


    @IBOutlet weak var articleTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(discussion: Discussion) {
        articleTitle.text = discussion.topic
    }


}
