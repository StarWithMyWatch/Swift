//
//  WatchService.swift
//  StarWithMyWatch
//
//  Created by Arthur BLANC on 16/10/2019.
//  Copyright © 2019 Vithursan Sivakumaran. All rights reserved.
//

import Foundation

import Alamofire

public class EventService {
    
    public static let `default` = EventService()
    private let baseurl: String
    private init(){
        self.baseurl = "https://why-not-api.herokuapp.com/events"
    }
    let headers: HTTPHeaders = [
       // "x-access-token": Session.default.token,
        "Content-Type": "application/json"
    ]
    
    public func getBaseURL() -> String {
        return self.baseurl;
    }
    
    public func getEvents(completion: @escaping ([Event]) -> Void) {
        Alamofire.request(baseurl + "/", headers: headers).responseJSON { (res) in
            guard let result = res.value as? [String:Any],
                let events = result["events"] as? [[String:Any]] else { return }
            let eventsResult = events.compactMap({ (elem) -> Event? in
                return Event(json: elem)
            })
            completion(eventsResult)
        }
    }
}
