//
//  KLSuperViewController.m
//  COButton
//
//  Created by comv on 16/5/16.
//  Copyright © 2016年 comv. All rights reserved.
//


#import "KLSuperViewController.h"
#import "KLNavigationBarView.h"

@interface KLSuperViewController ()

@end

@implementation KLSuperViewController


- (void)viewDidLoad{

    [super viewDidLoad];
   
    [self setNavBar];

    [self set_kl_nav_Block];

}


- (void)setNavBar{
    
    //边缘不留白
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.barView.frame = CGRectMake(0, 0, screenWidth, BARHIGHT);
    [self.view addSubview:self.barView];
    
//    self.barView.sd_layout
//    .topSpaceToView(self.view,0)
//    .leftSpaceToView(self.view,0)
//    .rightSpaceToView(self.view,0)
//    .heightIs(BARHIGHT);
}

- (KLNavigationBarView *)barView{
    
    if (!_barView) {
        
        _barView = [KLNavigationBarView new];
    }
    return _barView;
}
#pragma mark -event
- (void)set_kl_nav_Block{

    __weak typeof(self)weakSelf = self;
    [self.barView setLeftNavBarClickBlock:^(id sender) {
        
        [weakSelf navLeftButtonAction];
    }];

    [self.barView setRightNavBarClickBlock:^(id sender) {
        
        [weakSelf navRightButtonAction];
    }];
}
- (void)navLeftButtonAction{};
- (void)navRightButtonAction{};
#pragma mark -navitmset
- (void)setNavLeftContent:(NSString *)navLeftContent{
   
    _navLeftContent = navLeftContent;
    if (_navLeftContent.length > 0) {
        
        if ([_navLeftContent containsaString:@"png"] || [UIImage imageNamed:_navLeftContent]) {
            
            self.barView.leftImage = [UIImage imageNamed:_navLeftContent];
        }else{
            
            self.barView.leftTitle = _navLeftContent;
        }
    }
}

- (void)setNavRightContent:(NSString *)navRightContent{
    
    _navRightContent = navRightContent;
    if (_navRightContent.length > 0) {
        
        if ([_navRightContent containsaString:@"png"]) {
            
            self.barView.rightImage = [UIImage imageNamed:_navRightContent];
        }else{
            
            self.barView.rightTitle = _navRightContent;
        }
    }
}

- (void)setCustomCenterView:(UIView *)customCenterView{
    
    _customCenterView = customCenterView;
    self.barView.customNavCenterView = _customCenterView;
}

- (void)setNavCenterTitle:(NSString *)navCenterTitle{
    
    _navCenterTitle = navCenterTitle;
    if (_navCenterTitle.length > 0) {
        
        self.barView.navTitle = _navCenterTitle;
    }
}

- (void)setNavBarBackColor:(UIColor *)navBarBackColor{
    
    _navBarBackColor = navBarBackColor;
    self.barView.backgroundColor = navBarBackColor?navBarBackColor:self.barView.backgroundColor;
}

- (void)setNavBarAlpha:(CGFloat)navBarAlpha{

    _navBarAlpha = navBarAlpha;
    self.barView.backgroundColor = [self.barView.backgroundColor colorWithAlphaComponent:navBarAlpha];
}

@end
