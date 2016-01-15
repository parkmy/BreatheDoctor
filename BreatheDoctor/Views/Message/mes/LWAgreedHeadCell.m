//
//  LWAgreedHeadCell.m
//  BreatheDoctor
//
//  Created by comv on 16/1/4.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWAgreedHeadCell.h"
#import <UIButton+WebCache.h>

@implementation LWAgreedHeadCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.headButton setCornerRadius:3.0F];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
    line.backgroundColor = RGBA(0, 0, 0, .3);
    [self addSubview:line];
    line.sd_layout.bottomSpaceToView(self,0).leftSpaceToView(self,0).rightSpaceToView(self,0).heightIs(.5);

    [self.headButton sd_setBackgroundImageWithURL:nil forState:UIControlStateNormal placeholderImage:kImage(@"yishengzhushousy_03.png")];
    self.patientNameLabel.text = @"那样怀念";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
