//
//  LogonVC.swift
//  BagHarv
//
//  Created by Grandon Lin on 2018-01-17.
//  Copyright © 2018 Grandon Lin. All rights reserved.
//

import UIKit
import FirebaseAuth

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
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    if let user = user {
                        self.completeSignIn(id: user.uid)
                    }
                } else {
                    print("Grandon: unable to sign in user - \(error)")
                    if error.debugDescription.contains("The password is invalid") {
                        self.sendAlertWithoutHandler(alertTitle: "Login Fail", alertMessage: "Forget your password? Select 'Forget Password?' to reset your password.", actionTitle: ["OK"])
                    } else if error.debugDescription.contains("There is no user record") {
                        self.sendAlertWithoutHandler(alertTitle: "Login Fail", alertMessage: "The email address entered does not exist. Please enter your email address again.", actionTitle: ["OK"])
                    } else {
                        self.sendAlertWithoutHandler(alertTitle: "Login Fail", alertMessage: "New Learner? Sign up to enjoy the jurney.", actionTitle: ["OK"])
                    }
                }
            })
        }
    }
    
    @IBAction func forgetPasswordBtnPressed(_ sender: UIButton) {
    }
    
    func completeSignIn(id: String) {
        KeychainWrapper.standard.set(id, forKey: KEY_UID)
        DataService.ds.uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        activityIndicator.stopAnimating()
        //        loadingView.hide()
        performSegue(withIdentifier: "MainVC", sender: nil)
    }
    
    func assignKeychainWrapperValueForEmailAndPassword(email: String, password: String) {
        KeychainWrapper.standard.set(email, forKey: CURRENT_EMAIL)
        currentEmail = KeychainWrapper.standard.string(forKey: CURRENT_EMAIL)
        KeychainWrapper.standard.set(password, forKey: CURRENT_PASSWORD)
        currentPassword = KeychainWrapper.standard.string(forKey: CURRENT_PASSWORD)
    }
}
