//
//  KLStateView.m
//  BreatheDoctor
//
//  Created by comv on 16/3/27.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLStateView.h"

@interface KLStateView ()
@property (nonatomic, copy) UILabel *stateLabel;
@end

@implementation KLStateView

- (id)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        
        _stateLabel = ({
            UILabel *label = [UILabel new];
            [self addSubview:label];
            label.textAlignment = 1;
            label.font = kNSPXFONT(28);
            label;
        });
        _stateLabel.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    }
    return self;
}

- (void)stateLabelText:(NSString *)string{

    _stateLabel.text = stringJudgeNull(string);
}

- (void)setStateColor:(UIColor *)stateColor{
    _stateColor = stateColor;
    _stateLabel.textColor = stateColor;
    self.layer.borderWidth = .5;
    self.layer.borderColor = _stateColor.CGColor;
    [self setCornerRadius:3.0f];
}
@end
