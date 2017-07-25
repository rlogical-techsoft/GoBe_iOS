//
//  LoginViewController.swift
//  GoBe
//
//  Created by rlogical-dev-35 on 23/06/17.
//  Copyright © 2017 rlogical-dev-35. All rights reserved.

import UIKit
import FBSDKLoginKit
import FBSDKShareKit

class LoginViewController: UIViewController,WebApiRequestDelegate {

    //MARK:- Class Reference
    
    let web = Webservice()
    let HUD = MBProgressHUD()
    
    
    //MARK:- IBOutlets
    @IBOutlet var img_Background: UIImageView!
    @IBOutlet var lbltoastLabel : UILabel!
    @IBOutlet weak var btn_login: UIButton!
    @IBOutlet weak var btn_forgotpsw: UIButton!
    @IBOutlet weak var txt_password: UITextField!
    @IBOutlet weak var txt_username: UITextField!
    
    @IBOutlet var lblNewToGoBeRegister: UILabel!
    
    
    //MARK:- Variable
    
    let arrBackgroundImages : NSArray = ["Background1.png","Background2.png","Background3.png"]
    
    private var _fbLoginManager: FBSDKLoginManager?
    var yPosition: CGFloat = 0.0
    var width: CGFloat = 0.0
    
    //MARK:- UIView Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        web.delegate = self
        self.view.addSubview(HUD)

        self.TextfieldProperitiesSet()
        
        //Forgot button set border and color
        let borderAlpha : CGFloat = 1.0
        let cornerRadius : CGFloat = 5.0
        btn_forgotpsw.backgroundColor = UIColor.clear
        btn_forgotpsw.layer.borderWidth = 2.5
        btn_forgotpsw.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).cgColor
        btn_forgotpsw.layer.cornerRadius = cornerRadius

        self.createGradientLayer()
        
        self.loadBackGroundImage()
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
     
        lblNewToGoBeRegister.font = UIFont(name: "Larsseit", size: 13)
    }

    //MARK:- UITextField Delegate
    
    func TextfieldProperitiesSet()
    {
        txt_password.attributedPlaceholder = NSAttributedString(string: "Password",                                                                 attributes: [NSForegroundColorAttributeName: UIColor.black])
        txt_username.attributedPlaceholder = NSAttributedString(string: "Email",                                                                 attributes: [NSForegroundColorAttributeName: UIColor.black])
    }
    
    func setFontBoldWhenTapped()
    {
        
        UIView.animate(withDuration: 1.0, animations: {() -> Void in
            
            self.btn_login.titleLabel!.font =  UIFont(name: "Larsseit-Bold", size: 13.0)
        })

    }
    
    func setFontMediumWhenTapped()
    {
        
    }
    
    //Set background gradiant color
    func createGradientLayer()
    {
        let gradient:CAGradientLayer = CAGradientLayer()
        let color3 = (UIColor(red:95.0/255.0, green:194.0/255.0, blue:255.0/255.0, alpha:0.8)).cgColor
        let color2 = (UIColor(red:127.0/255.0, green:243.0/255.0, blue:255.0/255.0, alpha:1.0)).cgColor
        
        gradient.colors = [color2, color3]
        gradient.frame = btn_login.bounds
        gradient.cornerRadius = 5
        btn_login.layer.addSublayer(gradient)
        gradient.isOpaque=true
    }

    //MARK:- UIButton Action 
    
    @IBAction func btn_forgotPswClick(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Forgot Password", message: "Please enter your email", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Done", style: .default) { (_) in
            if let field = alertController.textFields![0] as? UITextField {
                // store your data
                print("Emial ID: \(String(describing: field.text))")
                
                self.forgotPassword(strEmail: field.text ?? "")
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Email Address"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func btn_FbLoginClick(_ sender: Any) {
        
        self.faceBooKPressed(sender: self)
    }

    @IBAction func btnAction_Register(_ sender: Any){
        
        lblNewToGoBeRegister.font = UIFont(name: "Larsseit-Bold", size: 13)
        
        var isPageFound = false
        for viewController in (self.navigationController?.viewControllers)!.reversed() {
            if viewController is RegisterViewController {
                isPageFound = true
            }
        }

        if isPageFound{
            self.navigationController?.popViewController(animated: false)
        }else{
            self.navigateToScreen(strView: kView_RegisterVC)
        }
    }
    
    
    @IBAction func btn_LoginClick(_ sender: Any)
    {
        //btn_login.titleLabel!.font =  UIFont(name: "Larsseit-Bold", size: 20)
        //self.perform(#selector(setFontBoldWhenTapped), with: nil, afterDelay: 2.0)
        
        //keyborad Hide
        txt_username.resignFirstResponder()
        txt_password.resignFirstResponder()

        if !validationPassed(){
            return
        }
        
        HUD.show(true)
        web.login_Normal(strUsername: txt_username.text!, strPassword: txt_password.text!)
    }

    //MARK:- Screen Valication
    
    func validationPassed() -> Bool
    {
        let username = txt_username.text ?? ""
        let password = txt_password.text
        
        if password == "" && username == "" {
            showToast(message: "Email and password is empty")
            return false
        }
        
        if username == ""{
            showToast(message: "Email is empty")
            return false
        }
        if password == ""{
            showToast(message: "Password is empty")
            return false
        }

        let cemail = username.trimmingCharacters(in: .whitespaces)
        if cemail.isValidEmail == false{
            
            showToast(message: "Invalid Email")
            return false
        }

        return true
    }
    
    //MARK:- Show Toast
    
    func showToast(message : String) {

        lbltoastLabel.text = message
        lbltoastLabel.isHidden = false
        lbltoastLabel.alpha = 1.0
        
        UIView.animate(withDuration: 10.0, delay: 0.0, options: [], animations: {
            self.lbltoastLabel.alpha = 0.0
        }, completion: { (finished: Bool) in
            
        })
    }

    //MARK:- TextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = txt_password.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 8 // Bool
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
                                let FBuserid = userData.object(forKey: "id") as? String
                                let email = userData.object(forKey: "email") as? String
                                let firstname = userData.object(forKey: "first_name") as? String
                                let last_name = userData.object(forKey: "last_name") as? String
                                print(userData)
                                
                                self.HUD.show(true)
                                self.web.login_Facebook(strUsername: email ?? "", strFacebookID: FBuserid!)
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
    
    // MARK: - Webservices Delegate Methods
    
    func login_NormalResponse(responseObj: NSDictionary) -> Void
    {
        HUD.hide(true)
        
        let responseAllKey : NSArray = responseObj.allKeys as NSArray
        print("Print Array Keys : \(responseAllKey)")
        
        if responseAllKey.contains(kAPI_Status) {
            
            if let statusCode : Int = responseObj.value(forKey: kAPI_Status) as? Int {
                if statusCode == 200
                {
                    if ISDebug{
                        print("Simple Login True response \(responseObj)")
                    }
                    
                    userDefault.setValue(responseObj, forKey: kUserDefaultUserModel)
                    appDel.instanceModelLogin = ModelLogin(dictResult: responseObj)
                    
                    //navigateTo Home screen
                    self.navigateToScreen(strView: kView_HomeViewVC)
                }
                else{
                    
                    if ISDebug{
                        print("Simple Login False")
                    }
                    
                    if responseAllKey.contains(kAPI_Msg) {
                        showToast(message: responseObj.value(forKey: kAPI_Msg) as! String)
                    }
                }
            }
        }
    }
    
    func login_FacebookResponse(responseObj: NSDictionary) -> Void{
        
        HUD.hide(true)
        
        let responseAllKey : NSArray = responseObj.allKeys as NSArray
        print("Print Array Keys : \(responseAllKey)")
        
        if responseAllKey.contains(kAPI_Status) {
            
            if let statusCode : Int = responseObj.value(forKey: kAPI_Status) as? Int {
                if statusCode == 200
                {
                    if ISDebug{
                        print("facebook Login True response \(responseObj)")
                    }
                    
                    userDefault.setValue(responseObj, forKey: kUserDefaultUserModel)
                    appDel.instanceModelLogin = ModelLogin(dictResult: responseObj)
                    
                    //navigateTo Home screen
                    self.navigateToScreen(strView: kView_HomeViewVC)
                }
                else{
                    
                    if ISDebug{
                        print("Facebook Login False")
                    }
                    
                    if responseAllKey.contains(kAPI_Msg) {
                        showToast(message: responseObj.value(forKey: kAPI_Msg) as! String)
                    }
                }
            }
        }
    }
    
    func forgotPassword(strEmail:String) -> Void {
        
        if strEmail == "" {
            showToast(message: "Email is empty")
            return
        }
        
        let cemail = strEmail.trimmingCharacters(in: .whitespaces)
        if cemail.isValidEmail == false {
            
            showToast(message: "Invalid Email")
            return
        }
        
        //Call Webservice here
        HUD.show(true)
        web.forgotPassword(strEmail: strEmail)
    }
    
    func forgotPasswordResponse(responseObj: NSDictionary) -> Void{
        
        HUD.hide(true)
        
        let responseAllKey : NSArray = responseObj.allKeys as NSArray
        print("Print Array Keys : \(responseAllKey)")
        
        if responseAllKey.contains(kAPI_Status) {
            
            if let statusCode : Int = responseObj.value(forKey: kAPI_Status) as? Int {
                if statusCode == 200
                {
                    if ISDebug{
                        print("Forgot Password True response \(responseObj)")
                    }
                    
                    if responseAllKey.contains(kAPI_Msg) {
                        showToast(message: responseObj.value(forKey: kAPI_Msg) as! String)
                    }
                }else{
                    
                    if ISDebug{
                        print("Forgot Password False")
                    }
                    
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
    
    
    //MARK:- Background Image
    
    func loadBackGroundImage() -> Void
    {
        /*
        let randomNum:UInt32 = arc4random_uniform(3)
        print("Image\(arrBackgroundImages.object(at: Int(randomNum)))")
        
        if let strImageName : String = arrBackgroundImages.object(at: Int(randomNum)) as? String {
            img_Background.image = UIImage(named: strImageName)
        }
        */
        img_Background.image = Constants.app_delegate.imageBG
    }
}
