//
//  KLMessageCell.m
//  BreatheDoctor
//
//  Created by comv on 16/4/25.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLMessageCell.h"
#import <UIImageView+WebCache.h>
#import "NSDate+Extension.h"

@implementation KLMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
//        self.selectionStyle = 0;
        
        [self sd_addSubviews:@[self.userIcon,self.messageCountLabel,self.userNameLabel,self.messageLabel,self.dateLabel]];
        
        self.userIcon.sd_layout
        .leftSpaceToView(self,10)
        .topSpaceToView(self,10)
        .bottomSpaceToView(self,10)
        .widthEqualToHeight();
        
        self.messageCountLabel.sd_layout
        .topSpaceToView(self,5)
        .leftSpaceToView(self.userIcon,-10)
        .widthIs(20)
        .heightIs(20);
        
        self.dateLabel.sd_layout
        .rightSpaceToView(self,10)
        .topSpaceToView(self,10)
        .heightIs(20)
        .widthIs(50);
        
        self.userNameLabel.sd_layout
        .leftSpaceToView(self.messageCountLabel,5)
        .rightSpaceToView(self.dateLabel,5)
        .topSpaceToView(self,11.5)
        .heightIs(20);
        
        self.messageLabel.sd_layout
        .leftEqualToView(self.userNameLabel)
        .rightSpaceToView(self,10)
        .bottomSpaceToView(self,11.5)
        .heightIs(20);
        
        [self.userIcon updateLayout];
    }
    return self;
}

- (UILabel *)messageLabel{
    
    if (!_messageLabel) {
        _messageLabel = [UILabel new];
        _messageLabel.font = kNSPXFONT(28);
        _messageLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    }
    return _messageLabel;
}

- (UILabel *)userNameLabel{
    
    if (!_userNameLabel) {
        _userNameLabel = [UILabel new];
        _userNameLabel.font = kNSPXFONT(32);
        _userNameLabel.textColor = [UIColor colorWithHexString:@"#333333"];

    }
    return _userNameLabel;
}

- (UILabel *)messageCountLabel{
    
    if (!_messageCountLabel) {
        _messageCountLabel = [UILabel new];
        _messageCountLabel.font = kNSPXFONT(24);
        _messageCountLabel.textAlignment = 1;
        _messageCountLabel.textColor = [UIColor whiteColor];
        _messageCountLabel.backgroundColor = RGBA(244, 53, 48, 1);
        _messageCountLabel.adjustsFontSizeToFitWidth = YES;
        [_messageCountLabel setCornerRadius:10];
    }
    return _messageCountLabel;
}

- (UILabel *)dateLabel{
    
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.textAlignment = NSTextAlignmentRight;
        _dateLabel.font = kNSPXFONT(26);
        _dateLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    }
    return _dateLabel;
}

- (UIImageView *)userIcon{
    
    if (!_userIcon) {
        _userIcon = [UIImageView new];
        _userIcon.image = kImage(@"yishengzhushousy_03.png");
        [_userIcon setCornerRadius:5.0f];
    }
    return _userIcon;
}

- (void)setMessageModel:(LWMainRows *)messageModel
{
    _messageModel = messageModel;
    
    [self.userIcon sd_setImageWithURL:kNSURL(stringJudgeNull(_messageModel.headImageUrl)) placeholderImage:kImage(@"yishengzhushousy_03.png")];
    
    if (_messageModel.msgType == 110) {
        self.userIcon.image = kImage(@"xinhaoyou");
    }
    self.userNameLabel.text = stringJudgeNull(_messageModel.patientName);
    self.messageLabel.text = stringJudgeNull(_messageModel.msgContent);
    self.dateLabel.text = [NSDate timeInfoWithDateString:stringJudgeNull(_messageModel.insertDt)];
    if (_messageModel.count > 0) {
        self.messageCountLabel.text = [NSString stringWithFormat:@"%@",kNSNumDouble(_messageModel.count)];
        self.messageCountLabel.hidden = NO;
    }else
    {
        self.messageCountLabel.hidden = YES;
    }
}
@end
