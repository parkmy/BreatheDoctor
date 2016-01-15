//
//  LWPersonalCell.m
//  BreatheDoctor
//
//  Created by comv on 15/11/10.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWPersonalCell.h"

@implementation LWPersonalCell

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
- (IBAction)leftButtonClick:(LWPersonalMenuButton *)sender {
    _personalMenuButtonTapBlock?_personalMenuButtonTapBlock(sender.tapType):nil;
}
- (IBAction)rightButtonClick:(LWPersonalMenuButton *)sender {
    _personalMenuButtonTapBlock?_personalMenuButtonTapBlock(sender.tapType):nil;
}

@end
