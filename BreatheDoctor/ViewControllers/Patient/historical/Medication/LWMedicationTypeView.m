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
- (void)setEmergencyButtonType:(NSInteger)type{

    if (type == 1) {

        [_emergencyButton setImage:kImage(@"medjilu") forState:UIControlStateNormal];

    }else if (type == 2)
    {
        [_emergencyButton setImage:kImage(@"medweitian") forState:UIControlStateNormal];

    }else
    {
        [_emergencyButton setImage:kImage(@"medweijilu") forState:UIControlStateNormal];
    }
}
- (void)setControlButtonType:(NSInteger)type{
    if (type == 1) {
        [_controlButton setImage:kImage(@"medjilu") forState:UIControlStateNormal];
    }else if (type == 2)
    {
        [_controlButton setImage:kImage(@"medweitian") forState:UIControlStateNormal];
    }else
    {
        [_controlButton setImage:kImage(@"medweijilu") forState:UIControlStateNormal];
    }
}
- (UIButton *)allocStarButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:kImage(@"medweitian") forState:UIControlStateNormal];
    return btn;
}

- (void)setTimerString:(NSString *)string
{
    [_timerButton setTitle:stringJudgeNull(string) forState:UIControlStateNormal];
}

@end
