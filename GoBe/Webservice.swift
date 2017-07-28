//
//  Webservice.swift
//  GoBe
//
//  Created by rlogical-dev-11 on 29/06/17.
//  Copyright © 2017 rlogical-dev-35. All rights reserved.
//

import UIKit

@objc protocol WebApiRequestDelegate {
    
//Register
    
    //Simple Register
    @objc optional func register_NormalResponse(responseObj: NSDictionary) -> Void
    //Facebook Register
    @objc optional func register_FacebookResponse(responseObj: NSDictionary) -> Void
    
//Login
    
    //Simple Login
    @objc optional func login_NormalResponse(responseObj: NSDictionary) -> Void
    //Facebook Login
    @objc optional func login_FacebookResponse(responseObj: NSDictionary) -> Void

//Forgot Password
    @objc optional func forgotPasswordResponse(responseObj: NSDictionary) -> Void
    
//Profile Details
    
    //User details Profile
    @objc optional func getUserProfileDetailsResponse(responseObj: NSDictionary) -> Void

//Home screen API
    // New & Trending API
    @objc optional func getNewAndTendingTipsResponse(responseObj: NSDictionary) -> Void
    
    // Other Section API
    @objc optional func getHomescreenAllsectionResponse(responseObj: NSDictionary) -> Void

//Tips Like & UnLike
    @objc optional func tipsLikeOrUnLikeResponse(responseObj: NSDictionary) -> Void
    
    
//Friend 
    
    //Friend List
    @objc optional func getFriendListResponse(responseObj: NSDictionary) -> Void
    
    //Send Friend Request 
    @objc optional func sendFriendRequestResponse(responseObj: NSDictionary) -> Void
    
}

class Webservice: AnyObject {

    var delegate: WebApiRequestDelegate?
    
    let requestTimeout = 10000000000.0
    
    let headers = [
        "content-type": "application/x-www-form-urlencoded",
        "cache-control": "no-cache",
        "postman-token": "a9be7ebe-cfac-776e-1a49-2ead3e577c51"
    ]
    
    
//MARK:- Register API Methods
    
    func register_Normal(strFirstName:String,strLastName:String,strEmail:String,strPassword:String){
        
        let str_Url:String = "\(kAPIBASEURL)\(kAPIRegisterNormal)"
        let dictPara : Dictionary = ["FirstName":strFirstName,"LastName":strLastName,"Email":strEmail,"Password":strPassword]
        if ISDebug {
            print("URL : \(str_Url) Parameters : \(dictPara)")
        }
        
        let postData = NSMutableData()
        
        let arrKey = Array(dictPara.keys)
        for i in 0..<arrKey.count {
            let strKey = arrKey[i]
            let valueKey = dictPara[strKey]
//            print("Key : \(strKey) Value : \(valueKey!)")
            
            if i == 0 {
                postData.append("\(strKey)=\(valueKey!)".data(using: String.Encoding.utf8)!)
            }else{
                postData.append("&\(strKey)=\(valueKey!)".data(using: String.Encoding.utf8)!)
            }
        }
        
//        let request = NSMutableURLRequest(url: NSURL(string: str_Url)! as URL,
//                                          cachePolicy: .useProtocolCachePolicy,
//                                          timeoutInterval: requestTimeout)
        var request: URLRequest = URLRequest(url: NSURL(string: str_Url)! as URL)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        request.timeoutInterval = requestTimeout
        
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            let httpResponse : HTTPURLResponse = response as! HTTPURLResponse
            let responseCode : Int = (httpResponse.statusCode)
            print(responseCode)
            if data != nil {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                    print(json)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                        self.delegate?.register_NormalResponse?(responseObj: json)
                    }
                } catch let error as NSError {
                    print(error)
                    let emptyDict = NSDictionary()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                        self.delegate?.register_NormalResponse?(responseObj: emptyDict)
                    }
                }
            } else {
                let emptyDict = NSDictionary()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                    self.delegate?.register_NormalResponse?(responseObj: emptyDict)
                }
            }
        
        })
    
        dataTask.resume()
}
    
    func register_Facebook(strFacebookID:String,strFirstName:String,LastName:String,Email:String,strProfileUrl:String){
        
        let str_Url:String = "\(kAPIBASEURL)\(kAPIRegisterFacebook)"
        let dictPara : Dictionary = ["FacebookID":strFacebookID,"FirstName":strFirstName,"LastName":LastName,"Email":Email,"ProfImgUrl":strProfileUrl]
        if ISDebug {
            print("URL : \(str_Url) Parameters : \(dictPara)")
        }
        
        let postData = NSMutableData()
        
        let arrKey = Array(dictPara.keys)
        for i in 0..<arrKey.count {
            let strKey = arrKey[i]
            let valueKey = dictPara[strKey]
//            print("Key : \(strKey) Value : \(valueKey!)")
            
            if i == 0 {
                postData.append("\(strKey)=\(valueKey!)".data(using: String.Encoding.utf8)!)
            }else{
                postData.append("&\(strKey)=\(valueKey!)".data(using: String.Encoding.utf8)!)
            }
        }
        
//        let request = NSMutableURLRequest(url: NSURL(string: str_Url)! as URL,
//                                          cachePolicy: .useProtocolCachePolicy,
//                                          timeoutInterval: requestTimeout)
        var request: URLRequest = URLRequest(url: NSURL(string: str_Url)! as URL)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        request.timeoutInterval = requestTimeout
        
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            let httpResponse : HTTPURLResponse = response as! HTTPURLResponse
            let responseCode : Int = (httpResponse.statusCode)
            print(responseCode)
            if data != nil {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                    print(json)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                        self.delegate?.register_FacebookResponse?(responseObj: json)
                    }
                } catch let error as NSError {
                    print(error)
                    let emptyDict = NSDictionary()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                        self.delegate?.register_FacebookResponse?(responseObj: emptyDict)
                    }
                }
            } else {
                let emptyDict = NSDictionary()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                    self.delegate?.register_FacebookResponse?(responseObj: emptyDict)
                }
            }
            
        })
        
        dataTask.resume()
    }
    
//MARK:- Login API Methods
    
    func login_Normal(strUsername:String,strPassword:String) {
        
        let str_Url:String = "\(kAPIBASEURL)\(kAPILoginNormal)"
        let dictPara : Dictionary = ["Username":strUsername,"Password":strPassword]
        if ISDebug {
            print("URL : \(str_Url) Parameters : \(dictPara)")
        }
        
        let postData = NSMutableData()
        
        let arrKey = Array(dictPara.keys)
        for i in 0..<arrKey.count {
            let strKey = arrKey[i]
            let valueKey = dictPara[strKey]
//            print("Key : \(strKey) Value : \(valueKey!)")
            
            if i == 0 {
                postData.append("\(strKey)=\(valueKey!)".data(using: String.Encoding.utf8)!)
            }else{
                postData.append("&\(strKey)=\(valueKey!)".data(using: String.Encoding.utf8)!)
            }
        }
        
//        let request = NSMutableURLRequest(url: NSURL(string: str_Url)! as URL,
//                                          cachePolicy: .useProtocolCachePolicy,
//                                          timeoutInterval: requestTimeout)
        var request: URLRequest = URLRequest(url: NSURL(string: str_Url)! as URL)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in

            let httpResponse : HTTPURLResponse = response as! HTTPURLResponse
            let responseCode : Int = (httpResponse.statusCode)
            print(responseCode)
            if data != nil {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                    print(json)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                        self.delegate?.login_NormalResponse?(responseObj: json)
                    }
                } catch let error as NSError {
                    print(error)
                    let emptyDict = NSDictionary()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                        self.delegate?.login_NormalResponse?(responseObj: emptyDict)
                    }
                }
            } else {
                let emptyDict = NSDictionary()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                    self.delegate?.login_NormalResponse?(responseObj: emptyDict)
                }
            }
        })
        dataTask.resume()

    }
    
    func login_Facebook(strUsername:String,strFacebookID:String) {
        
        let str_Url:String = "\(kAPIBASEURL)\(kAPILoginFacebook)"
        let dictPara : Dictionary = ["Username":strUsername,"FacebookID":strFacebookID]
        
        if ISDebug {
            print("URL : \(str_Url) Parameters : \(dictPara)")
        }
        
        let postData = NSMutableData()
        
        let arrKey = Array(dictPara.keys)
        for i in 0..<arrKey.count {
            let strKey = arrKey[i]
            let valueKey = dictPara[strKey]
//            print("Key : \(strKey) Value : \(valueKey!)")
            
            if i == 0 {
                postData.append("\(strKey)=\(valueKey!)".data(using: String.Encoding.utf8)!)
            }else{
                postData.append("&\(strKey)=\(valueKey!)".data(using: String.Encoding.utf8)!)
            }
        }
        
//        let request = NSMutableURLRequest(url: NSURL(string: str_Url)! as URL,
//                                          cachePolicy: .useProtocolCachePolicy,
//                                          timeoutInterval: requestTimeout)
        var request: URLRequest = URLRequest(url: NSURL(string: str_Url)! as URL)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        request.timeoutInterval = requestTimeout
        
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            let httpResponse : HTTPURLResponse = response as! HTTPURLResponse
            let responseCode : Int = (httpResponse.statusCode)
            print(responseCode)
            if data != nil {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                    print(json)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                        self.delegate?.login_FacebookResponse?(responseObj: json)
                    }
                } catch let error as NSError {
                    print(error)
                    let emptyDict = NSDictionary()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                        self.delegate?.login_FacebookResponse?(responseObj: emptyDict)
                    }
                }
            } else {
                let emptyDict = NSDictionary()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                    self.delegate?.login_FacebookResponse?(responseObj: emptyDict)
                }
            }
        })
        dataTask.resume()   
    }
    
    //MARK:- Forgot Password
    
    func forgotPassword(strEmail:String) {
        
        let str_Url:String = "\(kAPIBASEURL)\(kAPIForgotPassword)"
        let dictPara : Dictionary = ["Email":strEmail]
        
        if ISDebug {
            print("URL : \(str_Url) Parameters : \(dictPara)")
        }
        
        let postData = NSMutableData()
        
        let arrKey = Array(dictPara.keys)
        for i in 0..<arrKey.count {
            let strKey = arrKey[i]
            let valueKey = dictPara[strKey]
            //            print("Key : \(strKey) Value : \(valueKey!)")
            
            if i == 0 {
                postData.append("\(strKey)=\(valueKey!)".data(using: String.Encoding.utf8)!)
            }else{
                postData.append("&\(strKey)=\(valueKey!)".data(using: String.Encoding.utf8)!)
            }
        }
        
//        let request = NSMutableURLRequest(url: NSURL(string: str_Url)! as URL,
//                                          cachePolicy: .useProtocolCachePolicy,
//                                          timeoutInterval: requestTimeout)
        var request: URLRequest = URLRequest(url: NSURL(string: str_Url)! as URL)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        request.timeoutInterval = requestTimeout
        
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            let httpResponse : HTTPURLResponse = response as! HTTPURLResponse
            let responseCode : Int = (httpResponse.statusCode)
            print(responseCode)
            if data != nil {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                    print(json)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                        self.delegate?.forgotPasswordResponse?(responseObj: json)
                    }
                } catch let error as NSError {
                    print(error)
                    let emptyDict = NSDictionary()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                        self.delegate?.forgotPasswordResponse?(responseObj: emptyDict)
                    }
                }
            } else {
                let emptyDict = NSDictionary()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                    self.delegate?.forgotPasswordResponse?(responseObj: emptyDict)
                }
            }
        })
        dataTask.resume()
        
    }
    
    
    //MARK:- Get Profile Details
    
    func getUserProfileDetails(strUserID:String) -> Void {
        
        let str_Url:String = "\(kAPIBASEURL)\(kAPIUserDetails)"
        let dictPara : Dictionary = ["UserID":strUserID]
        
        if ISDebug {
            print("URL : \(str_Url) Parameters : \(dictPara)")
        }
        
        let postData = NSMutableData()
        
        let arrKey = Array(dictPara.keys)
        for i in 0..<arrKey.count {
            let strKey = arrKey[i]
            let valueKey = dictPara[strKey]
            //            print("Key : \(strKey) Value : \(valueKey!)")
            
            if i == 0 {
                postData.append("\(strKey)=\(valueKey!)".data(using: String.Encoding.utf8)!)
            }else{
                postData.append("&\(strKey)=\(valueKey!)".data(using: String.Encoding.utf8)!)
            }
        }
        
//        let request = NSMutableURLRequest(url: NSURL(string: str_Url)! as URL,
//                                          cachePolicy: .useProtocolCachePolicy,
//                                          timeoutInterval: requestTimeout)
        var request: URLRequest = URLRequest(url: NSURL(string: str_Url)! as URL)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        request.timeoutInterval = requestTimeout
        
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            let httpResponse : HTTPURLResponse = response as! HTTPURLResponse
            let responseCode : Int = (httpResponse.statusCode)
            print(responseCode)
            if data != nil {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                    print(json)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                        self.delegate?.getUserProfileDetailsResponse?(responseObj: json)
                    }
                } catch let error as NSError {
                    print(error)
                    let emptyDict = NSDictionary()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                        self.delegate?.getUserProfileDetailsResponse?(responseObj: emptyDict)
                    }
                }
            } else {
                let emptyDict = NSDictionary()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                    self.delegate?.getUserProfileDetailsResponse?(responseObj: emptyDict)
                }
            }
        })
        dataTask.resume()
    
    }
    
    //MARK:- Home screen Tips and List API
    
    func getNewAndTendingTips() {
        
        let str_Url:String = "\(kAPIBASEURL)\(kAPINewAndTrending)"
        
        if ISDebug {
            print("URL : \(str_Url)")
        }
        
        let postData = NSMutableData()
        
//        let request = NSMutableURLRequest(url: NSURL(string: str_Url)! as URL,
//                                          cachePolicy: .useProtocolCachePolicy,
//                                          timeoutInterval: requestTimeout)
        var request: URLRequest = URLRequest(url: NSURL(string: str_Url)! as URL)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        request.timeoutInterval = requestTimeout
        
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            let httpResponse : HTTPURLResponse = response as! HTTPURLResponse
            let responseCode : Int = (httpResponse.statusCode)
            print(responseCode)
            if data != nil {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                    print(json)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                        self.delegate?.getNewAndTendingTipsResponse?(responseObj: json)
                    }
                } catch let error as NSError {
                    print(error)
                    let emptyDict = NSDictionary()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                        self.delegate?.getNewAndTendingTipsResponse?(responseObj: emptyDict)
                    }
                }
            } else {
                let emptyDict = NSDictionary()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                    self.delegate?.getNewAndTendingTipsResponse?(responseObj: emptyDict)
                }
            }
        })
        dataTask.resume()
    }
    
    
    func getHome_alllist(strUserID:String) -> Void {
        
        let str_Url:String = "\(kAPIBASEURL)\(kAPIAllListHomeScreen)"
        let dictPara : Dictionary = ["UserID":strUserID]
        
        if ISDebug {
            print("AllList URL : \(str_Url) Parameters : \(dictPara)")
        }
        
        let postData = NSMutableData()
        
        let arrKey = Array(dictPara.keys)
        for i in 0..<arrKey.count {
            let strKey = arrKey[i]
            let valueKey = dictPara[strKey]
            //            print("Key : \(strKey) Value : \(valueKey!)")
            
            if i == 0 {
                postData.append("\(strKey)=\(valueKey!)".data(using: String.Encoding.utf8)!)
            }else{
                postData.append("&\(strKey)=\(valueKey!)".data(using: String.Encoding.utf8)!)
            }
        }
        
        //        let request = NSMutableURLRequest(url: NSURL(string: str_Url)! as URL,
        //                                          cachePolicy: .useProtocolCachePolicy,
        //                                          timeoutInterval: requestTimeout)
        var request: URLRequest = URLRequest(url: NSURL(string: str_Url)! as URL)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        request.timeoutInterval = requestTimeout
        
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            let httpResponse : HTTPURLResponse = response as! HTTPURLResponse
            let responseCode : Int = (httpResponse.statusCode)
            print(responseCode)
            if data != nil {
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                    print(json)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                        self.delegate?.getHomescreenAllsectionResponse?(responseObj: json)
                    }
                } catch let error as NSError {
                    print(error)
                    let emptyDict = NSDictionary()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                        self.delegate?.getHomescreenAllsectionResponse?(responseObj: emptyDict)
                    }
                }
            } else {
                let emptyDict = NSDictionary()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                    self.delegate?.getHomescreenAllsectionResponse?(responseObj: emptyDict)
                }
            }
        })
        dataTask.resume()
        
    }
    
    //MARK:- Tips related API
    
    func tipLikeUnlike(strUserID:String,strTipID:String) -> Void {
        
        let str_Url:String = "\(kAPIBASEURL)\(kAPITip_like_Unlike)"
        let dictPara : Dictionary = ["UserID":strUserID,"TipID":strTipID]
        
        if ISDebug {
            print("AllList URL : \(str_Url) Parameters : \(dictPara)")
        }
        
        let postData = NSMutableData()
        
        let arrKey = Array(dictPara.keys)
        for i in 0..<arrKey.count {
            let strKey = arrKey[i]
            let valueKey = dictPara[strKey]
            //            print("Key : \(strKey) Value : \(valueKey!)")
            if i == 0 {
                postData.append("\(strKey)=\(valueKey!)".data(using: String.Encoding.utf8)!)
            }else{
                postData.append("&\(strKey)=\(valueKey!)".data(using: String.Encoding.utf8)!)
            }
        }
        
        var request: URLRequest = URLRequest(url: NSURL(string: str_Url)! as URL)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        request.timeoutInterval = requestTimeout
        
        
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            let httpResponse : HTTPURLResponse = response as! HTTPURLResponse
            let responseCode : Int = (httpResponse.statusCode)
            print(responseCode)
            if data != nil {
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                    print(json)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                        self.delegate?.tipsLikeOrUnLikeResponse?(responseObj: json)
                    }
                } catch let error as NSError {
                    print(error)
                    let emptyDict = NSDictionary()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                        self.delegate?.tipsLikeOrUnLikeResponse?(responseObj: emptyDict)
                    }
                }
            } else {
                let emptyDict = NSDictionary()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                    self.delegate?.tipsLikeOrUnLikeResponse?(responseObj: emptyDict)
                }
            }
        })
        dataTask.resume()
    }
    
    //MARK:- Friends
    
    func getFriendList(strUserID:String) -> Void {
        
        let str_Url:String = "\(kAPIBASEURL)\(kAPIFriendList)"
        let dictPara : Dictionary = ["UserID":strUserID]
        
        if ISDebug {
            print("URL : \(str_Url) Parameters : \(dictPara)")
        }
        
        let postData = NSMutableData()
        
        let arrKey = Array(dictPara.keys)
        
        for i in 0..<arrKey.count {
            let strKey = arrKey[i]
            let valueKey = dictPara[strKey]
            //            print("Key : \(strKey) Value : \(valueKey!)")
            
            if i == 0 {
                postData.append("\(strKey)=\(valueKey!)".data(using: String.Encoding.utf8)!)
            }else{
                postData.append("&\(strKey)=\(valueKey!)".data(using: String.Encoding.utf8)!)
            }
        }
        
//        let request = NSMutableURLRequest(url: NSURL(string: str_Url)! as URL,
//                                          cachePolicy: .useProtocolCachePolicy,
//                                          timeoutInterval: requestTimeout)
        var request: URLRequest = URLRequest(url: NSURL(string: str_Url)! as URL)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        request.timeoutInterval = requestTimeout
        
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            
            let httpResponse : HTTPURLResponse = response as! HTTPURLResponse
            let responseCode : Int = (httpResponse.statusCode)
            print(responseCode)
            if data != nil {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                    print(json)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                        self.delegate?.getFriendListResponse?(responseObj: json)
                    }
                } catch let error as NSError {
                    print(error)
                    let emptyDict = NSDictionary()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                        self.delegate?.getFriendListResponse?(responseObj: emptyDict)
                    }
                }
            } else {
                let emptyDict = NSDictionary()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                    self.delegate?.getFriendListResponse?(responseObj: emptyDict)
                }
            }
        })
        dataTask.resume()
    }
    
    
    //MARK:- Send Friend Request
    
    func sendFriendRequest(strUserID:String,strFriendID:String) -> Void {
        
        let str_Url:String = "\(kAPIBASEURL)\(kAPIFriendList)"
        let dictPara : Dictionary = ["UserID":strUserID,"FriendID":strFriendID]
        
        if ISDebug {
            print("URL : \(str_Url) Parameters : \(dictPara)")
        }
        
        let postData = NSMutableData()
        
        let arrKey = Array(dictPara.keys)
        for i in 0..<arrKey.count {
            let strKey = arrKey[i]
            let valueKey = dictPara[strKey]
            
            if i == 0 {
                postData.append("\(strKey)=\(valueKey!)".data(using: String.Encoding.utf8)!)
            }else{
                postData.append("&\(strKey)=\(valueKey!)".data(using: String.Encoding.utf8)!)
            }
        }
        
//        let request = NSMutableURLRequest(url: NSURL(string: str_Url)! as URL,
//                                          cachePolicy: .useProtocolCachePolicy,
//                                          timeoutInterval: requestTimeout)
        var request: URLRequest = URLRequest(url: NSURL(string: str_Url)! as URL)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        request.timeoutInterval = requestTimeout
        
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            let httpResponse : HTTPURLResponse = response as! HTTPURLResponse
            let responseCode : Int = (httpResponse.statusCode)
            print(responseCode)
            if data != nil {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                    print(json)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                        self.delegate?.sendFriendRequestResponse?(responseObj: json)
                    }
                } catch let error as NSError {
                    print(error)
                    let emptyDict = NSDictionary()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                        self.delegate?.sendFriendRequestResponse?(responseObj: emptyDict)
                    }
                }
            } else {
                let emptyDict = NSDictionary()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                    self.delegate?.sendFriendRequestResponse?(responseObj: emptyDict)
                }
            }
        })
        dataTask.resume()
    }
    
    
    
    
    
    
    
}
