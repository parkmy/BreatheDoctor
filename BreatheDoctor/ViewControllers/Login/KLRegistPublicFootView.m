//
//  KLRegistPublicFootView.m
//  BreatheDoctor
//
//  Created by comv on 16/5/18.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLRegistPublicFootView.h"

@interface KLRegistPublicFootView ()

@property (nonatomic, strong) UIButton *nextButton;

@property (nonatomic, strong) UIButton *registAgreementButton;
@property (nonatomic, strong) UILabel  *registTitleLabel;

@end

@implementation KLRegistPublicFootView

- (id)initWithFrame:(CGRect)frame{

    if ([super initWithFrame:frame]) {
        
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.backgroundColor = [LWThemeManager shareInstance].navBackgroundColor;
        _nextButton.titleLabel.font = kNSPXFONT(36);
        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextButton setCornerRadius:4.0f];
        
        _registTitleLabel = [UILabel new];
        _registTitleLabel.text = @"注册即代表同意";
        _registTitleLabel.font = kNSPXFONT(24);
        _registTitleLabel.textColor = RGBA(160, 160, 160, 1);
        
        _registAgreementButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registAgreementButton.backgroundColor = [UIColor clearColor];
        _registAgreementButton.titleLabel.font = kNSPXFONT(24);
        [_registAgreementButton setTitleColor:_nextButton.backgroundColor forState:UIControlStateNormal];
        [_registAgreementButton setTitle:@"《呼吸卫士医生版服务协议》" forState:UIControlStateNormal];
        
        
        [self sd_addSubviews:@[_nextButton,_registTitleLabel,_registAgreementButton]];
        
        _nextButton.sd_layout
        .leftSpaceToView(self,5)
        .rightSpaceToView(self,5)
        .topSpaceToView(self,25)
        .heightIs(40*MULTIPLEVIEW);
        
        _registTitleLabel.sd_layout
        .leftSpaceToView(self,5)
        .topSpaceToView(_nextButton,10)
        .heightIs(0)
        .widthIs(0);
        
        _registAgreementButton.sd_layout
        .leftSpaceToView(_registTitleLabel,5)
        .topSpaceToView(_nextButton,10)
        .heightIs(0)
        .widthIs(0);
        
        [self setupAutoHeightWithBottomView:_registAgreementButton bottomMargin:0];
        
        WEAKSELF
        [[_nextButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            KL_weakSelf.nextButtonClickBlock?KL_weakSelf.nextButtonClickBlock():nil;
        }];
        
        [[_registAgreementButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
           
            KL_weakSelf.pushAgreementClickBlock?KL_weakSelf.pushAgreementClickBlock():nil;
        }];
        
    }
    return self;
}

- (void)setRegistPublicType:(RegistPublicType)registPublicType{

    _registPublicType = registPublicType;
    
    if (_registPublicType == RegistPublicTypeDef) {
        
        self.registTitleLabel.sd_layout
        .widthIs([self.registTitleLabel.text widthWithFont:self.registTitleLabel.font constrainedToHeight:self.registTitleLabel.height])
        .heightIs(20);
        
        self.registAgreementButton.sd_layout.widthIs([self.registAgreementButton.titleLabel.text widthWithFont:self.registAgreementButton.titleLabel.font constrainedToHeight:self.registAgreementButton.height])
        .heightIs(20);
        
        [self.nextButton setTitle:@"注册" forState:UIControlStateNormal];
        
    }else{
        
        self.registTitleLabel.sd_layout.widthIs(0);
        self.registAgreementButton.sd_layout.widthIs(0);
        [self.nextButton setTitle:@"提交" forState:UIControlStateNormal];

    }
}




@end
