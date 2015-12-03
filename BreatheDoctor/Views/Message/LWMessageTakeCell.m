//
//  LWMessageTakeCell.m
//  BreatheDoctor
//
//  Created by comv on 15/11/10.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWMessageTakeCell.h"
#import <UIImageView+WebCache.h>

@implementation LWMessageTakeCell

- (void)awakeFromNib {
    // Initialization code
    [self.userIcon setCornerRadius:5.0f];
    [self.acceptButton setCornerRadius:5.f];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)acceptButtonClick:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(tapAcceptButtonEventWith:)]) {
        [_delegate tapAcceptButtonEventWith:self.message];
    }
}

- (void)setMessage:(LWMainRows *)message
{
    _message = message;

    [self.userIcon sd_setImageWithURL:nil placeholderImage:kImage(@"yishengzhushousy_03.png")];
    self.userNameLabel.text = stringJudgeNull(_message.patientName);

    
}

@end
