//
//  KLDatePickViewController.m
//  COButton
//
//  Created by comv on 16/3/31.
//  Copyright © 2016年 comv. All rights reserved.
//

#import "KLDatePickViewController.h"
#import "KLDatePickView.h"
#import <ReactiveCocoa.h>

@interface KLDatePickViewController ()

@property (nonatomic, strong) UIView         *footContentView;
@property (nonatomic, strong) UIButton       *leftButton;
@property (nonatomic, strong) UIButton       *rightButton;
@property (nonatomic, strong) UILabel        *centerTitleLabel;
@property (nonatomic, strong) KLDatePickView *leftPickView;
@property (nonatomic, strong) KLDatePickView *rightPickView;
@end

@implementation KLDatePickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    
    [self load];
}
- (void)load{
    
    [self.view addSubview:self.footContentView];
    
    [self.footContentView addSubview:self.leftButton];
    [self.footContentView addSubview:self.rightButton];
    [self.footContentView addSubview:self.centerTitleLabel];
    [self.footContentView addSubview:self.leftPickView];
    [self.footContentView addSubview:self.rightPickView];
    
    [self.rightPickView setDateCount:60];
    [self.rightPickView setDatePeriodInfo:@"分"];
    [self.leftPickView setDateCount:24];
    [self.leftPickView setDatePeriodInfo:@"时"];
    

    UIView *line = [UIView allocAppLineView];
    [self.footContentView addSubview:line];
    
    UIView *line1 = [UIView allocAppLineView];
    [self.footContentView addSubview:line1];
    line1.sd_layout.leftSpaceToView(self.footContentView,0).topSpaceToView(self.footContentView,0).rightSpaceToView(self.footContentView,0).heightIs(.5);
    
    UILabel *label = [UILabel new];
    label.font = [UIFont boldSystemFontOfSize:30];
    label.textAlignment = 1;
    label.textColor = self.centerTitleLabel.textColor;
    label.text = @":";
    [self.footContentView addSubview:label];
    
    self.footContentView.sd_layout.bottomSpaceToView(self.view,0).
    leftSpaceToView(self.view,0).
    rightSpaceToView(self.view,0).
    heightIs(250);
    
    self.leftButton.sd_layout.leftSpaceToView(self.footContentView,10).
    topSpaceToView(self.footContentView,0).
    widthIs(40).heightIs(40);
    
    self.rightButton.sd_layout.rightSpaceToView(self.footContentView,10).
    topSpaceToView(self.footContentView,0).
    widthIs(40).heightIs(40);
    
    self.centerTitleLabel.sd_layout.
    rightSpaceToView(self.rightButton,0).
    topSpaceToView(self.footContentView,0).
    leftSpaceToView(self.leftButton,0).heightIs(40);
    
    line.sd_layout.leftSpaceToView(self.footContentView,0).
    topSpaceToView(self.leftButton,0)
    .rightSpaceToView(self.footContentView,0).
    heightIs(.6);
    
    label.sd_layout.widthIs(10).
    topSpaceToView(line,0).
    bottomSpaceToView(self.footContentView,0).
    centerXEqualToView(self.footContentView);
    
#define alphaheight 60
    UIView *leftKeduView = ({
        UIView *view = [UIView new];
        [self.footContentView addSubview:view];
        UIImageView *imageView = [UIImageView new];
        imageView.image = kImage(@"timer_kedu_left");
        [view addSubview:imageView];
        
        UIView *top = [UIView new];
        top.backgroundColor = [UIColor whiteColor];
        top.alpha = .2;
        [view addSubview:top];
        
        UIView *bottom = [UIView new];
        bottom.backgroundColor = [UIColor whiteColor];
        bottom.alpha = .2;
        [view addSubview:bottom];
        
        view.sd_layout.leftSpaceToView(self.footContentView,5).
        topSpaceToView(line,0).
        widthIs(30/2).
        bottomSpaceToView(self.footContentView,0);
        imageView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        
        top.sd_layout.leftSpaceToView(view,0).topSpaceToView(view,0).rightSpaceToView(view,0).heightIs(alphaheight);
        bottom.sd_layout.leftSpaceToView(view,0).bottomSpaceToView(view,0).rightSpaceToView(view,0).heightIs(alphaheight);
        view;
    });
    
    
    UIView *rightKeduView = ({
        UIView *view = [UIView new];
        [self.footContentView addSubview:view];
        UIImageView *imageView = [UIImageView new];
        imageView.image = kImage(@"timer_kedu_right");
        [view addSubview:imageView];
        
        UIView *top = [UIView new];
        top.backgroundColor = [UIColor whiteColor];
        top.alpha = .2;
        [view addSubview:top];
        
        UIView *bottom = [UIView new];
        bottom.backgroundColor = [UIColor whiteColor];
        bottom.alpha = .2;
        [view addSubview:bottom];
        
        view.sd_layout.rightSpaceToView(self.footContentView,5).
        topSpaceToView(line,0).
        widthIs(30/2).
        bottomSpaceToView(self.footContentView,0);
        imageView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        
        top.sd_layout.leftSpaceToView(view,0).topSpaceToView(view,0).rightSpaceToView(view,0).heightIs(alphaheight);
        bottom.sd_layout.leftSpaceToView(view,0).bottomSpaceToView(view,0).rightSpaceToView(view,0).heightIs(alphaheight);
        
        view;
    });

    self.leftPickView.sd_layout.
    leftSpaceToView(leftKeduView,0).
    topSpaceToView(line,0).
    widthIs(80).
    bottomSpaceToView(self.footContentView,0);
    
    self.rightPickView.sd_layout.
    rightSpaceToView(rightKeduView,0).
    topSpaceToView(line,0).
    widthIs(80).
    bottomSpaceToView(self.footContentView,0);
    
    
    [[self.leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {

        _completeDismiss?_completeDismiss():nil;
        [self.view setHidden:YES];
    }];
    
    [[self.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        _completeChooseBlock?_completeChooseBlock([NSString stringWithFormat:@"%@:%@",[self.leftPickView seleIndexString],[self.rightPickView seleIndexString]]):nil;
//        _completeDismiss?_completeDismiss():nil;
//        [self.view setHidden:YES];
    }];
    

}
- (void)setRightPickViewCountIndex:(NSInteger)index
{
    [self.rightPickView refDateCount:index];
}
- (void)setleftPickViewCountIndex:(NSInteger)index
{
    [self.leftPickView refDateCount:index];
}
- (KLDatePickView *)leftPickView{
    
    if (!_leftPickView) {
        _leftPickView = [KLDatePickView new];
    }
    return _leftPickView;
}
- (KLDatePickView *)rightPickView{
    
    if (!_rightPickView) {
        _rightPickView = [KLDatePickView new];
    }
    return _rightPickView;
}
- (UIView *)footContentView{
    
    if (!_footContentView) {
        _footContentView = [UIView new];
        _footContentView.backgroundColor = [UIColor whiteColor];
    }
    return _footContentView;
}
- (UILabel *)centerTitleLabel{
    
    if (!_centerTitleLabel) {
        _centerTitleLabel = [UILabel new];
        _centerTitleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _centerTitleLabel.font = kNSPXFONT(30);
        _centerTitleLabel.textAlignment = 1;
    }
    return _centerTitleLabel;
}
- (UIButton *)leftButton{
    
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.titleLabel.font = kNSPXFONT(30);
        [_leftButton setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    }
    return _leftButton;
}
- (UIButton *)rightButton{
    
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.titleLabel.font = kNSPXFONT(30);
        [_rightButton setTitleColor:[[UIColor redColor] colorWithAlphaComponent:.5] forState:UIControlStateNormal];
    }
    return _rightButton;
}
- (void)setleftButtonTitleInfo:(NSString *)title{
    [self.leftButton setTitle:title forState:UIControlStateNormal];
}
- (void)setrightButtonTitleInfo:(NSString *)title{
    [self.rightButton setTitle:title forState:UIControlStateNormal];
}
- (void)setcenterTitleLabelStringInfo:(NSString *)title{
    self.centerTitleLabel.text = title;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
