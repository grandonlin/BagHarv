//
//  Comment.swift
//  BagHarv
//
//  Created by Grandon Lin on 2018-02-25.
//  Copyright © 2018 Grandon Lin. All rights reserved.
//

import Foundation

public class Comment {
    
//    private var _commentID: String!
    private var _content: String!
    
    init() {
        _content = ""
    }
    
    init(content: String) {
//        _commentID = commentID
        _content = content
    }
    
//    var commentID: String {
//        get {
//            return _commentID
//        }
//    }
    
    var content: String {
        get {
            return _content
        }
        set {
            _content = newValue
        }
    }
}
