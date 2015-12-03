//
//  LWPersonalMessageCell.m
//  BreatheDoctor
//
//  Created by comv on 15/11/11.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWPersonalMessageCell.h"

@implementation LWPersonalMessageCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setMessage:(NSString *)message
{
    CGFloat h = [message sizeWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:160].height + 10;
    self.messageHight.constant = h+5;
    self.messageLabel.text = stringJudgeNull(message);
}

@end
