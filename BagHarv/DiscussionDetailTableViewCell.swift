//
//  DiscussionDetailTableViewCell.swift
//  BagHarv
//
//  Created by Grandon Lin on 2018-02-24.
//  Copyright © 2018 Grandon Lin. All rights reserved.
//

import UIKit
import Firebase

class DiscussionDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userCommentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(user: User, comment: Comment) {
        let url = user.profileImgUrl
        let ref = Storage.storage().reference(forURL: url)
        ref.getData(maxSize: 1024*1024) { (data, error) in
            if error != nil {
                print("\(error?.localizedDescription)")
            } else {
                let image = UIImage(data: data!)
                self.userProfileImageView.image = image
            }
        }
        userCommentLabel.text = comment.content
        
    }

}
