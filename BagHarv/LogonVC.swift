//
//  LogonVC.swift
//  BagHarv
//
//  Created by Grandon Lin on 2018-01-17.
//  Copyright © 2018 Grandon Lin. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class LogonVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    var currentEmail: String!
    var currentPassword: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        
        if Auth.auth().currentUser != nil {
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { (timer) in
                self.performSegue(withIdentifier: "HomeVC", sender: nil)
            })
        }
    }
    
    func initialize() {
        let allTextFields = [emailTextField, passwordTextField]
        configureTextFieldWithImage(textFields: allTextFields as! [UITextField])
        
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
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
                        self.sendAlertWithoutHandler(alertTitle: "Login Fail", alertMessage: "New to BagHarv? Sign up to enjoy the jurney.", actionTitle: ["OK"])
                    }
                }
            })
        }
    }
    
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "RegisterVC", sender: nil)
    }
    
    @IBAction func forgetPasswordBtnPressed(_ sender: UIButton) {
        if let email = emailTextField.text {
            if email != "" {
                Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
                    if error.debugDescription.contains("There is no user") {
                        self.sendAlertWithoutHandler(alertTitle: "Forget Password", alertMessage: "There is no user record corresponding to the email address. Please confirm your email address.", actionTitle: ["Cancel"])
                    } else {
                        self.sendAlertWithoutHandler(alertTitle: "Reset Email", alertMessage: "An email has been sent to the email address to reset your password.", actionTitle: ["OK"])
                    }
                })
            } else {
                sendAlertWithoutHandler(alertTitle: "Email Required", alertMessage: "Please enter your email address", actionTitle: ["OK"])
            }
        }
        

    }
    
    func completeSignIn(id: String) {
        KeychainWrapper.standard.set(id, forKey: KEY_UID)
        DataService.ds.uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        performSegue(withIdentifier: "HomeVC", sender: nil)
    }
    
    func assignKeychainWrapperValueForEmailAndPassword(email: String, password: String) {
        KeychainWrapper.standard.set(email, forKey: CURRENT_EMAIL)
        currentEmail = KeychainWrapper.standard.string(forKey: CURRENT_EMAIL)
        KeychainWrapper.standard.set(password, forKey: CURRENT_PASSWORD)
        currentPassword = KeychainWrapper.standard.string(forKey: CURRENT_PASSWORD)
    }
}
