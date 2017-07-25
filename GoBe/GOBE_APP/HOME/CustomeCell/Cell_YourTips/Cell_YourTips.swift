//
//  Cell_YourTips.swift
//  GoBe
//
//  Created by macmini on 04/07/17.
//  Copyright © 2017 rlogical-dev-35. All rights reserved.
//

import UIKit


class Cell_YourTips: SWTableViewCell {

    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var img_activityIndi: UIActivityIndicatorView!
    @IBOutlet weak var view_LeftMenu: UIView!
    @IBOutlet weak var view_RightMenu: UIView!
    
    @IBOutlet weak var imgPicture :UIImageView!
    @IBOutlet weak var btnLikeHeart :UIButton!
    @IBOutlet weak var lblHeader :UILabel!
    
    @IBOutlet weak var lblDescription :UILabel!
    
    @IBOutlet weak var lblName :UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
