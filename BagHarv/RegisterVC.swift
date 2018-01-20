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
        
        passwordValidation(password: password)
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                self.sendAlertWithoutHandler(alertTitle: "Error", alertMessage: error.localizedDescription, actionTitle: ["OK"])
            } else {
                print("Grandon: successfully create a new user")
                let defaultProfileImgUrl = DEFAULT_PROFILE_IMG_URL
                let username = self.userName
                let profileData = ["userName": username, "profileImgUrl": defaultProfileImgUrl, "gender": "", "recentCompletionImgUrl": RECENT_COMPLETION_IMG_URL]
                if let user = user {
                    print("User.uid is: \(user.uid)")
                    self.completeSignIn(id: user.uid, profileData: profileData as! Dictionary<String, String>)
                    Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                        if error == nil {
                            print("Grandon: sent email verification")
                        } else {
                            self.sendAlertWithoutHandler(alertTitle: "Not able to send email verification", alertMessage: (error?.localizedDescription)!, actionTitle: ["OK"])
                        }
                    })
                }
            }
        })
        performSegue(withIdentifier: "HomeVC", sender: nil)
    }
    
    @IBAction func signInBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func passwordValidation(password: String) {
        if password.characters.count < 8 {
            sendAlertWithoutHandler(alertTitle: "Password Error", alertMessage: "Password must be at least 8 characters. Please re-enter.", actionTitle: ["OK"])
        }
    }
}

