//
//  LogonVC.swift
//  BagHarv
//
//  Created by Grandon Lin on 2018-01-17.
//  Copyright © 2018 Grandon Lin. All rights reserved.
//

import UIKit

class LogonVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    func initialize() {
        emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        let allTextFields = [emailTextField, passwordTextField]
        configureTextFieldWithImage(textFields: allTextFields as! [UITextField])
        
    }
    
    @IBAction func registerBtnPressed(_ sender: UIButton) {
        let email = emailTextField.text
        let password = passwordTextField.text
        performSegue(withIdentifier: "RegisterVC", sender: nil)
    }
    
    @IBAction func forgetPasswordBtnPressed(_ sender: UIButton) {
    }
    
}
