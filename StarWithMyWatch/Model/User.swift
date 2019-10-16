//
//  User.swift
//  StarWithMyWatch
//
//  Created by Vithursan Sivakumaran on 16/10/2019.
//  Copyright © 2019 Vithursan Sivakumaran. All rights reserved.
//

import Foundation

public struct User {
    var _id: String
    var image: String
    
    init?(json: [String: Any]) {
        guard let _id = json["_id"] as? String,
            let image = json["image"] as? String
            else { return nil }
        self._id = _id
        self.image = image
        
    }
    
    init(_id: String, image:String) {
        self._id = _id
        self.image = image
        
    }
}

