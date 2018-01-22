//
//  Global.swift
//  BagHarv
//
//  Created by Grandon Lin on 2018-01-17.
//  Copyright © 2018 Grandon Lin. All rights reserved.
//

import UIKit

var posts = [Post]()
let post1 = Post(title: "Zelda Faux-Leather Wristlet Clutch", displayImage: UIImage(named: "Zelda Faux-Leather Wristlet Clutch")!)


extension UIView {
    
    func heightCircle() {
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}

extension UIViewController {
    
    func configureTextField(textFields: [UITextField]) {
        for i in 0..<textFields.count {
            textFields[i].heightCircle()
            textFields[i].layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        }
    }
    
    func configureTextFieldWithImage(textFields: [UITextField]) {
        for i in 0..<textFields.count {
            textFields[i].heightCircle()
            textFields[i].layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
            assignImageToTextField(imageName: i, textField: textFields[i])
        }
    }
    
    func assignImageToTextField(imageName: Int, textField: UITextField) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        imageView.image = UIImage(named: UIImage().getImageName(name: imageName))
        textField.leftView = imageView
        textField.leftViewMode = .always
    }
    
    func sendAlertWithoutHandler(alertTitle: String, alertMessage: String, actionTitle: [String]) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        for action in actionTitle {
            alert.addAction(UIAlertAction(title: action, style: .default, handler: nil))
        }
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIImage {
    static let IMAGE_EMAIL = 0
    static let IMAGE_PASSWORD = 1
    
    public func getImageName(name: Int) -> String {
        var imageName: String!
        switch name {
        case UIImage.IMAGE_EMAIL:
            imageName = "text-field-email"
            break
        case UIImage.IMAGE_PASSWORD:
            imageName = "text-field-password"
            break
        default:
            imageName = ""
        }
        return imageName
    }
}
