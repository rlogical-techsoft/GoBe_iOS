//  ModelLogin.swift
//  GoBe
//
//  Created by rlogical-dev-11 on 04/07/17.
//  Copyright © 2017 rlogical-dev-35. All rights reserved.
//

import UIKit

class ModelLogin: NSObject {

    //MARK:- Variable
    var Email     : String = ""
    var FirstName : String = ""
    var LastName  : String = ""
    var LoginType : String = ""
    var Password  : String = ""
    var UserID    : String = ""
    var msg       : String = ""
    var ProfImgUrl: String = ""
    
    //MARK:- Methods
    
    override init() {
        Email      = ""
        FirstName  = ""
        LastName   = ""
        LoginType  = ""
        Password   = ""
        UserID     = ""
        msg        = ""
        ProfImgUrl = ""
        
    }
    
    init(dictResult:NSDictionary) {
        
        let arrAllKeysOfDict : NSArray = dictResult.allKeys as NSArray
        
        if arrAllKeysOfDict.contains("Email") {
            self.Email = dictResult.value(forKey: "Email") as! String
        }
        
        if arrAllKeysOfDict.contains("FirstName") {
            self.FirstName = dictResult.value(forKey: "FirstName") as! String
        }
        
        if arrAllKeysOfDict.contains("LastName") {
            self.LastName = dictResult.value(forKey: "LastName") as! String
        }
        
        if arrAllKeysOfDict.contains("LoginType") {
            self.LoginType = dictResult.value(forKey: "LoginType") as! String
        }
        
        if arrAllKeysOfDict.contains("Password") {
            self.Password = dictResult.value(forKey: "Password") as! String
        }
        
        if arrAllKeysOfDict.contains("UserID") {
            
            let UserID = dictResult.value(forKey: "UserID") as? String
            
            if let strUserID = UserID {
                self.UserID = "\(strUserID)"
            }
            
            if ISDebug {
                print("User ID : \(self.UserID)")
            }
        }
        
        if arrAllKeysOfDict.contains("ProfImgUrl") {
            self.ProfImgUrl = dictResult.value(forKey: "ProfImgUrl") as! String
        }
        
        if arrAllKeysOfDict.contains("msg") {
            self.msg = dictResult.value(forKey: "msg") as! String
        }
        
        
    }
    
}
