//
//  RegisterViewController.swift
//  GoBe
//
//  Created by rlogical-dev-35 on 22/06/17.
//  Copyright © 2017 rlogical-dev-35. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKShareKit

class RegisterViewController: UIViewController,WebApiRequestDelegate {

    let web = Webservice()
    let HUD = MBProgressHUD()
    
    //MARK:- IBOutlets
    
    @IBOutlet var img_Background: UIImageView!
    
    @IBOutlet weak var btn_register: UIButton!
    @IBOutlet weak var lbl_charpass: UILabel!
    @IBOutlet weak var txt_password: UITextField!
    @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var txt_lastName: UITextField!
    @IBOutlet weak var txt_firstName: UITextField!
    
    @IBOutlet var lbltoastLabel : UILabel!
    
    @IBOutlet var lblAlreadyRegisteredLogin: UILabel!
    
    
    //MARK:- Variable
    let arrBackgroundImages : NSArray = ["Background1.png","Background2.png","Background3.png"]
    
    private var _fbLoginManager: FBSDKLoginManager?
    var yPosition: CGFloat = 0.0
    var width: CGFloat = 0.0

    //MARK:- UIView Methods
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        web.delegate = self
        self.view.addSubview(HUD)
        
        self.TextfieldProperitiesSet()
        txt_password.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        
        self.createGradientLayer()
        
        self.loadBackGroundImage()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        lbltoastLabel.layer.cornerRadius = 8;
        lbltoastLabel.clipsToBounds  =  true
        lbltoastLabel.isHidden = true
        
        lblAlreadyRegisteredLogin.font = UIFont(name: "Larsseit", size: 13)
    }
    
    //MARK:- Background Image
    
    func loadBackGroundImage() -> Void {
        /*
         let randomNum:UInt32 = arc4random_uniform(3)
         print("Image\(arrBackgroundImages.object(at: Int(randomNum)))")
         
         if let strImageName : String = arrBackgroundImages.object(at: Int(randomNum)) as? String {
         img_Background.image = UIImage(named: strImageName)
         }
         */
        img_Background.image = Constants.app_delegate.imageBG
        
    }

    //MARK:- UITextfiled Methods
    
    //Textfield placeHolder Color
    func TextfieldProperitiesSet()
    {
        
        txt_firstName.attributedPlaceholder = NSAttributedString(string: "First Name",
                                                                 attributes: [NSForegroundColorAttributeName: UIColor.black])
        txt_lastName.attributedPlaceholder = NSAttributedString(string: "Last Name",
                                                                attributes: [NSForegroundColorAttributeName: UIColor.black])
        txt_Email.attributedPlaceholder = NSAttributedString(string: "Email",
                                                             attributes: [NSForegroundColorAttributeName: UIColor.black])
        txt_password.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                attributes: [NSForegroundColorAttributeName: UIColor.black])
    }
    

    //TextFiels DidChange
    func textFieldDidChange(_ textField: UITextField) {
        
        if txt_password.text == ""
        {
            lbl_charpass.isHidden = false
        } else {
            lbl_charpass.isHidden = true
        }
    }
    
    //Textfield return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = textField.resignFirstResponder()
        return true
    }
    
    //Set background gradiant color
    func createGradientLayer()
    {   
        let gradient:CAGradientLayer = CAGradientLayer()
        let color3 = (UIColor(red:95.0/255.0, green:194.0/255.0, blue:255.0/255.0, alpha:1.0)).cgColor
        let color2 = (UIColor(red:127.0/255.0, green:243.0/255.0, blue:255.0/255.0, alpha:0.8)).cgColor
        
        gradient.colors = [ color2,color3]
        gradient.frame = btn_register.bounds
        gradient.cornerRadius = 5
        btn_register.layer.addSublayer(gradient)

    }

    //MARK:- ShowToast
    
    func showToast(message : String) {
        
        lbltoastLabel.text = message
        lbltoastLabel.isHidden = false
        lbltoastLabel.alpha = 1.0
        
        UIView.animate(withDuration: 6.0, delay: 0.1, options: .curveEaseOut, animations: {
            
            self.lbltoastLabel.alpha = 0.0
            
        }, completion: {(isCompleted) in
        
        })
    }
    
    
    //MARK:- UIButton Action
    
    @IBAction func btnActtion_Register(_ sender: Any) {
        
        //keyborad Hide
        txt_Email.resignFirstResponder()
        txt_password.resignFirstResponder()
        txt_firstName.resignFirstResponder()
        txt_lastName.resignFirstResponder()
        
        if !validationPassed(){
            return
        }
        HUD.show(true)
        web.register_Normal(strFirstName: txt_firstName.text!, strLastName: txt_lastName.text!, strEmail: txt_Email.text!, strPassword: txt_password.text!)
        
    }

    @IBAction func btn_AlreadyLoginClick(_ sender: Any) {
        
        lblAlreadyRegisteredLogin.font = UIFont(name: "Larsseit-Bold", size: 13)
        
        var isPageFound = false
        for viewController in (self.navigationController?.viewControllers)!.reversed() {
            if viewController is LoginViewController {
                isPageFound = true
            }
        }
        
        if isPageFound{
            self.navigationController?.popViewController(animated: false)
        }else{
            self.navigateToScreen(strView: kView_LoginVC)
        }
    }

    @IBAction func btn_FBClick(_ sender: Any) {
        
        self.faceBooKPressed(sender: self)
    }
    
    //MARK:- Facebooks Methods
    
    func faceBooKPressed(sender : AnyObject)
    {
        
        var fbLoginManager: FBSDKLoginManager {
            get {
                if _fbLoginManager == nil {
                    _fbLoginManager = FBSDKLoginManager()
                }
                return _fbLoginManager!
            }
        }
        fbLoginManager.logIn(withReadPermissions: ["email","public_profile"], handler: { (result, error) -> Void in
            if (error != nil){
                print(error)
                
                if let msg : String = error?.localizedDescription{
                    self.showToast(message:msg)
                }
            }
            else if ((result?.isCancelled) == false)
            {
                guard let fbloginresult : FBSDKLoginManagerLoginResult = result else { return }
                
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    
                    if((FBSDKAccessToken.current()) != nil){
                        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large),email,gender"]).start(completionHandler: { (connection, result, error) -> Void in
                            if (error == nil){
                                
                                let userData = result as! NSDictionary
                                print(userData)
                                
                                
                                let FBuserid = userData.object(forKey: "id") as? String
                                let email = userData.object(forKey: "email") as? String
                                let firstname = userData.object(forKey: "first_name") as? String
                                let last_name = userData.object(forKey: "last_name") as? String
                                
                                let dictPicture = userData.object(forKey: "picture") as? NSDictionary
                                let dictData = dictPicture?.object(forKey: "data") as? NSDictionary
                                let profileURL = dictData?.object(forKey: "url") as? String
//                                let profileURL = profileURLWithSpace?.replacingOccurrences(of: " ", with: "%20")
                                
                                
                                self.HUD.show(true)
                                self.web.register_Facebook(strFacebookID: FBuserid!, strFirstName: firstname!, LastName: last_name!, Email: email ?? "",strProfileUrl: profileURL ?? "")
  
                            }
                            else {
                                
                            }
                        })
                    }
                    self._fbLoginManager?.logOut()
                    self._fbLoginManager = nil
                }
            }
            else
            {
                _ = NSError(domain: "payangel", code: 9090, userInfo: nil)
                print("Is Cancelled - Result=\(String(describing: result))")
            }
        })
    }

    
    //MARK:- Check validaiton
    func validationPassed() -> Bool
    {
        
        let email = txt_Email.text ?? ""
        let password = txt_password.text ?? ""
        let firstName = txt_firstName.text ?? ""
        let lastName = txt_lastName.text ?? ""
        
        if email == "" && password == "" && firstName == "" && lastName == "" {
            showToast(message: "Please fill all information")
            return false
        }
        
        if firstName == ""{
            showToast(message: "Firstname is empty")
            return false
        }
        
        if lastName == ""{
            showToast(message: "LastName is empty")
            return false
        }
        
        if email == ""{
            showToast(message: "Email is empty")
            return false
        }
        
        let cemail = email.trimmingCharacters(in: .whitespaces)
        if cemail.isValidEmail == false{
            showToast(message: "Invalid Email")
            return false
        }
        
        if password == ""{
            showToast(message: "Password is empty")
            return false
        }
        
        if password.characters.count < 8{
            showToast(message: "Paswword must be 8 character")
            return false
        }
        return true
    }
    

    // MARK: - Webservices Delegate Methods
    
    func register_NormalResponse(responseObj: NSDictionary) -> Void{
        
        HUD.hide(true)
        
        let responseAllKey : NSArray = responseObj.allKeys as NSArray
        print("Print Array Keys : \(responseAllKey)")
        
        if responseAllKey.contains(kAPI_Status) {
            
            if let statusCode : Int = responseObj.value(forKey: kAPI_Status) as? Int {
                if statusCode == 200
                {
                    print("Simple Register True")

                    userDefault.setValue(responseObj, forKey: kUserDefaultUserModel)
                    appDel.instanceModelLogin = ModelLogin(dictResult: responseObj)
                    
                    //navigateTo Home screen
                    self.navigateToScreen(strView: kView_HomeViewVC)
                }
                else{
                    print("Simple Register False")
                    
                    if responseAllKey.contains(kAPI_Msg) {
                        showToast(message: responseObj.value(forKey: kAPI_Msg) as! String)
                    }
                }
            }
        }
    }
    
    func register_FacebookResponse(responseObj: NSDictionary) -> Void{
        
        HUD.hide(true)
        
        let responseAllKey : NSArray = responseObj.allKeys as NSArray
        print("Print Array Keys : \(responseAllKey)")
        
        if responseAllKey.contains(kAPI_Status) {
            
            if let statusCode : Int = responseObj.value(forKey: kAPI_Status) as? Int {
                if statusCode == 200
                {
                    print("Facebook Register True")
                    
                    userDefault.setValue(responseObj, forKey: kUserDefaultUserModel)
                    appDel.instanceModelLogin = ModelLogin(dictResult: responseObj)
                    
                    //navigateTo Home screen
                    self.navigateToScreen(strView: kView_HomeViewVC)
                }
                else{
                    print("Facebook Register False")
                    
                    if responseAllKey.contains(kAPI_Msg) {
                        showToast(message: responseObj.value(forKey: kAPI_Msg) as! String)
                    }
                }
            }
        }
    }
    
    
    // MARK: - Navigation
    
    func navigateToScreen(strView:String) -> Void {
        
        let objHomeView = self.storyboard?.instantiateViewController(withIdentifier: strView)
        self.navigationController?.pushViewController(objHomeView!, animated: false)
    }
    
    
}

