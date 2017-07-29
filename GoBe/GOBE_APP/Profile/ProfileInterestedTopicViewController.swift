//
//  ProfileInterestedTopicViewController.swift
//  GoBe
//
//  Created by rlogical-dev-35 on 17/07/17.
//  Copyright © 2017 rlogical-dev-35. All rights reserved.
//

import UIKit

class ProfileInterestedTopicViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,WebApiRequestDelegate{

    //MARK:- Class Reference
    let web = Webservice()
    let HUD = MBProgressHUD()
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var scrollview_content: UIScrollView!
    @IBOutlet weak var view_allContent: UIView!
    @IBOutlet weak var collectionView_Button: UICollectionView!
    
    //MARK:- Variable
    var arr_TopicsList = NSMutableArray()
    var selectedIndex = Int ()
    var isselcted : Bool = false

    //MARK:- UIView Methods
    
    override func viewDidLoad(){
        super.viewDidLoad()

        web.delegate = self
        self.view.addSubview(HUD)
        
        self.getAllTopicsList()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- UIButton Action
    @IBAction func btnAction_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK:- CollectionView Datasource and Delegate Method
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return self.arr_TopicsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell : InterestedCatCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestedCatCollectionViewCell", for: indexPath) as? InterestedCatCollectionViewCell
     
        let dict_Cell = arr_TopicsList.object(at: indexPath.row) as? NSDictionary
        
        if let strTopicName = dict_Cell?.value(forKey: "TopicName") as? String {
            cell?.btn_Cat.setTitle(strTopicName, for: .normal)
        }
        
        if isselcted == true
        {
            if selectedIndex == indexPath.row
            {
                cell?.btn_Cat.setBackgroundImage(UIImage(named:"who can selec"), for: .normal)
                cell?.btn_Cat.setTitleColor(UIColor.white, for: .normal)
                cell?.btn_Cat.titleLabel!.font =  UIFont(name: "Larsseit-Medium", size: 11)
            }
            else
            {
                cell?.btn_Cat.setBackgroundImage(UIImage(named:"topic"), for: .normal)
                cell?.btn_Cat.setTitleColor(UIColor(red:99.0 / 255.0, green:99.0 / 255.0, blue:99.0 / 255.0, alpha:1.0), for: .normal)
                cell?.btn_Cat.titleLabel!.font =  UIFont(name: "Larsseit", size: 11)
            }
        }

        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell = collectionView.cellForItem(at: indexPath) as! InterestedCatCollectionViewCell
            selectedIndex = indexPath.row
            self.collectionView_Button.reloadData()
            isselcted = true
            cell.btn_Cat.setBackgroundImage(UIImage(named:"who can selec"), for: .normal)
            cell.btn_Cat.setTitleColor(UIColor.white, for: .normal)
            cell.btn_Cat.titleLabel!.font =  UIFont(name: "Larsseit-Medium", size: 11)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let size:CGSize = CGSize(width: Constants.WIDTH, height: Constants.HEIGHT)
        return size
    }

    
    //MARK:- Webservice Related Methods
    
    func getAllTopicsList() -> Void {
        
        HUD.show(true)
        web.getTopicList()
    }
    
    func getTopicListDetailsResponse(responseObj: NSDictionary) -> Void {
        
        HUD.hide(true)
        
        let responseAllKey : NSArray = responseObj.allKeys as NSArray
        if ISDebug { print("Print Array Keys : \(responseAllKey)"); }
        if responseAllKey.contains(kAPI_Status) {
            
            if let statusCode : Int = responseObj.value(forKey: kAPI_Status) as? Int {
                if statusCode == 200 {
                    
                    if ISDebug {
                        print("User Profile Response : \(responseObj)")
                    }
                    
                    if responseAllKey.contains("TopicDetails") {
                     
                        if let arrTopics = responseObj.object(forKey: "TopicDetails") as? NSArray {
                            arr_TopicsList = NSMutableArray(array: arrTopics)
                        }
                        collectionView_Button.reloadData()
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
    
    //MARK:- Navigation
    
    func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
}


