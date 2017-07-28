//
//  NewtrendsDetailsViewController.swift
//  GoBe
//
//  Created by rlogical-dev-35 on 27/06/17.
//  Copyright © 2017 rlogical-dev-35. All rights reserved.
//

import UIKit

class NewtrendsDetailsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,WebApiRequestDelegate
{
    //MARK:- Class Reference
    let web = Webservice()
    let HUD = MBProgressHUD()
    
    //MARK:- IBOUTLET
    @IBOutlet weak var CollectionviewForNewTrendDetails: UICollectionView!
    
    //MARK:- Variable
    var arrTipsListData : NSMutableArray = []
    var intStartIndex : Int = 0
    
    
    //MARK:- UIview Methods
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        web.delegate = self
        self.view.addSubview(HUD)
        
    }
    
    override func viewDidLayoutSubviews() {
        
        if arrTipsListData.count > 0 {
            
            let indexPathStart = IndexPath(row: intStartIndex, section: 0)
//            print("indexPathStart \(indexPathStart)")
            
            CollectionviewForNewTrendDetails.scrollToItem(at:indexPathStart , at: .centeredHorizontally, animated: false)
        }
    }
    
    //MARK:- Button Action

    @IBAction func btn_backClickevent(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- UICollectionview Delegate and Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return arrTipsListData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell : NandTCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "NandTCollectionViewCell", for: indexPath) as? NandTCollectionViewCell
        
        let dict_Cell = arrTipsListData.object(at: indexPath.row) as? NSDictionary
        
        if ISDebug {
            print("Dict Cell : \(dict_Cell!)")
        }
        
        if let strImageUrl = dict_Cell?.value(forKey: "Img") as? String{
            
            cell?.activityIndicator.startAnimating()
            cell?.imageView_event?.sd_setImage(with: URL(string:strImageUrl), placeholderImage: UIImage(named: "placeholder.png"), options: .refreshCached, completed: { (image, error, cacheType, url) -> Void in
                
                cell?.activityIndicator.stopAnimating()
            })
        }
        
        if let strTotalLike = dict_Cell?.value(forKey: "Likelist") as? String{
            cell?.lbl_likeCount.text = strTotalLike
        }else{
            cell?.lbl_likeCount.text = "0"
        }
        
        if let strTitleName = dict_Cell?.value(forKey: "Title") as? String{
            cell?.lbl_EventTitle?.text = strTitleName
        }
        
        if let strDetails = dict_Cell?.value(forKey: "Description") as? String{
            cell?.lbl_EventDetails?.text = strDetails
        }
        
        if let strAuthorName = dict_Cell?.value(forKey: "AuthorName") as? String{
            cell?.lbl_AutherTitle?.setTitle(strAuthorName, for: .normal)
        }
        
        if let strAddress = dict_Cell?.value(forKey: "Address") as? String{
            cell?.lbl_placeName?.text = strAddress
        }
        
        if let strPostDate = dict_Cell?.value(forKey: "PostDate") as? String{
            cell?.lbl_date?.text = strPostDate
        }
        
        
        //For Like Button 
        if let str_isLikeOrNot = dict_Cell?.value(forKey: "LikeStatus") as? Int {
            
            if str_isLikeOrNot == 1 {
                cell?.btn_Like.isSelected = true
            }else{
                cell?.btn_Like.isSelected = false
            }
        }
        
        cell?.btn_Like.tag = indexPath.row
        cell?.btn_Like.addTarget(self, action: #selector(btnLikeTapped(_:)), for: .touchUpInside)
        
        cell?.btn_Direction.tag = indexPath.row
        cell?.btn_Direction.addTarget(self, action: #selector(btnAction_Direction(_:)), for: .touchUpInside)
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let size:CGSize = CGSize(width: Constants.WIDTH, height: Constants.HEIGHT - 80)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func btnLikeTapped(_ sender : UIButton){
        
        let indexForTap = sender.tag
//        print("Index of Tap Like button : \(indexForTap)")
        let dict_Cell = arrTipsListData.object(at: indexForTap) as? NSDictionary
        
        let dictChange : NSMutableDictionary = dict_Cell?.mutableCopy() as! NSMutableDictionary
        
//        print("Old Dict: \(dict_Cell!) \n")
        
        if let intTotalLikelist = dict_Cell?.value(forKey: "Likelist") as? String {
            
            var intTotalCount : Int = Int(intTotalLikelist)!
            
            if let int_isLikeOrNot = dict_Cell?.value(forKey: "LikeStatus") as? Int {
                
                if int_isLikeOrNot == 1 {
                    intTotalCount = intTotalCount - 1
                    
                    dictChange.setValue(0, forKey: "LikeStatus")
                    dictChange.setValue("\(intTotalCount)", forKey: "Likelist")
                }else{
                    intTotalCount = intTotalCount + 1
                    
                    dictChange.setValue(1, forKey: "LikeStatus")
                    dictChange.setValue("\(intTotalCount)", forKey: "Likelist")
                }
//                print("New Dict: \(dictChange)")
                
                arrTipsListData.replaceObject(at: indexForTap, with: dictChange)
                CollectionviewForNewTrendDetails.reloadData()
            }
        }
        
        if sender.isSelected{
            sender.isSelected = false
        }else{
            sender.isSelected = true
        }
        
        //Call Webservices
        if let strTipID = dict_Cell?.value(forKey: "TipID") as? String{
            
            self.perform(#selector(tipLikeUnlike), with: strTipID, afterDelay: 0.1)
//            self.tipLikeUnlike(strTipID: strTipID)
        }
    }

    func btnAction_Direction(_ sender : UIButton){
        
        let LocationSearch = self.storyboard?.instantiateViewController(withIdentifier: "LocationSearchViewController") as! LocationSearchViewController
        
        let dict_Cell = arrTipsListData.object(at: sender.tag) as? NSDictionary
        
        if let strAddress = dict_Cell?.value(forKey: "Title") as? String{
            LocationSearch.EventTilte = strAddress as NSString
        }
        if let strAddress = dict_Cell?.value(forKey: "Address") as? String{
            LocationSearch.locationName = strAddress as NSString
        }
        if let strLatitude = dict_Cell?.value(forKey: "Latitude") as? String{
            LocationSearch.Latitude = strLatitude as NSString
        }
        if let strlongitude = dict_Cell?.value(forKey: "Longitude") as? String{
            LocationSearch.longitude = strlongitude as NSString
        }
        
        self.navigationController?.pushViewController(LocationSearch, animated: true)
    }
    
    //MARK:- Webservice Methods
    
    func tipLikeUnlike(strTipID:String) -> Void {

        print("TipID : \(strTipID)")
        web.tipLikeUnlike(strUserID: appDel.instanceModelLogin.UserID, strTipID: strTipID)
    }
    
    func tipsLikeOrUnLikeResponse(responseObj: NSDictionary) -> Void{
        
        let responseAllKey : NSArray = responseObj.allKeys as NSArray
//        print("Print Array Keys : \(responseAllKey)")
        
        if responseAllKey.contains(kAPI_Status) {
            
            if let statusCode : Int = responseObj.value(forKey: kAPI_Status) as? Int {
                if statusCode == 200
                {
                    if ISDebug{
                        print("Tips like & Unlike Response \(responseObj)")
                    }
                    
                }else{
                    
                    if ISDebug{
                        print("Tips like & Unlike False")
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
    
    //MARK:- UIAlertView Show

}
