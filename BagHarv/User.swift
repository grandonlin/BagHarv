//
//  User.swift
//  BagHarv
//
//  Created by Grandon Lin on 2018-01-29.
//  Copyright © 2018 Grandon Lin. All rights reserved.
//

import UIKit
import Firebase

class User {
    
    private var _userId: String!
    private var _userName: String!
    private var _profileImgUrl: String!
    
    init(userId: String) {
        self._userId = userId
        self._userName = ""
        self._profileImgUrl = DEFAULT_PROFILE_IMAGE_URL
    }
    
    init(userId: String, userData: Dictionary<String, Any>) {
        self._userId = userId
        
        if let profileImageUrl = userData["Profile Image URL"] as? String {
            self._profileImgUrl = profileImageUrl
        }
        
        if let username = userData["Username"] as? String {
            self._userName = username
        }
    }
    
    var userId: String {
        get {
            return _userId
        }
        set {
            _userId = newValue
        }
    }
    
    var userName: String {
        get {
            return _userName
        }
        set {
            _userName = newValue
        }
    }
    
    var profileImgUrl: String {
        get {
            return _profileImgUrl
        }
        set {
            _profileImgUrl = newValue
        }
        
    }
    
}
