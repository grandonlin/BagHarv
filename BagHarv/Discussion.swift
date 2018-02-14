//
//  Discussion.swift
//  BagHarv
//
//  Created by Grandon Lin on 2018-02-11.
//  Copyright © 2018 Grandon Lin. All rights reserved.
//

import Foundation

public class Discussion {
    
    private var _discussionID: String!
    private var _topic: String!
    private var _body: String!
    
    init() {
        _discussionID = ""
        _topic = ""
        _body = ""
    }
    
    init(discussionID: String, topic: String, body: String) {
        self._discussionID = discussionID
        self._topic = topic
        self._body = body
    }
    
    var discussionID: String {
        get {
            return _discussionID
        }
        set {
            _discussionID = newValue
        }
    }
    
    var topic: String {
        get {
            return _topic
        }
        set {
            _topic = newValue
        }
    }
    
    var body: String {
        get {
            return _body
        }
        set {
            _body = newValue
        }
    }
    
}
