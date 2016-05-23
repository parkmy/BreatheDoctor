//
//  KLRegisteredViewCell.m
//  BreatheDoctor
//
//  Created by comv on 16/5/18.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLRegisteredViewCell.h"
#import "KLRegistModel.h"

@implementation KLRegisteredViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.selectionStyle = 0;
        
        _registTitleLabel = [UILabel new];
        _registTitleLabel.textColor = [UIColor colorWithHexString:@"#383838"];
        _registTitleLabel.font = kNSPXFONT(32);
        
        _registField = [UITextField new];
        _registField.borderStyle = UITextBorderStyleNone;
        _registField.font = _registTitleLabel.font;
        _registField.textColor = _registTitleLabel.textColor;
        _registField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _registField.keyboardType = UIKeyboardTypeEmailAddress;
        _registField.delegate = self;
        
        WEAKSELF
        _timeVcodeButton = [[KLTimeButton alloc] initWithFrame:CGRectZero AndBeforeTitle:@"获取验证码" AndWorkingMarkStr:@"" AndTimeSum:60 AndTimeButtonStar:^{
            
            KL_weakSelf.timerVcodeButtonStarBlock?KL_weakSelf.timerVcodeButtonStarBlock(_timeVcodeButton):nil;
        } AndTimeButtonStop:^{
        }];
        
        _timeVcodeButton.font = kNSPXFONT(24);
        _timeVcodeButton.textAlignment = 1;
        _timeVcodeButton.textColor = [LWThemeManager shareInstance].navBackgroundColor;
        _timeVcodeButton.layer.borderColor = _timeVcodeButton.textColor.CGColor;
        _timeVcodeButton.layer.borderWidth = .5;
        [_timeVcodeButton setCornerRadius:4.0f];
        
        [self sd_addSubviews:@[_registTitleLabel,_registField,_timeVcodeButton]];
        
        _registTitleLabel.sd_layout
        .leftSpaceToView(self,10)
        .centerYEqualToView(self)
        .heightIs(20)
        .widthIs(60);
        
        _timeVcodeButton.sd_layout
        .heightIs(25*MULTIPLEVIEW)
        .rightSpaceToView(self,5)
        .centerYEqualToView(self)
        .widthIs(0);
        
        _registField.sd_layout
        .leftSpaceToView(_registTitleLabel,10)
        .rightSpaceToView(_timeVcodeButton,5)
        .heightIs(45)
        .centerYEqualToView(self);
        
    }
    return self;
}

- (void)setModel:(KLRegistModel *)model{

    _model = model;
    
    if (_model.type == FieldTypeDef) {
        
        self.timeVcodeButton.sd_layout.widthIs(0);
    }else{
        
        self.timeVcodeButton.sd_layout.widthIs(77*MULTIPLEVIEW);
    }
    
    self.registTitleLabel.text = [NSString stringJudgeNullInfoString:_model.title];
    self.registField.placeholder = [NSString stringJudgeNullInfoString:_model.placeholderString];
    self.registField.secureTextEntry = _model.isSecureTextEntry;

}
#pragma mark -UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location > self.model.maxCount)
    {
        return  NO;
    }
    else
    {
        self.model.fieldText = [NSString stringWithFormat:@"%@%@",[NSString stringJudgeNullInfoString:textField.text],string];
        return YES;
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    self.model.fieldText = self.registField.text.length>0?self.registField.text:@"";
    return YES;
}

@end
