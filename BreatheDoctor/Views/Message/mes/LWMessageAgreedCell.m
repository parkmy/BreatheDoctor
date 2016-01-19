//
//  LWMessageAgreedCell.m
//  BreatheDoctor
//
//  Created by comv on 16/1/4.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWMessageAgreedCell.h"

@implementation LWMessageAgreedCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.leftbutton.layer.borderColor = [LWThemeManager shareInstance].navBackgroundColor.CGColor;
    self.leftbutton.layer.borderWidth = .5;
    [self.leftbutton setCornerRadius:5.0f];
    
    [self.rightButton setCornerRadius:5.0f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)leftButtonClick:(id)sender {
    _JuJueBlock?_JuJueBlock():nil;
}
- (IBAction)rightButtonClick:(id)sender {
    _TongYiBlock?_TongYiBlock():nil;
}

@end
