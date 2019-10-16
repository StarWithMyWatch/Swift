//
//  Watch.swift
//  StarWithMyWatch
//
//  Created by Arthur BLANC on 16/10/2019.
//  Copyright © 2019 Vithursan Sivakumaran. All rights reserved.
//

import Foundation

public struct Watch {
    var _id: String
    var nom: String
    var desc: String
    var prix: Int
    var image: String
    
    init?(json: [String: Any]) {
        guard let _id = json["_id"] as? String,
            let nom = json["nom"] as? String,
            let desc = json["desc"] as? String,
            let image = json["image"] as? String,
            let prix = json["prix"] as? Int
            else { return nil }
        self._id = _id
        self.nom = nom
        self.desc = desc
        self.prix = prix
        self.image = image
        
    }
    
    init(_id: String, nom: String, desc: String,image:String, prix: Int) {
        self._id = _id
        self.nom = nom
        self.desc = desc
        self.prix = prix
        self.image = image
        
    }
}
