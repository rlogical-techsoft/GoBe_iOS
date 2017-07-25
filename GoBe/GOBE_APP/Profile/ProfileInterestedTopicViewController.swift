//
//  ProfileInterestedTopicViewController.swift
//  GoBe
//
//  Created by rlogical-dev-35 on 17/07/17.
//  Copyright © 2017 rlogical-dev-35. All rights reserved.
//

import UIKit

class ProfileInterestedTopicViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{

    //MARK:- IBOutlets
    
    @IBOutlet weak var scrollview_content: UIScrollView!
    @IBOutlet weak var view_allContent: UIView!
    @IBOutlet weak var collectionView_Button: UICollectionView!
    
    //MARK:- Variable
    var Arr_interstedCat = NSMutableArray()
    var selectedIndex = Int ()
    var isselcted : Bool = false

    //MARK:- UIView Methods
    
    override func viewDidLoad(){
        super.viewDidLoad()

        Arr_interstedCat = ["PLACES & SIGHTS","ART & DESIGN","EAT & DRINK","NIGHTLIFE","SPORT & THE OUTDOORS","KIDS & FAMILIES"]

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
        
        return Arr_interstedCat.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell : InterestedCatCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestedCatCollectionViewCell", for: indexPath) as? InterestedCatCollectionViewCell
     
        cell?.btn_Cat.setTitle(Arr_interstedCat[indexPath.row] as? String, for: .normal)
        
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

    
    //MARK:- Navigation
    
    func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
}


