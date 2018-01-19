//
//  RegisterVC.swift
//  BagHarv
//
//  Created by Grandon Lin on 2018-01-17.
//  Copyright © 2018 Grandon Lin. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    func initialize() {
        emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        let allTextFields = [usernameTextField, emailTextField, passwordTextField, confirmPasswordTextField]
        configureTextField(textFields: allTextFields as! [UITextField])
        submitBtn.heightCircle()
    }

    @IBAction func submitBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "MainVC", sender: nil)
    }
}

