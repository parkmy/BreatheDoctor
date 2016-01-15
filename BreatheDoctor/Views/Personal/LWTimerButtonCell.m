//
//  LWTimerButtonCell.m
//  BreatheDoctor
//
//  Created by comv on 15/12/31.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWTimerButtonCell.h"

@interface LWTimerButtonCell ()

@end

@implementation LWTimerButtonCell

- (void)awakeFromNib {
    // Initialization code
    
    for (NSLayoutConstraint *layout in self.whs) {
        layout.constant = .5;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)starButtonEventClick:(UIButton *)sender {
    _tapStarButtonBlock?_tapStarButtonBlock(self.starLabel):nil;
}
- (IBAction)endButtonEventClick:(UIButton *)sender {
    _tapEndButtonBlock?_tapEndButtonBlock(self.endLabel):nil;
}
- (IBAction)moreButtonClick:(id)sender {
    _tapMoreButtonBlock?_tapMoreButtonBlock(self.weekslabel):nil;
}

@end
