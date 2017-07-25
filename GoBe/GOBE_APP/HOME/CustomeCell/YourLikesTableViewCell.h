//
//  YourLikesTableViewCell.h
//  GoBe
//
//  Created by SPARE CODE on 4/1/17.
//  Copyright © 2017 SPARE CODE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface YourLikesTableViewCell : SWTableViewCell

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *img_activityIndi;
@property (weak, nonatomic) IBOutlet UIImageView *imgPicture;
@property (weak, nonatomic) IBOutlet UIImageView *backgroungImgView;

@property (weak, nonatomic) IBOutlet UIButton *btnLikeHeart;

@property (weak, nonatomic) IBOutlet UILabel *lblHeader;

@property (weak, nonatomic) IBOutlet UILabel *lblDescription;

@property (weak, nonatomic) IBOutlet UILabel *lblName;



@end
