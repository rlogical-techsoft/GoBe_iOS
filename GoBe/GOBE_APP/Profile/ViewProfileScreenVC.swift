//  ViewProfileScreenVC.swift
//  GoBe
//
//  Created by rlogical-dev-11 on 10/07/17.
//  Copyright © 2017 rlogical-dev-35. All rights reserved.

import UIKit

class ViewProfileScreenVC: UIViewController,WebApiRequestDelegate {

    //MARK:- Class Reference
    
    let web = Webservice()
    let HUD = MBProgressHUD()
    
    
    //MARK:- IBOutlets
    @IBOutlet var img_Profile: UIImageView!
    
    @IBOutlet var lbl_Name: UILabel!
    
    @IBOutlet var txt_MySelfText: UITextView!
    @IBOutlet var txt_LiveORKnowText: UITextView!
    
    @IBOutlet var imgProfile: UIImageView!
    
    //UIButton
    @IBOutlet var btn_numberOfTips: UIButton!
    @IBOutlet var btn_numberOfLIKES: UIButton!
    @IBOutlet var btn_numberOfLISTS: UIButton!
    @IBOutlet var btn_numberOfLIKEDLISTS: UIButton!
    
    @IBOutlet var btn_numberOfFRIENDS: UIButton!
    @IBOutlet var btn_numberOfFOLLOWERS: UIButton!
    @IBOutlet var btn_numberOfFOLLOWING: UIButton!
    
    
    //MARK:- Variable
    
    
    //MARK:- UIView Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //For Textview Content offset
     
        //At the time of display blank
        lbl_Name.text = ""
        
        
        web.delegate = self
        self.view.addSubview(HUD)
        
        Constants.setBorderTo(imgProfile, withBorderWidth: 1, radiousView: Float(imgProfile.frame.size.height/2), color: UIColor.gray)
        
        //Get Profile
        self.perform(#selector(getProfile), with: nil, afterDelay: 0.1)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        txt_MySelfText.textContainerInset = UIEdgeInsets.zero
        txt_MySelfText.textContainer.lineFragmentPadding = 0
        
        txt_LiveORKnowText.textContainerInset = UIEdgeInsets.zero
        txt_LiveORKnowText.textContainer.lineFragmentPadding = 0
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- UIButton Action
    @IBAction func btnAction_Back(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAction_Edit(_ sender: Any) {
        
        let objEdit = self.storyboard?.instantiateViewController(withIdentifier: kView_EditProfile)
        self.navigationController?.pushViewController(objEdit!, animated: true)
    }
    
    @IBAction func btnAction_Home(_ sender: Any){
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        
        for vc in viewControllers {
            
            if vc is HomeViewVC{
                self.navigationController!.popToViewController(vc, animated: true)
                return
            }
        }
    }
    
    @IBAction func btnAction_Logout(_ sender: Any){
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        
        userDefault.setValue(nil, forKey: kUserDefaultUserModel)
        appDel.instanceModelLogin = ModelLogin()
        
        for aViewController in viewControllers {
            if aViewController is ViewController {
                self.navigationController!.popToViewController(aViewController, animated: true)
                return
            }
        }
        
        //If Not containt ViewContrller screen then We have to Push Login View Controller
        let navigationController : UINavigationController = self.storyboard?.instantiateViewController(withIdentifier: knavi_Start) as! UINavigationController
        
        let rootViewController : UIViewController = (self.storyboard?.instantiateViewController(withIdentifier: kView_StartViewVC))!
       
        navigationController.viewControllers = [rootViewController]
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = navigationController
        
    }
    
    //MARK:- UIWebservices Methods
    
    func getProfile() {
        
        HUD.show(true)
        web.getUserProfileDetails(strUserID: appDel.instanceModelLogin.UserID)
    }
    
    func getUserProfileDetailsResponse(responseObj: NSDictionary) -> Void {
        
        HUD.hide(true)
        
        let responseAllKey : NSArray = responseObj.allKeys as NSArray
        print("Print Array Keys : \(responseAllKey)")
        
        if responseAllKey.contains(kAPI_Status) {
            
            if let statusCode : Int = responseObj.value(forKey: kAPI_Status) as? Int {
                if statusCode == 200 {
                    
                    if ISDebug {
                        print("User Profile Response : \(responseObj)")
                    }
                    
                    let strFName = responseObj.object(forKey: "FirstName") as? String
                    let strLName = responseObj.object(forKey: "LastName") as? String
                    lbl_Name.text = strFName! + " " + strLName!
                    
                    if let strAboutMe = responseObj.value(forKey: "About") as? String {
                        txt_MySelfText.text = strAboutMe
                    }else{
                        txt_MySelfText.text = ""
                    }

                    if let strPlaces = responseObj.value(forKey: "Places") as? String{
                        txt_LiveORKnowText.text = strPlaces
                    }else{
                        txt_LiveORKnowText.text = ""
                    }
                    
                    if let intTIPS = responseObj.value(forKey: "TipNumber") as? String {
                        btn_numberOfTips.setTitle("\(intTIPS) TIPS", for: .normal)
                    }
                    
                    if let intLIKES = responseObj.value(forKey: "LikeNumber") as? Int {
                        btn_numberOfLIKES.setTitle("\(intLIKES) LIKES", for: .normal)
                    }
                    
                    if let intLISTS = responseObj.value(forKey: "ListNumber") as? String {
                        btn_numberOfLISTS.setTitle("\(intLISTS) LISTS", for: .normal)
                    }
                    
                    if let intLIKEDLISTS = responseObj.value(forKey: "ListLikeNumber") as? String {
                        btn_numberOfLIKEDLISTS.setTitle("\(intLIKEDLISTS) LIKED LISTS", for: .normal)
                    }
                    
                    if let intFRIENDS = responseObj.value(forKey: "FriendNumber") as? String {
                        btn_numberOfFRIENDS.setTitle("\(intFRIENDS) FRIENDS", for: .normal)
                    }
                    
                    if let intFOLLOWERS = responseObj.value(forKey: "FollowerNumber") as? String {
                        btn_numberOfFOLLOWERS.setTitle("\(intFOLLOWERS) FOLLOWERS", for: .normal)
                    }
                    
                    if let intFOLLOWING = responseObj.value(forKey: "FollowingNumber") as? String {
                        btn_numberOfFOLLOWING.setTitle("\(intFOLLOWING) FOLLOWING", for: .normal)
                    }
                    
                    
                }else{
                    
                    if ISDebug {
                        print("Get Profile Error:\(responseObj.value(forKey: kAPI_Msg) as! String)")
                    }
                    
                    if responseAllKey.contains(kAPI_Msg) {
                        
                        if let strMessage = responseObj.value(forKey: kAPI_Msg) as? String {
                            Constants.showAlertTitle(kAlertAppName, messageStr: strMessage, viewController: self)
                        }
                    }
                }
            }
        }
    }
    
    
}
