//
//  PostComponent.swift
//  BagHarv
//
//  Created by Grandon Lin on 2018-02-14.
//  Copyright © 2018 Grandon Lin. All rights reserved.
//

import UIKit

class PostComponent {
    
    private var _componentImage: UIImage!
    private var _componentDescription: String!
    
    init(componentImage: UIImage, componentDescription: String) {
        self._componentImage = componentImage
        self._componentDescription = componentDescription
    }
    
    var componentImage: UIImage! {
        get {
            return _componentImage
        }
        set {
            _componentImage = newValue
        }
    }
    
    var componentDescription: String! {
        get {
            return _componentDescription
        }
        set {
            _componentDescription = newValue
        }
    }
    
}
