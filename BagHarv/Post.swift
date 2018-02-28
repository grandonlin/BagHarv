//
//  Post.swift
//  BagHarv
//
//  Created by Grandon Lin on 2018-01-22.
//  Copyright © 2018 Grandon Lin. All rights reserved.
//

import UIKit

class Post {
    
    private var _postID: String!
    private var _title: String!
    private var _articleBody: String!
    private var _created: String!
    private var _displayImageURL: String!
    private var _postScenario: String!
    private var _postComponents: [PostComponent]!
    
    init()  {
        self._postID = ""
        self._title = ""
        self._articleBody = ""
        self._created = ""
        self._displayImageURL = ""
        self._postScenario = ""
        self._postComponents = [PostComponent]()
    }
    
    init(postID: String, title: String, created: String, postComponents: [PostComponent], postScenario: String) {
        self._postID = postID
        self._title = title
        self._created = created
        self._postScenario = postScenario
        self._postComponents = postComponents
    }
    
    var postID: String {
        get {
            return _postID
        }
        set {
            _postID = newValue
        }
    }
    
    var title: String {
        get {
            return _title
        }
        set {
            _title = newValue
        }
    }
    
    var articleBody: String {
        get {
            return _articleBody
        }
        set {
            _articleBody = newValue
        }
    }
    
    var displayImageURL: String {
        get {
            return _displayImageURL
        }
        set {
            _displayImageURL = newValue
        }
    }
    
    var created: String {
        get {
            return _created
        }
        set {
            _created = newValue
        }
    }
    
    var postScenario: String {
        get {
            return _postScenario
        }
        set {
            _postScenario = newValue
        }
    }
    
    var postComponents: [PostComponent] {
        get {
            return _postComponents
        }
        set {
            _postComponents = newValue
        }
    }
}
