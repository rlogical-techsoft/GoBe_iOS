//
//  Cell_PublicList.swift
//  GoBe
//
//  Created by macmini on 04/07/17.
//  Copyright © 2017 rlogical-dev-35. All rights reserved.
//

import UIKit

class Cell_PublicList: SWTableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var img_permissionStatus: UIImageView!
    
    @IBOutlet weak var lbl_authorName: UILabel!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
