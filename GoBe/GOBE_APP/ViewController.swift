//
//  ViewController.swift
//  GoBe
//
//  Created by rlogical-dev-35 on 21/06/17.
//  Copyright © 2017 rlogical-dev-35. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var lbl_register: UILabel!
    @IBOutlet weak var lbl_newgobe: UILabel!
    @IBOutlet weak var lbl_aouthertitle: UILabel!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_makeyourown: UILabel!
    @IBOutlet weak var imgview_background: UIImageView!
    @IBOutlet weak var btn_NewRegister: UIButton!
    @IBOutlet weak var btn_Login: UIButton!
    
    //MARK:- Variable
    
    
    
    //MARK:- UIView Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbl_newgobe.textColor=UIColor.black
        lbl_register.textColor=UIColor.black
        btn_Login.setTitleColor(UIColor.black, for: UIControlState.normal)
        
        self.loadBackGroundImage()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lbl_newgobe.textColor=UIColor.black
        lbl_register.textColor=UIColor.black

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK:- UIButton Action
    @IBAction func btn_LoginClick(_ sender: Any) {
        
        btn_Login.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let LoginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(LoginVC, animated: false)
    }

    @IBAction func btn_NewRegisterClick(_ sender: Any) {
        
        lbl_newgobe.textColor=UIColor.white
        lbl_register.textColor=UIColor.white
        self.perform(#selector(ViewController.PushToRegister), with: nil, afterDelay: 0.001)
    }
    
    //MARK:- Background Image
    func loadBackGroundImage() -> Void {
    
        imgview_background.image = Constants.app_delegate.imageBG
    }
    
    //MARK:- UINavigation Methods
    func PushToRegister()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let RegisterVC = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(RegisterVC, animated: false)
    }

}

