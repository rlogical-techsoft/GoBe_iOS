//  YOURLISTSVC.swift
//  GoBe
//
//  Created by rlogical-dev-11 on 21/07/17.
//  Copyright © 2017 rlogical-dev-35. All rights reserved.
//

import UIKit

class YOURLISTSVC: UIViewController,UITableViewDelegate,UITableViewDataSource,WebApiRequestDelegate,SWTableViewCellDelegate {

    //MARK:- Class Reference
    let web = Webservice()
    let HUD = MBProgressHUD()
    
    
    // MARK: - IBOutlets
    
    @IBOutlet var str_ViewControllerTitle: UILabel!

    @IBOutlet var lbl_ListName: UILabel!
    @IBOutlet var btn_AuthorName: UIButton!

    @IBOutlet var tbl_YourLists: UITableView!
    
    // MARK: - Variable For Other Classes
    var dict_CurrentListFromHome : NSDictionary?
    var str_ScreenTitle = "YOUR LISTS"
    
    // MARK: - Variable For Inner Classes
    var arr_YourList : NSMutableArray = []
    var selectedIndexYourTips = Int ()
    
    let tableviewRightButtonSize : CGFloat = 32.0
    // MARK: - UIView Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        web.delegate = self
        self.view.addSubview(HUD)
        
        tbl_YourLists.register(UINib(nibName: "YourLikesTableViewCell", bundle: nil), forCellReuseIdentifier: "YourLikesTableViewCell")
        
        
        str_ViewControllerTitle.text = str_ScreenTitle
        
        if let dict_TipsDetails = dict_CurrentListFromHome {
            
            if let str_ListName = dict_TipsDetails.value(forKey: "ListName") as? String {
                lbl_ListName.text = str_ListName
            }
            
            if let str_AuthorID = dict_TipsDetails.value(forKey: "AuthorID") as? String{
                
                if str_AuthorID == appDel.instanceModelLogin.UserID {
                    btn_AuthorName.setTitle("by You", for: .normal)
                    
                }else{
                    if let str_AuthorName = dict_TipsDetails.value(forKey: "AuthorName") as? String{
                        btn_AuthorName.setTitle("by \(str_AuthorName)", for: .normal)
                    }
                }
            }
            
            if let strListID = dict_TipsDetails.value(forKey: "ListID") as? String {
                self.perform(#selector(getTipsFromListID), with: strListID, afterDelay: 0.1)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - UIButton Action
    
    @IBAction func btnAction_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAction_Search(_ sender: Any) {
    }
    
    @IBAction func btnAction_GoExplore(_ sender: Any) {
    }
    
    @IBAction func btnAction_BeTracker(_ sender: Any) {
    }
    
    @IBAction func btnAction_SharePostaTip(_ sender: Any) {
    }
    
    // MARK: - UITableview Datasource and Delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return arr_YourList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    
        var dcell: YourLikesTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "YourLikesTableViewCell", for: indexPath as IndexPath) as? YourLikesTableViewCell
        
        if dcell == nil {
            var topLevelObjects: [Any] = Bundle.main.loadNibNamed("YourLikesTableViewCell", owner: self, options: nil)!
            dcell = topLevelObjects[0] as? YourLikesTableViewCell
        }
        
        let dict_YourTips = arr_YourList.object(at: indexPath.row) as? NSDictionary
        
        if let strImageUrl = dict_YourTips?.value(forKey: "Thumb") as? String{
            
            dcell?.img_activityIndi.startAnimating()
            
            dcell?.imgPicture.sd_setImage(with: URL(string:strImageUrl), placeholderImage: UIImage(named: "placeholder.png"), options: .refreshCached, completed: { (image, error, cacheType, url) -> Void in
                
                dcell?.img_activityIndi.stopAnimating()
            })
        }
        if let strTitleName = dict_YourTips?.value(forKey: "Title") as? String{
            dcell?.lblHeader.text = strTitleName
        }
        if let strDescription = dict_YourTips?.value(forKey: "Description") as? String{
            dcell?.lblDescription.text = strDescription
        }
        if let strlblName = dict_YourTips?.value(forKey: "AuthorName") as? String{
            dcell?.lblName.text = strlblName
        }
        
        if selectedIndexYourTips == indexPath.row{
            
            dcell?.backgroungImgView.image = UIImage(named:"NT box hit")
        }else{
            dcell?.backgroungImgView.image = UIImage(named:"NT box")
        }
        
        dcell?.setLeftUtilityButtons(leftButtons(tableView,indexpath: indexPath), withButtonWidth: tableviewRightButtonSize)
        dcell?.setRightUtilityButtons(rightbuttons(tableView,indexPath: indexPath), withButtonWidth: tableviewRightButtonSize)
        
        dcell?.delegate = self
        dcell?.selectionStyle = .none
        dcell?.tag = indexPath.row
        
        return dcell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    //MARK:- SWTableView Left and Right Methods
    
    func swipeableTableViewCellShouldHideUtilityButtons(onSwipe cell: SWTableViewCell!) -> Bool {
        return true
    }
    
    func leftButtons(_ tableview : UITableView,indexpath:IndexPath) -> [Any] {
        
        let leftUtilityButtons = NSMutableArray()
        
        return leftUtilityButtons as! [Any]
    }
    
    func rightbuttons(_ tableview : UITableView,indexPath:IndexPath) -> [Any]{
        
        let rightUtilityButtons = NSMutableArray()
        
        let dict_YourLikes = arr_YourList.object(at: indexPath.row) as? NSDictionary
        if let strAutherID = dict_YourLikes?.value(forKey: "AuthorID") as? String{
            
            //If this Tips is created by me OR not
            if strAutherID == appDel.instanceModelLogin.UserID {
                
                rightUtilityButtons .sw_addUtilityButton(with: UIColor.clear, icon: UIImage(named: "edit"))
                rightUtilityButtons .sw_addUtilityButton(with: UIColor.clear, icon: UIImage(named: "remove from"))
                
            }else{
                rightUtilityButtons .sw_addUtilityButton(with: UIColor.clear, icon: UIImage(named: "remove from"))
            }
        }
        
        return rightUtilityButtons as! [Any]
    }
    
    //MARK:- Webservices methods
    
    func getTipsFromListID(strListID:String) -> Void {
        
        if ISDebug {  print("ListID : \(strListID)"); }
        
        HUD.show(true)
        web.getTipsFromListID(strUserID: appDel.instanceModelLogin.UserID, ListID: strListID)
    }
    
    func getTipsFromListIDResponse(responseObj: NSDictionary) -> Void {
        
        HUD.hide(true)
        
        let responseAllKey : NSArray = responseObj.allKeys as NSArray
        if ISDebug { print("Print Array Keys : \(responseAllKey)"); }
        
        if responseAllKey.contains(kAPI_Status) {
            
            if let statusCode : Int = responseObj.value(forKey: kAPI_Status) as? Int {
                if statusCode == 200 {
                    
                    if ISDebug {
                        print("List of Tips from Response : \(responseObj)")
                    }
                    
                    if let arr_ListOfTips = responseObj.object(forKey: "TipDetails") as? NSArray{
                        arr_YourList = NSMutableArray(array: arr_ListOfTips)
                    }
                    tbl_YourLists.reloadData()
                    
                }else{
                    
                    if ISDebug {
                        print("List of Tips from Error:\(responseObj.value(forKey: kAPI_Msg) as! String)")
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
