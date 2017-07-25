//
//  DKLabel.m
//
//
//  Created by Darshan kunjadiya on 09/01/17.
//  Copyright © 2017 Darshan kunjadiya. All rights reserved.
//

#import "DKLabel.h"

IB_DESIGNABLE
@implementation DKLabel
    
- (void)setMyLineSpacing:(CGFloat)myLineSpacing {
    _myLineSpacing = myLineSpacing;
    self.text = self.text;
}
    
- (void)setText:(NSString *)text {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = _myLineSpacing;
    paragraphStyle.alignment = self.textAlignment;
    NSDictionary *attributes = @{NSParagraphStyleAttributeName: paragraphStyle};
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text
                                                                         attributes:attributes];
    self.attributedText = attributedText;
}
    
@end

