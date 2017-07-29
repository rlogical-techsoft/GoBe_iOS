//
//  Constants.swift
//  paymobile
//
//  Created by James Amo on 21/06/2016.
//  Copyright © 2016 PayAngel. All rights reserved.
//

import UIKit
import Foundation

let userDefault = UserDefaults.standard
let appDel = UIApplication.shared.delegate as! AppDelegate


let ISDebug = true

let SUCCESS_RESULTCODE = "00000001"
let RESP_VERIFY_PASSCODE = "000000041"
let RESP_USER_NOT_REGISTERED = "00000002"

let kAlertAppName = "GoBe!"


//MARK:- UINavigation StoryBoard ID
let knavi_Start             = "navi_Start"


//MARK:- UIViewController StoryBoard ID

let kView_StartViewVC            =  "ViewController"
let kView_HomeViewVC             =  "HomeViewVC"

let kView_RegisterVC             =  "RegisterViewController"
let kView_LoginVC                =  "LoginViewController"

let kView_ProfileVC              =  "ViewProfileScreenVC"
let kView_EditProfile            =  "EditProfileScreenVC"
let kView_ProfileInterestedTopic =  "ProfileInterestedTopicViewController"

let kVIew_YOURLISTS              =  "YOURLISTSVC"

//MARK:- UserDefault
let kUserDefaultUserModel   =  "UserDefaultForLoginUserDetails"


//colors
let WHITE = UIColor.white

//MARK:- API Base

let kAPIBASEURL    = "http://demos.bitoutlet.com/gobe/"


let kAPI_Status    = "status"
let kAPI_Msg       = "msg"

//MARK:- Register

let kAPIRegisterNormal      = "registration"
let kAPIRegisterFacebook    = "facebook-registration"

//MARK:- Login

let kAPILoginNormal         = "login"
let kAPILoginFacebook       = "facebook-login"

//MARK:- Forgot Password
let kAPIForgotPassword      = "forget-password"

//MARK:- User Details
let kAPIUserDetails         = "user-details"
let kAPIEditUserProfile     = "edit-user-profile"

//MARK:- Profile Topics
let kAPIAllTopicList        = "topic-list"

//MARK:- AllSection Home screen
let kAPINewAndTrending      = "new-n-trending"

//MARK:- Tips Related API
let kAPITip_like_Unlike     = "tip-like-unlike"

//MARK:- List Related API
let kAPIList_like_unlike    = "list-like-unlike"

let kAPIAllListHomeScreen   = "all-list"

//MARK:- Friend
let kAPIFriendList          = "friend-list"


let APP_USERNAME = "iosuser"
let APP_PASSWORD = "5f5606f140aa9cafe3c34ce3bd6f2753de91e3ede6fa64cee908f2274655c7cb"
let APP_APPLICATION_CODE = "APP001"
let APP_COMCHANNEL = "IOS"
//009395

class Constants
{
    
    //MARK:- Device frame
    static let screenSize = UIScreen.main.bounds
    static let WIDTH = screenSize.width
    static let HEIGHT = screenSize.height

    
    //MARK:- Class
    static let app_delegate = ((UIApplication.shared.delegate as! AppDelegate))
    static let UserDefaults = Foundation.UserDefaults.standard
    
    //MARK:- FONT
    static let setFont = "Larsseit-Regular"
    static let setFontLight = "Larsseit-Light"
    static let setFontBold = "Larsseit-Bold"
    static let setFontMedium = "Larsseit-Medium"
    static let setFontItalic = "Larsseit-Italic"

    
    //MARK:- UIView Methods
    static func setBorderTo(_ view: UIView, withBorderWidth widthView: Float, radiousView: Float, color bordercolor: UIColor) {
        view.layer.borderWidth = CGFloat(widthView)
        view.layer.borderColor = bordercolor.cgColor
        view.layer.cornerRadius = CGFloat(radiousView)
        view.layer.masksToBounds = true
    }
    
    //MARK:- UIcolor Methods
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    // MARK: - AlertView
    static func showAlertTitle(_ titleStr: String,messageStr: String , viewController : UIViewController) {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        viewController.present(alert, animated: true) {
        }
    }
    
}

