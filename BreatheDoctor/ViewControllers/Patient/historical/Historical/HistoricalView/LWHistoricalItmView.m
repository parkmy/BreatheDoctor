//
//  LWHistoricalItmView.m
//  BreatheDoctor
//
//  Created by comv on 16/3/14.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWHistoricalItmView.h"

@interface LWHistoricalItmView ()

@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation LWHistoricalItmView
- (id)initWithSize:(CGSize)size leftTitle:(NSString *)left rightTitle:(NSString *)right
{
    if ([super init])
    {
        [self addSubview:self.menuView];
        [self.menuView addSubview:self.leftButton];
        [self.menuView addSubview:self.rightButton];
        [self.leftButton setTitle:stringJudgeNull(left) forState:UIControlStateNormal];
        [self.rightButton setTitle:stringJudgeNull(right) forState:UIControlStateNormal];
        
        self.menuView.sd_layout.centerXEqualToView(self).centerYEqualToView(self).widthIs(size.width).heightIs(size.height);
        self.leftButton.sd_layout.leftSpaceToView(self.menuView,0).topSpaceToView(self.menuView,0).bottomSpaceToView(self.menuView,0).widthRatioToView(self.menuView,.5);
        self.rightButton.sd_layout.leftSpaceToView(self.leftButton,0).bottomSpaceToView(self.menuView,0).rightSpaceToView(self.menuView,0).topSpaceToView(self.menuView,0);
    }
    return self;
}
#pragma mark -init
- (UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.titleLabel.font = kNSPXFONT(28);
        _leftButton.backgroundColor = [LWThemeManager shareInstance].navBackgroundColor;
        [_leftButton setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [_leftButton setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateSelected];
        [_leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _leftButton.selected = YES;
    }
    return _leftButton;
    
}
- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.titleLabel.font = kNSPXFONT(28);
        _rightButton.backgroundColor = [UIColor whiteColor];
        [_rightButton setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateSelected];
        [_rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}
- (UIView *)menuView
{
    if (!_menuView) {
        _menuView = [[UIView alloc] init];
        _menuView.backgroundColor = [UIColor whiteColor];
        [_menuView setCornerRadius:3.0f];
        _menuView.layer.borderColor = appLineColor.CGColor;
        _menuView.layer.borderWidth = .5;
    }
    return _menuView;
}

//- (UIButton *)timeButton
//{
//    if (!_timeButton) {
//        _timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_timeButton setImage:kImage(@"riqi") forState:UIControlStateNormal];
//        [_timeButton addTarget:self action:@selector(timeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _timeButton;
//
//}
#pragma mark -click
//- (void)timeButtonClick:(UIButton *)sender
//{
//    _timeButtonBlock?_timeButtonBlock():nil;
//}
- (void)leftButtonClick:(UIButton *)sender
{
    _leftButtonBlock?_leftButtonBlock():nil;
    [self changeButtonTag:0];
}
- (void)rightButtonClick:(UIButton *)sender
{
    _rightButtonBlock?_rightButtonBlock():nil;
    [self changeButtonTag:1];
}
- (void)changeButtonTag:(NSInteger)tag
{
    if (tag == 0) {
        self.leftButton.selected = YES;
        self.rightButton.selected = NO;
        self.leftButton.backgroundColor = [LWThemeManager shareInstance].navBackgroundColor;
        self.rightButton.backgroundColor = [UIColor whiteColor];
    }else
    {
        self.leftButton.selected = NO;
        self.rightButton.selected = YES;
        self.leftButton.backgroundColor = [UIColor whiteColor];
        self.rightButton.backgroundColor = [LWThemeManager shareInstance].navBackgroundColor;
    }
    
}

@end
