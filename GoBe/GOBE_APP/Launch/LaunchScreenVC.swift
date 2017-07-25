//  LaunchScreenVC.swift
//  GoBe
//
//  Created by rlogical-dev-11 on 03/07/17.
//  Copyright © 2017 rlogical-dev-35. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
class LaunchScreenVC: UIViewController {

    //MARK:- Class Reference
    
    
    //MARK:- IBOutlets
    
    @IBOutlet var img_GoBe: UIImageView!
    @IBOutlet var lbl_GoBe: UIImageView!
    
    @IBOutlet var imgview_background: UIImageView!
    
    //MARK:- Variable
    let arrBackgroundImages : NSArray = ["Background1.png","Background2.png","Background3.png"]
    
    //MARK:- UIView Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Background Image
        self.loadBackGroundImage()
        self.startAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK:- Animation
    
    func startAnimation() -> Void {
        
        img_GoBe.isHidden = true
        lbl_GoBe.isHidden = true
        
        self.img_GoBe.alpha = 0.0
        UIView.animate(withDuration: 2.0, delay: 0.0, options: [], animations: {
            self.img_GoBe.isHidden = false
            self.img_GoBe.alpha = 1.0
            
        }, completion: { (finished: Bool) in
            
            self.lbl_GoBe.alpha = 0.0
            UIView.animate(withDuration: 1.0, delay: 0.2, options: [], animations: {
                self.lbl_GoBe.isHidden = false
                self.lbl_GoBe.alpha = 1.0
            
            }, completion: { (finished: Bool) in
                
                UIView.animate(withDuration: 1.0, delay: 0.0, options: [], animations: {
                    
                    self.img_GoBe.alpha = 0.0
                    
                }, completion: { (finished: Bool) in
                    
                    self.navigateToStartScreen()
                })
            })
        })
    }
    
    //MARK:- Background Image
    
    func loadBackGroundImage() -> Void {
        
        let randomNum:UInt32 = arc4random_uniform(3)
        print("Image\(arrBackgroundImages.object(at: Int(randomNum)))")
        
        if let strImageName : String = arrBackgroundImages.object(at: Int(randomNum)) as? String
        {
            imgview_background.image = UIImage(named: strImageName)
            Constants.app_delegate.imageBG = imgview_background.image!
        }
    }
    
    //MARK:- Navigation
    func navigateToStartScreen() -> Void {
        
        if let strUserID : String = appDel.instanceModelLogin.UserID {
            
            if strUserID.isEmpty {
                
                let objStartVC = self.storyboard?.instantiateViewController(withIdentifier: kView_StartViewVC)
                self.navigationController?.pushViewController(objStartVC!, animated: false)
            }else{
                
                print("Login UserId: \(strUserID)")
                let objHomeVC = self.storyboard?.instantiateViewController(withIdentifier: kView_HomeViewVC)
                self.navigationController?.pushViewController(objHomeVC!, animated: false)
            }
        }
    }
   

}
