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
    private var _headImageURLs: [String]!
    private var _bodyImageURLs: [String]!
    private var _bottomImageURLs: [String]!
    private var _postScenario: String!
    
    init()  {
        self._postID = ""
        self._title = ""
        self._articleBody = ""
        self._created = ""
        self._displayImageURL = ""
        self._headImageURLs = [String]()
        self._bodyImageURLs = [String]()
        self._bottomImageURLs = [String]()
        self._postScenario = ""
    }
    
    init(postID: String, title: String, created: String, displayImageURL: String, headImageURLs: [String], bodyImageURLs: [String], bottomImageURLs: [String], postScenario: String) {
        self._postID = postID
        self._title = title
        self._created = created
        self._displayImageURL = displayImageURL
        self._headImageURLs = headImageURLs
        self._bodyImageURLs = bodyImageURLs
        self._bottomImageURLs = bottomImageURLs
        self._postScenario = postScenario
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
    
    var headImageURLs: [String] {
        get {
            return _headImageURLs
        }
        set {
            _headImageURLs = newValue
        }
    }
    
    var bodyImageURLs: [String] {
        get {
            return _bodyImageURLs
        }
        set {
            _bodyImageURLs = newValue
        }
    }
    
    var bottomImageURLs: [String] {
        get {
            return _bottomImageURLs
        }
        set {
            _bottomImageURLs = newValue
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
}
