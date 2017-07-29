//
//  SharedTipsViewController.swift
//  GoBe
//
//  Created by rlogical-dev-35 on 28/07/17.
//  Copyright © 2017 rlogical-dev-35. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class SharedTipsViewController: UIViewController ,UITextViewDelegate,UIImagePickerControllerDelegate,
UINavigationControllerDelegate
 {
    
    //MARK:- Variable
    
    var imagePickerViewController = UIImagePickerController()
    var pickerImage : UIImage?
    var Dict_shareTips : NSMutableDictionary!
    
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var btn_done: UIButton!
    @IBOutlet weak var btn_Capture: UIButton!
    @IBOutlet weak var btn_CameraRoll: UIButton!
    @IBOutlet weak var view_TextBox: UIView!
    @IBOutlet weak var txtView_Title: UITextView!
    @IBOutlet weak var txtview_Details: UITextView!

    @IBOutlet weak var iamgeview_sharedEvent: UIImageView!
    @IBOutlet weak var lbl_givetitle: UILabel!
    @IBOutlet weak var lbl_describe: UILabel!
    
    // MARK: - ViewConroller Method

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.lbl_describe.isHidden=true
        self.lbl_givetitle.isHidden=true
        
        
        //Textview Property
        
        txtview_Details.clipsToBounds = true;
        txtview_Details.layer.cornerRadius = 7.0

        txtView_Title.clipsToBounds = true;
        txtView_Title.layer.cornerRadius = 7.0

        imagePickerViewController.allowsEditing = true
        imagePickerViewController.delegate = self
        
        txtView_Title.isUserInteractionEnabled = true
        txtView_Title.isEditable = true
        
        txtview_Details.isUserInteractionEnabled = true
        txtview_Details.isEditable = true

        
        btn_done.isHidden = true

        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
    }
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)

        IQKeyboardManager.sharedManager().enable = false
        observeKeyboardNotifications()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeKeyboardObservers()
    }


    // MARK: - Button Tap Event

    @IBAction func btn_DoneClick(_ sender: Any) {
        
        if txtView_Title.text != "" && txtview_Details.text != ""
        {
            
            
        }
        //This is only for testing
        let move = self.storyboard?.instantiateViewController(withIdentifier: "sharedTipsVisibilityViewController") as! sharedTipsVisibilityViewController
        
        if pickerImage == nil
        {
            pickerImage = UIImage(named:"nopic")
        }
        
        let SharedTips : [String: Any] = [
            
            "EventImage" : pickerImage!,
            "EventTitle" : txtView_Title.text,
            "EventDescription" : txtview_Details.text,
            "Visibility" : "PUBLIC",

        ]
        move.Dict_SharedEvent=SharedTips as NSDictionary
        self.navigationController?.pushViewController(move, animated: true)
    }
    @IBAction func btn_HomeClick(_ sender: Any) {
    }
    @IBAction func btn_CaptureClick(_ sender: Any) {
        
        OpenCamera()
    }
    @IBAction func btn_CameraRollClick(_ sender: Any) {
        
         OpenphotoLibrary()
    }
    @IBAction func btn_BackClick(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - keyboardHide&keyboardShow
    
    fileprivate func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: .UIKeyboardWillHide, object: nil)
    }
    

    var kheight : CGFloat = 0
    var currenty : Bool = false

    func keyboardHide(notification : Notification) {
        if currenty{
            currenty = false
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations:
                {
                if self.kheight > 0
                {
                    self.btn_done.isHidden = true
                    self.lbl_describe.isHidden=true
                    self.lbl_givetitle.isHidden=true
                    self.checkTextviewEmptyKeyboardHide()
                    self.view_TextBox.backgroundColor=UIColor(red:244.0/255.0, green:244.0/255.0, blue:244.0/255.0, alpha:1.0)
                    self.view_TextBox.frame.origin.y += self.kheight
                }
                
            }, completion: nil)
        }
    }
    
    func keyboardShow(notification : Notification) {
        if currenty ==  false{
            currenty = true
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                _ = keyboardSize.height
                // print(keyboardHeight)
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    
                    self.btn_done.isHidden = false
                    self.view_TextBox.backgroundColor=UIColor.clear
                    self.checkTextviewEmptyKeyboardShow()
                    self.lbl_describe.isHidden=false
                    self.lbl_givetitle.isHidden=false
                    self.kheight = keyboardSize.height - 20
                    self.view_TextBox.frame.origin.y -= self.kheight
                    
                }, completion: nil)
            }
        }
    }
    
    func checkTextviewEmptyKeyboardHide()
    {
        if self.txtview_Details.text == ""
        {
            self.txtview_Details.text = "Describe the experience – in complete sentences, please"

        }
        else{
            
            self.txtview_Details.text = self.txtview_Details.text
        }
        
        if self.txtView_Title.text == ""
        {
            self.txtView_Title.text = "Give your tip a good,                     self-explaining title"

        }
        else{
            self.txtView_Title.text = self.txtView_Title.text

        }
    }

    func checkTextviewEmptyKeyboardShow()
    {
        if self.txtview_Details.text == "Describe the experience – in complete sentences, please"
        {
            self.txtview_Details.text = ""
            
        }
        else{
            
        }
        
        if self.txtView_Title.text == "Give your tip a good,                     self-explaining title"
        {
            self.txtView_Title.text = ""
            
        }
        else{
            
        }
    }
    
    // MARK: - removeKeyboardObservers
    
    fileprivate func removeKeyboardObservers (){
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - TextView Delegate

    //TextFiels DidChange
    func textViewDidChange(_ textView: UITextView)
    {
        if txtview_Details.text == ""
        {
            lbl_describe.isHidden = false
        } else {
            lbl_describe.isHidden = true
        }
        
        if txtView_Title.text == ""
        {
            lbl_givetitle.isHidden = false
        }
        else
        {
            lbl_givetitle.isHidden = true
        }
    }

    func validate(textView: UITextView) -> Bool
    {
        guard let text = textView.text,
            !text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
                return false
        }
        return true
    }
    
    //MARK:- UIImagePicker View Controller
    
    func OpenphotoLibrary() -> Void {
        
            self.imagePickerViewController.sourceType = .photoLibrary
            self.present(self.imagePickerViewController, animated: true, completion:nil)
    }
    func OpenCamera() -> Void {

            self.imagePickerViewController.sourceType = .camera
            self.present(self.imagePickerViewController, animated: true, completion:nil)
    }
    //MARK:- UIImagePickerViewController Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:  [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        {
            self.iamgeview_sharedEvent.image = pickedImage
            pickerImage = pickedImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
