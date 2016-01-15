//
//  LWOrderCountCell.m
//  BreatheDoctor
//
//  Created by comv on 15/12/31.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWOrderCountCell.h"

@implementation LWOrderCountCell

- (void)awakeFromNib {
    // Initialization code
    self.buyCountLabel.layer.borderWidth = .5;
    self.buyCountLabel.layer.borderColor = RGBA(0, 0, 0, .3).CGColor;
    self.orederCountLabel.layer.borderWidth = .5;
    self.orederCountLabel.layer.borderColor = RGBA(0, 0, 0, .3).CGColor;
    [self.buyCountLabel setCornerRadius:self.buyCountLabel.width/2];
    [self.orederCountLabel setCornerRadius:self.buyCountLabel.width/2];
    
    self.buyCountLabel.font = [UIFont fontWithName:@"Helvetica-Oblique" size:28];
    self.orederCountLabel.font = [UIFont fontWithName:@"Helvetica-Oblique" size:28];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
