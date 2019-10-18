//
//  UserConnect.swift
//  StarWithMyWatch
//
//  Created by Vithursan Sivakumaran on 17/10/2019.
//  Copyright © 2019 Vithursan Sivakumaran. All rights reserved.
//

import Foundation

public struct UserConnect {
    var _id: String
    var firstName: String
    var lastName: String
    var email: String
    var image: String
    var gender: String
    let type: String
    var token: String
    var point: Int
    
    init?(json: [String: Any]) {
        guard let _id = json["_id"] as? String,
            let firstName = json["firstName"] as? String,
            let lastName = json["lastName"] as? String,
            let email = json["email"] as? String,
            let image = json["image"] as? String,
            let gender = json["sex"] as? String,
            let type = json["type"] as? String,
            let token = json["token"] as? String,
        let point = json["point"] as? Int
            else { return nil }
        self._id = _id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.image = image
        self.gender = gender
        self.type = type
        self.token = token
        self.point = point
        
    }
    
    init(_id: String, firstName: String, lastName: String, email: String, image:String, gender: String, type: String, token: String,point:Int) {
        self._id = _id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.image = image
        self.gender = gender
        self.type = type
        self.token = token
        self.point = point
    }
    
}
