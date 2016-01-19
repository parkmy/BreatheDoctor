//
//  LWMessageCell.m
//  BreatheDoctor
//
//  Created by comv on 15/11/10.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWMessageCell.h"
#import <UIImageView+WebCache.h>
#import "NSDate+Extension.h"

@implementation LWMessageCell

- (void)awakeFromNib {
    // Initialization code
    [self.messageCountLabel setCornerRadius:self.messageCountLabel.height/2];
    [self.userIcon setCornerRadius:5.0f];
    self.messageCountLabel.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMessage:(LWMainRows *)message
{
    _message = message;
    
    [self.userIcon sd_setImageWithURL:kNSURL(stringJudgeNull(_message.headImageUrl)) placeholderImage:kImage(@"yishengzhushousy_03.png")];
    if (_message.msgType == 110) {
        self.userIcon.image = kImage(@"xinhaoyou");
    }
    self.userNameLabel.text = stringJudgeNull(_message.patientName);
    self.mesCotentLabel.text = stringJudgeNull(_message.msgContent);
    self.dateLabel.text = [NSDate timeInfoWithDateString:stringJudgeNull(_message.insertDt)];
    if (_message.count > 0) {
        self.messageCountLabel.text = [NSString stringWithFormat:@"%@",kNSNumDouble(_message.count)];
        self.messageCountLabel.hidden = NO;
    }else
    {
        self.messageCountLabel.hidden = YES;
    }
}

@end
