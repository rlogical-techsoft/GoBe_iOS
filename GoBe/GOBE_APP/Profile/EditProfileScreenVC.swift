//
//  EditProfileScreenVC.swift
//  GoBe
//
//  Created by rlogical-dev-11 on 14/07/17.
//  Copyright © 2017 rlogical-dev-35. All rights reserved.
//

import UIKit

class EditProfileScreenVC: UIViewController,WebApiRequestDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    //MARK:- Class Reference
    let web = Webservice()
    let HUD = MBProgressHUD()
    
    //MARK:- IBOutlets
    
    @IBOutlet var lbl_UserName: UILabel!
    
    @IBOutlet var imgProfile: UIImageView!
    
    @IBOutlet var txt_AboutMySelf: UITextView!
    @IBOutlet var txt_ListOfPlace: UITextView!
    
    //MARK:- Variable
    
    var imagePickerViewController = UIImagePickerController()
    
    
    
    //MARK:- UIView Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        web.delegate = self
        self.view.addSubview(HUD)
        
        //Image PickerView Controller
        imagePickerViewController.allowsEditing = true
        imagePickerViewController.delegate = self
        
        txt_AboutMySelf.text = ""
        txt_ListOfPlace.text = ""
        
        //Get Profile
        self.perform(#selector(getProfile), with: nil, afterDelay: 0.1)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        Constants.setBorderTo(imgProfile, withBorderWidth: 1, radiousView: Float(imgProfile.frame.size.height/2), color: UIColor.gray)
        
        txt_AboutMySelf.textContainerInset = UIEdgeInsets.zero
        txt_AboutMySelf.textContainer.lineFragmentPadding = 0
        
        txt_ListOfPlace.textContainerInset = UIEdgeInsets.zero
        txt_ListOfPlace.textContainer.lineFragmentPadding = 0
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- UIButton Action
    
    @IBAction func btnAction_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAction_Home(_ sender: Any) {
        self.navigationBackToHomeScreen()
    }
    
    @IBAction func btnAction_NEXT(_ sender: Any) {
        
        self.navigateToOtherScreen(strView: kView_ProfileInterestedTopic)
    }
    
    @IBAction func btnAction_SelectPhotos(_ sender: Any) {
        
        self.OpenActionSheetForImage()
    }
    
    //MARK:- UIImagePicker View Controller
    
    func OpenActionSheetForImage() -> Void {
        
        let alertController = UIAlertController(title: "Select Profile Picture", message: "Please select an image picker method", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Take a picture", style: .default, handler: { action in
          
            self.imagePickerViewController.sourceType = .camera
            self.present(self.imagePickerViewController, animated: true, completion:nil)
        })
        
        let cameraRoll = UIAlertAction(title: "Choose from Album", style: .default, handler: { action in
            
            self.imagePickerViewController.sourceType = .photoLibrary
            self.present(self.imagePickerViewController, animated: true, completion:nil)
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        
        alertController.addAction(cameraAction)
        alertController.addAction(cameraRoll)
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    //MARK:- UIImagePickerViewController Delegate
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:  [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            imgProfile.image = pickedImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
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
                    lbl_UserName.text = strFName! + " " + strLName!
                    
                    if let strAboutMe = responseObj.value(forKey: "About") as? String {
                        txt_AboutMySelf.text = strAboutMe
                    }else{
                        txt_AboutMySelf.text = ""
                    }
                    
                    if let strPlaces = responseObj.value(forKey: "Places") as? String{
                        txt_ListOfPlace.text = strPlaces
                    }else{
                        txt_ListOfPlace.text = ""
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
    
    
    
    //MARK: - Navigation
    func navigationBackToHomeScreen() -> Void {
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        
        for vc in viewControllers {
            if vc is HomeViewVC{
                self.navigationController!.popToViewController(vc, animated: true)
                return
            }
        }
    }
    
    func navigateToOtherScreen(strView : String) -> Void {
        
        let objEditProfile = self.storyboard?.instantiateViewController(withIdentifier: strView)
        self.navigationController?.pushViewController(objEditProfile!, animated: true)
    }
    
}



