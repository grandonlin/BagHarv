//
//  Post.swift
//  BagHarv
//
//  Created by Grandon Lin on 2018-01-22.
//  Copyright © 2018 Grandon Lin. All rights reserved.
//

import UIKit

class Post {
    
    private var _title: String!
    private var _articleBody: String!
    private var _displayImage: UIImage!
    
    init()  {
        self._title = ""
        self._articleBody = ""
        self._displayImage = UIImage()
    }
    
    init(title: String, displayImage: UIImage) {
        self._title = title
        self._displayImage = displayImage
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
    
    var displayImage: UIImage {
        get {
            return _displayImage
        }
        set {
            _displayImage = newValue
        }
    }
}
