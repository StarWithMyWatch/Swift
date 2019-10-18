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
    
    public func getUser(email: String, password: String, completion: @escaping (UserConnect) -> Void) {
        
        let params = [
            "email": email,
            "password": password
            ] as [String : Any]
        
        Alamofire.request("https://quiet-shelf-35572.herokuapp.com/api/user/login", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { (res) in
            
            //print("hehe\(res)")
            guard let result = res.value as? [String:Any],
                let token = result["token"] as? String,
                let user = result["user"] as? [String:Any],
                let id = user["_id"] as? String,
                let firstName = user["firstName"] as? String,
                let lastName = user["lastName"] as? String,
                let email = user["email"] as? String,
                let type = user["type"] as? String,
                let gender = user["sex"] as? String else {return}
            print(email)
            
            let newUser = UserConnect(_id: id, firstName: firstName, lastName: lastName, email: email, image: "", gender: gender, type: type, token: token)
            completion(newUser)
            
            
        }
    }
    
    public func paycash(header:String,params: [String:Any], completion: @escaping (String,Int) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": header,
            "Content-Type": "application/json"
        ]
        Alamofire.request("link de payement ",method: .post, parameters: params,encoding: JSONEncoding.default, headers:headers).responseJSON { (res) in
            guard let status = res.response?.statusCode else { return }
            if(status == 200) {
            completion("ca passe",status)
            
            }else{
                completion("ca passepas",status)

        }
    }
        completion("cest ps dedans",200)
    }
    public func paypoints(header:String,params: [String:Any], completion: @escaping (String,Int) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": header,
            "Content-Type": "application/json"
        ]
        Alamofire.request("link de payement ",method: .post, parameters: params,encoding: JSONEncoding.default, headers:headers).responseJSON { (res) in
            guard let status = res.response?.statusCode else { return }
            if(status == 200) {
                completion("ca passe",status)
                
            }else{
                completion("ca passepas",status)
                
            }
        }
        completion("cest ps dedans",200)
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
    
    public func uploadImage(params: [String:String], image: UIImage, name: String, completion: @escaping (SessionManager.MultipartFormDataEncodingResult) -> Void) {
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            if let imageData = image.jpegData(compressionQuality: 1) {
                var imageName = name
                imageName += ".png"
                print(imageName)
                multipartFormData.append(imageData, withName: "image", fileName: imageName, mimeType: "image/png")
            }
            for (key, value) in params {
                multipartFormData.append((value.data(using: .utf8))!, withName: key)
            }
        },
                         usingThreshold:UInt64.init(),
                         to: "http://localhost:3000/api/user/imageSet",
                         method: .put,
                         encodingCompletion: { encodingResult in
                            completion(encodingResult)
        })
    }
    
    public func addUser(firstName: String, lastName: String, email: String, mdp: String, gender: String) {
        
        let params = [
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "password": mdp,
            "sex": gender
            ] as [String : Any]
        
        Alamofire.request("https://quiet-shelf-35572.herokuapp.com/api/user/signup", method: .post, parameters: params, encoding: JSONEncoding.default).responseString { (res) in
            print(res)
            //completion(res.response?.statusCode == 201)
        }
    }
    
}

