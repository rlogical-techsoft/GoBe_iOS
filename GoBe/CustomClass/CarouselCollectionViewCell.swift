//
//  CarouselCollectionViewCell.swift
//  UPCarouselFlowLayoutDemo
//
//  Created by Paul Ulric on 23/06/2016.
//  Copyright © 2016 Paul Ulric. All rights reserved.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet var imgActivityIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var lbl_authorName: UILabel!
    @IBOutlet weak var lbl_eventDetails: UILabel!
    @IBOutlet var lbl_eventTitle: UITextView!
    
    
    @IBOutlet var Cell_backgroundImge: UIImageView!
    
    static let identifier = "CarouselCollectionViewCell"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor(red: 110.0/255.0, green: 80.0/255.0, blue: 140.0/255.0, alpha: 1.0).cgColor
    }
}
