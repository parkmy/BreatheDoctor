//
//  LWMedicationTypeView.m
//  BreatheDoctor
//
//  Created by comv on 16/3/17.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWMedicationTypeView.h"

@interface LWMedicationTypeView ()

@property (nonatomic, strong) UIButton *timerButton;
@property (nonatomic, strong) UIButton *controlButton;
@property (nonatomic, strong) UIButton *emergencyButton;

@end

@implementation LWMedicationTypeView


- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        
        _timerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _timerButton.titleLabel.font = kNSPXFONT(22);
        [_timerButton setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [self addSubview:_timerButton];
        
        _controlButton = [self allocStarButton];
        [self addSubview:_controlButton];
        
        _emergencyButton = [self allocStarButton];
        [self addSubview:_emergencyButton];
        
        _timerButton.sd_layout.leftSpaceToView(self,0).topSpaceToView(self,0).bottomSpaceToView(self,0).widthRatioToView(self,.333333333);
        _controlButton.sd_layout.leftSpaceToView(_timerButton,0).topSpaceToView(self,0).bottomSpaceToView(self,0).widthRatioToView(self,.333333333);
        _emergencyButton.sd_layout.leftSpaceToView(_controlButton,0).topSpaceToView(self,0).bottomSpaceToView(self,0).widthRatioToView(self,.333333333);

    }
    return self;
}

- (UIButton *)allocStarButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:kImage(@"medweitian") forState:UIControlStateNormal];
    [btn setImage:kImage(@"medweijilu") forState:UIControlStateHighlighted];
    [btn setImage:kImage(@"medjilu") forState:UIControlStateSelected];

    return btn;
}

- (void)setTimerString:(NSString *)string
{
    [_timerButton setTitle:stringJudgeNull(string) forState:UIControlStateNormal];
}

@end
