//
//  NewtrendsViewController.swift
//  GoBe
//
//  Created by rlogical-dev-35 on 26/06/17.
//  Copyright © 2017 rlogical-dev-35. All rights reserved.
//

import UIKit

class NewtrendsViewController: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate,SWTableViewCellDelegate{
    
    let HightNewandtrendSamll : CGFloat = 32.0
    let HightNewandtrendBig : CGFloat = 700.0
    
    
    @IBOutlet weak var viewScroll: UIScrollView!
    @IBOutlet weak var heightNewTrending: NSLayoutConstraint!
    @IBOutlet weak var viewNewTrending: UIView!
    
    @IBOutlet weak var heightFollowing: NSLayoutConstraint!
    @IBOutlet weak var collection_following: UICollectionView!
    
    @IBOutlet weak var heightFriends: NSLayoutConstraint!
    @IBOutlet weak var Collection_friends: UICollectionView!
    
    @IBOutlet weak var heightYourLikes: NSLayoutConstraint!
    @IBOutlet weak var tblYourLikes: UITableView!
    
    @IBOutlet weak var heightYourTips: NSLayoutConstraint!
    @IBOutlet weak var tblYourTips: UITableView!
    
    
    var strSectionName = "YourLikes"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        heightNewTrending.constant = HightNewandtrendSamll
        viewNewTrending.isHidden = false
        
        heightFollowing.constant = 700.0
        viewNewTrending.isHidden = false
        
        heightFriends.constant = 700.0
        viewNewTrending.isHidden = false
        
        heightYourLikes.constant = tblYourLikes.frame.size.height
        tblYourLikes.isHidden = false
        
        heightYourTips.constant = 700.0;
        tblYourTips.isHidden = false;
        
        
        collection_following.register(UINib(nibName: "FollowingCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "FollowingCollectionViewCell")
        
        Collection_friends.register(UINib(nibName: "FollowingCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "FollowingCollectionViewCell")
        
        
        tblYourLikes.register(UINib(nibName: "YourLikesTableViewCell", bundle: nil), forCellReuseIdentifier: "YourLikesTableViewCell")
        
        tblYourTips.register(UINib(nibName: "YourLikesTableViewCell", bundle: nil), forCellReuseIdentifier: "YourLikesTableViewCell")
        
        
        
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell: Cell_Following? = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell_Following", for: indexPath) as? Cell_Following
        return cell!
    }
    
    
    //Tableview Datasurce And Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblYourLikes
        {
            return 6
        }
        return 6
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView == tblYourLikes
        {
            var dcell: YourLikesTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "YourLikesTableViewCell", for: indexPath as IndexPath) as? YourLikesTableViewCell
            
            if (dcell == nil)
            {
                if dcell == nil {
                    // Load the top-level objects from the custom cell XIB.
                    var topLevelObjects: [Any] = Bundle.main.loadNibNamed("YourLikesTableViewCell", owner: self, options: nil)!
                    // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
                    dcell = topLevelObjects[0] as? YourLikesTableViewCell
                }
            }
            // Load the top-level objects from the custom cell XIB.
            dcell?.setLeftUtilityButtons(leftButtons(), withButtonWidth: 40.0)
            dcell?.setRightUtilityButtons(rightbuttons(), withButtonWidth: 40.0)
            dcell?.delegate = self
            return dcell!
        }
        if tableView == tblYourLikes
        {
            var dcell: YourLikesTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "YourLikesTableViewCell", for: indexPath as IndexPath) as? YourLikesTableViewCell
            // Load the top-level objects from the custom cell XIB.
            let topLevelObjects: [Any] = Bundle.main.loadNibNamed("YourLikesTableViewCell", owner: self, options: nil)!
            dcell = (topLevelObjects[0] as? YourLikesTableViewCell)
            
            return dcell!
        }
            
        else
        {
            let dcell: YourLikesTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "YourLikesTableViewCell", for: indexPath as IndexPath) as? YourLikesTableViewCell
            return dcell!
        }
        
        
        
        
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if tableView == tblYourLikes
        {
            return 117
        }
        else if tableView == tblYourTips
        {
            return 117;
        }
        
        return 0
    }
    
    func leftButtons() -> [Any]
    {
        let leftUtilityButtons = NSMutableArray()
        if (strSectionName == "YourLikes")
        {
            leftUtilityButtons .sw_addUtilityButton(with: UIColor.clear, icon: UIImage(named: "archive.png"))
            leftUtilityButtons .sw_addUtilityButton(with: UIColor.clear, icon: UIImage(named: "FB.png"))
        }
        return leftUtilityButtons as! [Any]
    }
    
    func rightbuttons() -> [Any]
    {
        let rightUtilityButtons = NSMutableArray()
        if (strSectionName == "YourLikes")
        {
            rightUtilityButtons .sw_addUtilityButton(with: UIColor.clear, icon: UIImage(named: "archive.png"))
        }
        return rightUtilityButtons as! [Any]
    }
    
    
    func swipeableTableViewCell(_ cell: SWTableViewCell, scrollingTo state: SWCellState)
    {
        switch state{
            
        case .cellStateRight:
            print(" Right utility buttons closed")
            break;

        case .cellStateCenter:
            print("close")
            break;

        case .cellStateLeft:
            print("lelf utility buttons open")
            break;

        default:
            break;
        }
    }
    
    func swipeableTableViewCell(_ cell: SWTableViewCell, didTriggerLeftUtilityButtonWith index: Int)
    {
        if (strSectionName == "YourLikes")
        {
            switch index
            {
            case 0:
                print("left button 0 was pressed")
                break;
                
            case 1:
                print("left button 1 was pressed")
                break;

            case 2:
                print("left button 2 was pressed")
                break;

            default:
                break
            }
        }
    }
    
    func swipeableTableViewCell(_ cell: SWTableViewCell, didTriggerRightUtilityButtonWith index: Int)
    {
        let indexPath: IndexPath? = tblYourLikes.indexPath(for: cell)
        print("Index path: \(String(describing: indexPath))")
        if (strSectionName == "YourLikes") {
            switch index {
            case 0: break
            // [cell hideUtilityButtonsAnimated:YES];
            case 1:
                break
            case 2: break
            // Delete button was pressed
            default:
                break
            }
        }
    }
    
    
}
