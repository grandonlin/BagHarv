//
//  HomeCollectionViewCell.swift
//  BagHarv
//
//  Created by Grandon Lin on 2018-02-03.
//  Copyright © 2018 Grandon Lin. All rights reserved.
//

import UIKit
import FirebaseStorage

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var displayImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func configureCell(post: Post) {
        let ref = Storage.storage().reference(forURL: post.displayImageURL)
        ref.getData(maxSize: 1024 * 1024) { (data, error) in
            if error != nil {
                let viewController = UIViewController(nibName: "HomeVC", bundle: nil)
                viewController.sendAlertWithoutHandler(alertTitle: "Error", alertMessage: (error?.localizedDescription)!, actionTitle: ["Cancel"])
            } else {
                if let image = UIImage(data: data!) {
                    self.displayImageView.image = image
                }
            }
        }
        
    }
}
