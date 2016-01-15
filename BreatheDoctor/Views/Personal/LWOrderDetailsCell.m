//
//  LWOrderDetailsCell.m
//  BreatheDoctor
//
//  Created by comv on 15/12/31.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWOrderDetailsCell.h"

@implementation LWOrderDetailsCell

- (void)awakeFromNib {
    // Initialization code
    for (NSLayoutConstraint *layout in self.labelWidths) {
        layout.constant = .5;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
