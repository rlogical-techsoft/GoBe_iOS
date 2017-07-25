//
//  YOURLISTSVC.swift
//  GoBe
//
//  Created by rlogical-dev-11 on 21/07/17.
//  Copyright © 2017 rlogical-dev-35. All rights reserved.
//

import UIKit

class YOURLISTSVC: UIViewController,UITableViewDelegate,UITableViewDataSource,WebApiRequestDelegate {

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
    let arr_YourList : NSMutableArray = []
    
    
    // MARK: - UIView Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
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
        }
        
        
        web.delegate = self
        self.view.addSubview(HUD)
        
        tbl_YourLists.register(UINib(nibName: "YourLikesTableViewCell", bundle: nil), forCellReuseIdentifier: "YourLikesTableViewCell")
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
//        return arr_YourList.count;
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    
        var dcell: YourLikesTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "YourLikesTableViewCell", for: indexPath as IndexPath) as? YourLikesTableViewCell
        
        if dcell == nil {
            var topLevelObjects: [Any] = Bundle.main.loadNibNamed("YourLikesTableViewCell", owner: self, options: nil)!
            dcell = topLevelObjects[0] as? YourLikesTableViewCell
        }
//        let dict_YourLikes = arr_YourList.object(at: indexPath.row) as? NSDictionary
        
        return dcell!
    }
    
    //MARK:- Webservices methods
    func getTipsFromListID(strID:String) -> Void {
    }
    
    
    
    
}
