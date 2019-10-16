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
        
        Alamofire.request("https://quiet-shelf-35572.herokuapp.com/api/montres").responseJSON { (res) in
            
            guard let result = res.value as? [String:Any],
            let events = result["montres"] as? [[String:Any]] else  { return }
            let eventsResult = events.compactMap({ (elem) -> Watch? in
                return Watch(json: elem)
            })
            completion(eventsResult)

            
        }
    }
    
    public func paycash(params: [String:Any], completion: @escaping (String,Int) -> Void) {
        
        Alamofire.request("link de payement ",method: .post, parameters: params,encoding: JSONEncoding.default, headers:headers).responseJSON { (res) in
            guard let session = res.value as? [String:Any],
                let status = res.response?.statusCode else { return }
            if(status == 200) {
            completion("ca passe",status)
            //completion(eventsResult)
            
            }else{
                completion("ca passepas",status)

        }
    }
    }
    public func paypoints(completion: @escaping ([Watch]) -> Void) {
        
        Alamofire.request("link de payement ",method: .post,headers:headers).responseJSON { (res) in
            
            guard let result = res.value as? [String:Any],
                let events = result["montres"] as? [[String:Any]] else  { return }
            let eventsResult = events.compactMap({ (elem) -> Watch? in
                return Watch(json: elem)
            })
            completion(eventsResult)
            
            
        }
    }
    
    public func getPhotosMan(completion: @escaping ([User]) -> Void) {
        
        Alamofire.request("https://demo2421622.mockable.io/homme").responseJSON { (res) in
            
            guard let result = res.value as? [String:Any],
                let events = result["users"] as? [[String:Any]] else  { return }
            let eventsResult = events.compactMap({ (elem) -> User? in
                return User(json: elem)
            })
            completion(eventsResult)
            
            
        }
    }
    
    public func getPhotosWoman(completion: @escaping ([User]) -> Void) {
        
        Alamofire.request("https://demo2421622.mockable.io/femme").responseJSON { (res) in
            
            guard let result = res.value as? [String:Any],
                let events = result["users"] as? [[String:Any]] else  { return }
            let eventsResult = events.compactMap({ (elem) -> User? in
                return User(json: elem)
            })
            completion(eventsResult)
            
            
        }
    }

}
