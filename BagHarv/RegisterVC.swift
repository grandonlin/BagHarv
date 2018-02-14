//
//  RegisterVC.swift
//  BagHarv
//
//  Created by Grandon Lin on 2018-01-17.
//  Copyright © 2018 Grandon Lin. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import Firebase
import SwiftKeychainWrapper

class RegisterVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var usernameExisted = false
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        initialize()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        DataService.ds.REF_USERS.removeAllObservers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        DataService.ds.REF_USERS.removeAllObservers()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        DataService.ds.REF_USERS.observeSingleEvent(of: .value, with: { (snapshot) in
//            if let snapShot = snapshot.children.allObjects as? [DataSnapshot] {
//                if snapShot.count > 0 {
//                    if snapShot.count < 10 {
//                        self.userID = "0\(snapShot.count + 1)"
//                    } else {
//                        self.userID = "\(snapShot.count + 1)"
//                    }
//                } else {
//                    self.userID = "01"
//                }
//                KeychainWrapper.standard.set(self.userID, forKey: KEY_UID)
//            }
//        })
//    }
    
    func initialize() {
        let allTextFields = [usernameTextField, emailTextField, passwordTextField, confirmPasswordTextField]
        configureTextField(textFields: allTextFields as! [UITextField])
        signUpBtn.heightCircle()
        signInBtn.heightCircle()
        profileImageView.circleView()
    }

    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        guard let username = usernameTextField.text, username != "" else {
            sendAlertWithoutHandler(alertTitle: "Missing Username", alertMessage: "Please enter your username", actionTitle: ["Cancel"])
            return
        }
        
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
        
        if !passwordValidationPassed(password: password, confirmPassword: confirmPassword) {
            return
        }
        
        if profileImageView.image == UIImage(named: "profile") {
            let alert = UIAlertController(title: "Profile Image", message: "Do you want to select a more suitable profile image?", preferredStyle: .alert)
            
            let yesActionHandler = { (action: UIAlertAction!) -> Void in
                return
            }
            
            let noActionHandler = { (action: UIAlertAction!) -> Void in
                self.processSignUp(username: username, email: email, password: password)
            }
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: yesActionHandler))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: noActionHandler))
            self.present(alert, animated: true, completion: nil)
        } else {
            processSignUp(username: username, email: email, password: password)
        }
    }
    
    @IBAction func profileImagePressed(_ sender: UITapGestureRecognizer) {
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            profileImageView.image = selectedImage
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signInBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func processSignUp(username: String, email: String, password: String) {
        DataService.ds.REF_USERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                self.usernameExisted = self.checkExistingUser(snapshot: snapshot, userName: username)
                if self.usernameExisted == true {
                    self.sendAlertWithoutHandler(alertTitle: "Username Exists", alertMessage: "This username has been occupied, please use another.", actionTitle: ["Cancel"])
                    return
                } else {
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        if let error = error {
                            self.sendAlertWithoutHandler(alertTitle: "Error", alertMessage: error.localizedDescription, actionTitle: ["OK"])
                        } else {
                            print("Grandon: successfully create a new user")
                            if let user = user {
                                let currentImage = self.profileImageView.image
                                if let imageData = UIImageJPEGRepresentation(currentImage!, 0.2) {
                                    DataService.ds.STORAGE_USER_IMAGE.child(user.uid).child("Profile Image").putData(imageData, metadata: nil) { (data, error) in
                                        if error != nil {
                                            let imgAlert = UIAlertController(title: "Error", message: "\(error?.localizedDescription)", preferredStyle: .alert)
                                            imgAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                                            self.present(imgAlert, animated: true, completion: nil)
                                            //                        print("Grandon(postCreateVC): not able to upload image")
                                        } else {
                                            let profileImageUrl = data?.downloadURL()?.absoluteString
                                            var userData = [String: Any]()
                                            userData = ["Porfile Image URL": profileImageUrl!, "Username": username]
                                            currentUser = User(userId: user.uid, userData: userData)
                                            self.completeSignIn(id: user.uid, userData: userData)
                                            Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                                                if error == nil {
                                                    print("Grandon: sent email verification")
                                                } else {
                                                    self.sendAlertWithoutHandler(alertTitle: "Not able to send email verification", alertMessage: (error?.localizedDescription)!, actionTitle: ["OK"])
                                                }
                                            })
                                        }
                                    }
                                }
                            }
                            
                            
                            
                        }
                    })
                }
            }
        })
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
    
    func checkExistingUser(snapshot: [DataSnapshot], userName: String) -> Bool {
        var exist = false
        for snap in snapshot {
            if let userSnap = snap.value as? Dictionary<String, Any> {
                if let name = userSnap["Username"] as? String {
                    print("Grandon: username is \(name)")
                    if name == userName {
                        exist = true
                        print("Grandon: is it true? \(exist)")
                        break
                    }
                }
            }
        }
        return exist
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, Any>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        performSegue(withIdentifier: "HomeVC", sender: nil)
    }
}

