//
//  WatchService.swift
//  StarWithMyWatch
//
//  Created by Arthur BLANC on 16/10/2019.
//  Copyright © 2019 Vithursan Sivakumaran. All rights reserved.
//

import Foundation

import Alamofire

public class WatchService {
    
    public static let `default` = WatchService()
    private let baseurl: String
    private init(){
        self.baseurl = "http://demo2421622.mockable.io/watchs"
    }
    let headers: HTTPHeaders = [
       // "x-access-token": Session.default.token,
        "Content-Type": "application/json"
    ]
    
    public func getBaseURL() -> String {
        return self.baseurl;
    }
    
    public func getWatchs(completion: @escaping ([Watch]) -> Void) {
        
        Alamofire.request("https://demo2421622.mockable.io/watchs").responseJSON { (res) in
            
            guard let result = res.value as? [String:Any],
            let events = result["watchs"] as? [[String:Any]] else  { return }
            let eventsResult = events.compactMap({ (elem) -> Watch? in
                return Watch(json: elem)
            })
            print(eventsResult)
            completion(eventsResult)

            //print(result)
        }
        /*Alamofire.request(baseurl/*, headers: headers*/).responseJSON { (res) in
            guard let result = res.value as? [String:Any],
                let events = result["events"] as? [[String:Any]] else { return }
            let eventsResult = events.compactMap({ (elem) -> Watch? in
                return Watch(json: elem)
            })
            completion(eventsResult)
        }*/
    }
}
