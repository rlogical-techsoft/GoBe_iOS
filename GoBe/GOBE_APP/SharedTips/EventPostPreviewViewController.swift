//
//  EventPostPreviewViewController.swift
//  GoBe
//
//  Created by rlogical-dev-35 on 29/07/17.
//  Copyright © 2017 rlogical-dev-35. All rights reserved.
//

import UIKit

class EventPostPreviewViewController: UIViewController {

    var str_visibility : NSString?

    var Dict_SharedEvent : NSDictionary!

    @IBOutlet weak var CollectionviewForNewTrendDetails: UICollectionView!

    var arrTipsListData : NSMutableArray = []
    var intStartIndex : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //MARK:- UICollectionview Delegate and Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell : NandTCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "NandTCollectionViewCell", for: indexPath) as? NandTCollectionViewCell
        
        if let strImageUrl = Dict_SharedEvent?.value(forKey: "EventImage") as? String{
            
            cell?.activityIndicator.startAnimating()
            cell?.imageView_event?.sd_setImage(with: URL(string:strImageUrl), placeholderImage: UIImage(named: "placeholder.png"), options: .refreshCached, completed: { (image, error, cacheType, url) -> Void in
                
                cell?.activityIndicator.stopAnimating()
            })
        }
        
        if let strTitleName = Dict_SharedEvent?.value(forKey: "EventTitle") as? String{
            cell?.lbl_EventTitle?.text = strTitleName
        }
        
        if let strDetails = Dict_SharedEvent?.value(forKey: "EventDescription") as? String{
            cell?.lbl_EventDetails?.text = strDetails
        }
        
            cell?.lbl_AutherTitle?.setTitle("By You", for: .normal)
        
        if let strAddress = Dict_SharedEvent?.value(forKey: "Address") as? String{
            cell?.lbl_placeName?.text = strAddress
        }
        
        cell?.lbl_date?.text = "22/7/2017"
        
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btn_PostClick(_ sender: Any) {
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
