//
//  RegisterVC.swift
//  BagHarv
//
//  Created by Grandon Lin on 2018-01-17.
//  Copyright © 2018 Grandon Lin. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var signInBtn: UIButton!
    
    var usernameExisted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    func initialize() {
        let allTextFields = [emailTextField, passwordTextField, confirmPasswordTextField]
        configureTextField(textFields: allTextFields as! [UITextField])
        signUpBtn.heightCircle()
        signInBtn.heightCircle()
    }

    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, email != "" else {
            sendAlertWithoutHandler(alertTitle: "Missing Email Address", alertMessage: "Please enter your email address", actionTitle: ["Cancel"])
            return
        }
        
        guard let password = passwordTextField.text, password != "" else {
            sendAlertWithoutHandler(alertTitle: "Missing Password", alertMessage: "Please enter your password", actionTitle: ["Cancel"])
            return
        }
        
        guard let confirmPassword = confirmPasswordTextField.text, confirmPassword != "" else {
            sendAlertWithoutHandler(alertTitle: "Missing Password", alertMessage: "Please enter your password", actionTitle: ["Cancel"])
            return
        }
        
        if passwordValidationPassed(password: password, confirmPassword: confirmPassword) {
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                if let error = error {
                    self.sendAlertWithoutHandler(alertTitle: "Error", alertMessage: error.localizedDescription, actionTitle: ["OK"])
                } else {
                    print("Grandon: successfully create a new user")
                    self.performSegue(withIdentifier: "HomeVC", sender: nil)
                    Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                        if error == nil {
                            print("Grandon: sent email verification")
                        } else {
                            self.sendAlertWithoutHandler(alertTitle: "Not able to send email verification", alertMessage: (error?.localizedDescription)!, actionTitle: ["OK"])
                        }
                    })
                }
            })
        }
        
        
    }
    
    @IBAction func signInBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func passwordValidationPassed(password: String, confirmPassword: String) -> Bool {
        var passwordPass = true
        if password.characters.count < 8 {
            sendAlertWithoutHandler(alertTitle: "Password Error", alertMessage: "Password must be at least 8 characters. Please re-enter.", actionTitle: ["OK"])
            passwordPass = false
        } else if password != confirmPassword {
            sendAlertWithoutHandler(alertTitle: "Password Error", alertMessage: "Password and confirm password must be the same", actionTitle: ["Cancel"])
            passwordPass = false
        }
        return passwordPass
    }
}

