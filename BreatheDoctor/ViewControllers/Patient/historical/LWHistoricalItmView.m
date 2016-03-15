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
@property (nonatomic, strong) UIButton *timeButton;

@property (nonatomic, strong) UIButton *chartButton;
@property (nonatomic, strong) UIButton *logButton;

@end

@implementation LWHistoricalItmView

- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        [self addSubview:self.menuView];
        [self.menuView addSubview:self.chartButton];
        [self.menuView addSubview:self.logButton];
        [self addSubview:self.timeButton];
        
        self.menuView.sd_layout.centerXEqualToView(self).centerYEqualToView(self).widthIs(260/2).heightIs(56/2);
        self.chartButton.sd_layout.leftSpaceToView(self.menuView,0).topSpaceToView(self.menuView,0).bottomSpaceToView(self.menuView,0).widthRatioToView(self.menuView,.5);
        self.logButton.sd_layout.leftSpaceToView(self.chartButton,0).bottomSpaceToView(self.menuView,0).rightSpaceToView(self.menuView,0).topSpaceToView(self.menuView,0);
        self.timeButton.sd_layout.rightSpaceToView(self,0).bottomSpaceToView(self,0).topSpaceToView(self,0).widthIs(45);
        
    }
    return self;
}
#pragma mark -init
- (UIButton *)chartButton
{
    if (!_chartButton) {
        _chartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _chartButton.titleLabel.font = kNSPXFONT(28);
        [_chartButton setTitle:@"图表" forState:UIControlStateNormal];
        _chartButton.backgroundColor = [LWThemeManager shareInstance].navBackgroundColor;
        [_chartButton setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [_chartButton setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateSelected];
        [_chartButton addTarget:self action:@selector(chartButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _chartButton.selected = YES;
    }
    return _chartButton;
    
}
- (UIButton *)logButton
{
    if (!_logButton) {
        _logButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _logButton.titleLabel.font = kNSPXFONT(28);
        [_logButton setTitle:@"日志" forState:UIControlStateNormal];
        _logButton.backgroundColor = [UIColor whiteColor];
        [_logButton setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [_logButton setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateSelected];
        [_logButton addTarget:self action:@selector(logButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logButton;
    
}
- (UIView *)menuView
{
    if (!_menuView) {
        _menuView = [[UIView alloc] init];
        _menuView.backgroundColor = [UIColor whiteColor];
        [_menuView setCornerRadius:3.0f];
    }
    return _menuView;
}

- (UIButton *)timeButton
{
    if (!_timeButton) {
        _timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_timeButton setImage:kImage(@"riqi") forState:UIControlStateNormal];
        [_timeButton addTarget:self action:@selector(timeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _timeButton;

}
#pragma mark -click
- (void)timeButtonClick:(UIButton *)sender
{
    _timeButtonBlock?_timeButtonBlock():nil;
}
- (void)chartButtonClick:(UIButton *)sender
{
    _chartButtonBlock?_chartButtonBlock():nil;
    [self changeButtonTag:0];
}
- (void)logButtonClick:(UIButton *)sender
{
    _logButtonBlock?_logButtonBlock():nil;
    [self changeButtonTag:1];
}
- (void)changeButtonTag:(NSInteger)tag
{
    if (tag == 0) {
        self.chartButton.selected = YES;
        self.logButton.selected = NO;
        self.chartButton.backgroundColor = [LWThemeManager shareInstance].navBackgroundColor;
        self.logButton.backgroundColor = [UIColor whiteColor];
    }else
    {
        self.chartButton.selected = NO;
        self.logButton.selected = YES;
        self.chartButton.backgroundColor = [UIColor whiteColor];
        self.logButton.backgroundColor = [LWThemeManager shareInstance].navBackgroundColor;
    }
    
}

@end
