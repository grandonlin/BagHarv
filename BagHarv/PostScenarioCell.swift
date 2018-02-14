//
//  PostScenarioCell.swift
//  BagHarv
//
//  Created by Grandon Lin on 2018-02-13.
//  Copyright © 2018 Grandon Lin. All rights reserved.
//

import UIKit

class PostScenarioCell: UITableViewCell {

    @IBOutlet weak var scenarioDescriptionTextView: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(post: Post) {
        scenarioDescriptionTextView.text = post.postScenario
    }

}
