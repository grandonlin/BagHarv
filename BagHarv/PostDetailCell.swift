//
//  PostDetailCell.swift
//  BagHarv
//
//  Created by Grandon Lin on 2018-02-13.
//  Copyright © 2018 Grandon Lin. All rights reserved.
//

import UIKit
import Firebase

class PostDetailCell: UITableViewCell {


    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var imageDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(postComponent: PostComponent) {
        
        detailImageView.image = postComponent.componentImage
        imageDescriptionLabel.text = postComponent.componentDescription
    }
    
}
