//
//  Friends_FollowersViewController.swift
//  GoBe
//
//  Created by macmini on 12/07/17.
//  Copyright © 2017 rlogical-dev-35. All rights reserved.
//

import UIKit

class Friends_FollowersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,  UIScrollViewDelegate {
    
    @IBOutlet weak var scrl: UIScrollView!
    @IBOutlet weak var subviewScrl: UIView!
    
    
    @IBOutlet weak var view_NewFollowers: UIView!
    
    
    @IBOutlet weak var view_FriendsRequest: UIView!
    @IBOutlet weak var tblFriendsRequest: UITableView!
    @IBOutlet weak var constraintsFriendsRequest: NSLayoutConstraint!
    
    @IBOutlet weak var view_FriendsList: UIView!
    @IBOutlet weak var viewtblFriendsRequest: UIView!
    
    
    @IBOutlet weak var view_UserList: UIView!
    @IBOutlet weak var tblUsersList: UITableView!
    @IBOutlet weak var constraintsViewUserList: NSLayoutConstraint!
    
    
    var arr_Followers : NSMutableArray = []
    var arr_Following : NSMutableArray = []
    var arr_Friends : NSMutableArray = []
    var arr_FriendsRequest : NSMutableArray = []
    
    let TABLE_SECTION_HEIGHT = 48
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.setInitParam()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        self.setupview()
        super.viewDidAppear(animated)
    }
    
    // MARK: - setup
    func setInitParam()
    {
        arr_Following = ["Mike Smith","Sissy Spacek","Mike Smith","Greg Spacek","Mike Jovanowski","Sissy Spacek","Aaron Menguin", "Sissy Rodriguez", "Mike Smith", "Sissy Spacek", "Mike Smith", "Greg Spacek", "Mike Jovanowski", "Sissy Spacek", "Sissy Spacek"]
        
        arr_Friends = ["Mike Smith","Sissy Spacek","Mike Smith","Greg Spacek","Mike Jovanowski","Sissy Spacek","Aaron Menguin", "Sissy Rodriguez", "Mike Smith", "Sissy Spacek", "Mike Smith", "Greg Spacek"]
        
        arr_Followers = ["Mike Smith","Sissy Spacek","M€ike Smith","Greg Spacek", "Mike Jovanowski", "Sissy Spacek", "Aaron Menguin", "Sissy Rodriguez"]
        
        arr_FriendsRequest = ["","","",""]
        
    }
    
    
    func setupview()
    {
        var CustomHeight = 0
        
        //New Followers
        CustomHeight = CustomHeight + Int(view_NewFollowers.frame.size.height)
        
        //Friends Request
        CustomHeight = CustomHeight + Int(view_FriendsRequest.frame.size.height)

        let tblHeightRequest = CGFloat(arr_FriendsRequest.count * 45)
        tblFriendsRequest.frame = CGRect(x: 0, y: 0, width:Int(Constants.WIDTH), height: Int(tblHeightRequest))
        constraintsFriendsRequest.constant = CGFloat(tblHeightRequest);
        CustomHeight = CustomHeight + Int(tblHeightRequest)
 
        //FriendsList
        CustomHeight = CustomHeight + Int(view_FriendsList.frame.size.height)
        view_FriendsList.frame = CGRect(x: 0, y: CustomHeight, width: Int(Constants.WIDTH), height:Int(view_FriendsList.frame.size.height))

        
        //UsersList
        let Height_Followers = CGFloat(arr_Followers.count * 25) + CGFloat(TABLE_SECTION_HEIGHT)
        let Height_Following = CGFloat(arr_Following.count * 25) + CGFloat(TABLE_SECTION_HEIGHT)
        let Height_Friends = CGFloat(arr_Friends.count * 25) + CGFloat(TABLE_SECTION_HEIGHT)
        let tblHeight = Int(Height_Followers) + Int(Height_Following) + Int(Height_Friends)
        tblUsersList.frame = CGRect(x: 0, y: 0, width:Int(Constants.WIDTH), height: tblHeight)
        constraintsViewUserList.constant = CGFloat(tblHeight);
        CustomHeight = CustomHeight + Int(tblHeight)


        //BOTTOM SPACE
        CustomHeight = CustomHeight + TABLE_SECTION_HEIGHT

        self.subviewScrl.frame = CGRect(x: 0, y: 0, width: Constants.WIDTH, height: CGFloat(CustomHeight))
        self.scrl.contentSize = CGSize(width: self.subviewScrl.frame.size.width, height: CGFloat(CustomHeight))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func back(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UITableview Datasurce And Delegate
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if tableView == tblUsersList
        {
            return 3
        }
        else
        {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == tblFriendsRequest
        {
            return 4
        }else if tableView == tblUsersList{
            if section == 0
            {
                return arr_Followers.count
            }else if section == 1 {
                return arr_Following.count
            }else{
                return arr_Friends.count
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if tableView == tblUsersList
        {
            return CGFloat(TABLE_SECTION_HEIGHT)
        }
        else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        if tableView == tblUsersList
        {
            let headerVw = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(Constants.WIDTH), height: CGFloat(TABLE_SECTION_HEIGHT)))
            
            headerVw.backgroundColor = UIColor.clear
            
            let lblTitle = UILabel(frame: CGRect(x: CGFloat(0), y: CGFloat(32), width: CGFloat(Constants.WIDTH), height: CGFloat(15)))
            lblTitle.font = UIFont(name: "Larsseit-Medium", size: 14)
            lblTitle.textColor = Constants.hexStringToUIColor(hex: "#07CED8")
            lblTitle.textAlignment = .center
            if section == 0{
                lblTitle.text = "FOLLOWERS"
            }else if section == 1{
                lblTitle.text = "FOLLOWING"
            }else{
                lblTitle.text = "FRIENDS"
            }
            
            lblTitle.backgroundColor = UIColor.clear
            headerVw.addSubview(lblTitle)
            
            return headerVw
        }
        else
        {
            let headerVw = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(Constants.WIDTH), height: CGFloat(0)))
            headerVw.backgroundColor = UIColor.clear
            
            return headerVw
        }
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView == tblFriendsRequest
        {
            let CellIdentifier: String = "cell \(Int(indexPath.row))"
            var cell: Cell_FriendsRequest? = (tableView.dequeueReusableCell(withIdentifier: CellIdentifier) as? Cell_FriendsRequest)
            
            if cell == nil {
                let topLevelObjects: [Any] = Bundle.main.loadNibNamed("Cell_FriendsRequest", owner: nil, options: nil)!
                cell = (topLevelObjects[0] as? Cell_FriendsRequest)
                cell?.backgroundColor = UIColor.clear
                cell?.selectionStyle = .none
            }
            
            return cell!
            
        }else{
            
            let CellIdentifier: String = "cell \(Int(indexPath.row))"
            var cell: Cell_userList? = (tableView.dequeueReusableCell(withIdentifier: CellIdentifier) as? Cell_userList)
            
            if cell == nil {
                let topLevelObjects: [Any] = Bundle.main.loadNibNamed("Cell_userList", owner: nil, options: nil)!
                cell = (topLevelObjects[0] as? Cell_userList)
                cell?.backgroundColor = UIColor.clear
                cell?.selectionStyle = .none
            }
            
            if indexPath.section == 0{
               cell?.lblName.text = arr_Followers.object(at: indexPath.row) as? String
            }else if indexPath.section == 1{
                cell?.lblName.text = arr_Following.object(at: indexPath.row) as? String
            }else{
                cell?.lblName.text = arr_Friends.object(at: indexPath.row) as? String
            }
            
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if tableView == tblFriendsRequest {
            return 45
        }else{
            return 25
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView == tblFriendsRequest{
        }else{
        }
    }
    
}
