//
//  LWPersonCenterIconCell.m
//  BreatheDoctor
//
//  Created by comv on 15/11/11.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWPersonCenterIconCell.h"

@implementation LWPersonCenterIconCell

- (void)awakeFromNib {
    // Initialization code
    [self.userIcon setCornerRadius:2.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
