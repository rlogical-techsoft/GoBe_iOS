//
//  NandTCollectionViewCell.swift
//  GoBe
//
//  Created by rlogical-dev-35 on 13/07/17.
//  Copyright © 2017 rlogical-dev-35. All rights reserved.
//

import UIKit

class NandTCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var view_EventTitle: UIView!
    
    @IBOutlet weak var btn_Like: UIButton!
    @IBOutlet var btn_Direction: UIButton!
    
    @IBOutlet weak var View_bottom: UIView!
    @IBOutlet weak var image_pod: UIImageView!
    
    @IBOutlet weak var lbl_date: UILabel?
    @IBOutlet weak var lbl_placeName: UILabel?
    @IBOutlet weak var view_PlaceandDate: UIView?
    @IBOutlet weak var lbl_AutherTitle: UIButton?
    @IBOutlet weak var lbl_EventDetails: UILabel?
    @IBOutlet weak var lbl_likeCount: UILabel!
    @IBOutlet weak var lbl_EventTitle: UILabel?
    @IBOutlet weak var imageView_event: UIImageView?
    @IBOutlet weak var swipeView: UIView?

}
