//
//  LWBaseViewController.m
//  BreatheDoctor
//
//  Created by comv on 15/11/10.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWBaseViewController.h"
//系统导航设置高度
#define systemNavHeight 44
#define systemTabbarHeight 50

@interface LWBaseViewController ()

@end

@implementation LWBaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.view.backgroundColor = [LWThemeManager shareInstance].vcBackgroundColor;
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"";
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navRightButton removeFromSuperview];
    [self.navLeftButton removeFromSuperview];
    [self.navTitle removeFromSuperview];
    self.navRightButton = nil;
    self.navTitle = nil;
    self.navLeftButton = nil;
}

-(void)addNavBar:(NSString*)title
{
    self.navBar.tintColor=[UIColor colorWithHexString:@"#9cc75e"];
    [self.navBar addSubview:self.navBackView];
    self.navTitle.text=[NSString stringWithFormat:@"%@",title];

    [self.navBar addSubview:self.navTitle];
    
}
- (UILabel *)navTitle
{
    if (!_navTitle) {
        //标题
        _navTitle = [[UILabel alloc] init];
        _navTitle.frame=CGRectMake(55, 0, self.view.frame.size.width-120, systemNavHeight);
        _navTitle.lineBreakMode = NSLineBreakByTruncatingMiddle;
        _navTitle.font = [UIFont systemFontOfSize:18];
        _navTitle.textAlignment = NSTextAlignmentCenter;
        _navTitle.backgroundColor = [UIColor clearColor];
        _navTitle.textColor =[UIColor whiteColor];
    }
    return _navTitle;
}
- (UIView *)navBackView
{
    if (!_navBackView) {
        //自定义导航栏背景
        _navBackView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, systemNavHeight)];
        if (systemVersion>=7) {
            _navBackView.frame=CGRectMake(0, -20, self.view.frame.size.width, systemNavHeight+20);
        }
        _navBackView.backgroundColor=[LWThemeManager shareInstance].navBackgroundColor;
    }
    return _navBackView;
}
- (UIButton *)navRightButton
{
    if (!_navRightButton) {
        _navRightButton= [UIButton buttonWithType:UIButtonTypeCustom];
        _navRightButton.frame = CGRectMake(self.view.frame.size.width-54, 0, 44, systemNavHeight);//CGRectMake(5, 15, 50.5, 38/2);
        [_navRightButton addTarget:self action:@selector(navRightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navRightButton;

}

- (UIButton *)navLeftButton
{
    if (!_navLeftButton) {
        _navLeftButton= [UIButton buttonWithType:UIButtonTypeCustom];
        _navLeftButton.frame =CGRectMake(0, 0,50, 44);//CGRectMake(5, 15, 50.5, 38/2);
        [_navLeftButton addTarget:self action:@selector(navLeftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navLeftButton;
    
}
- (UINavigationBar *)navBar
{
    if (!_navBar) {
        _navBar = self.navigationController.navigationBar;
    }
    return _navBar;
}
-(void)addBackButton:(NSString*)backImg
{
    //左按钮
    [self.navLeftButton setBackgroundImage:[UIImage imageNamed:backImg] forState:UIControlStateNormal];
    [self.navBar addSubview:self.navLeftButton];
}

-(void)addRightButton:(NSString*)rightImg
{
    if ([rightImg containsaString:@"png"]) {
        [self.navRightButton setBackgroundImage:[UIImage imageNamed:rightImg] forState:UIControlStateNormal];
    }else
    {
        self.navRightButton.titleLabel.textAlignment = NSTextAlignmentRight;
        self.navRightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.navRightButton setTitle:rightImg forState:UIControlStateNormal];
        NSString *title = self.navRightButton.currentTitle;
        float w = [title sizeWithFont:[UIFont systemFontOfSize:15] constrainedToHeight:20].width;
        self.navRightButton.frame = CGRectMake(self.navBar.frame.size.width-10-w,0
                                               , w, 44);
    }
    
    [self.navBar addSubview:self.navRightButton];
}

-(void)navLeftButtonAction
{
    NSLog(@"BaseView navLefButtonAction");
}

-(void)navRightButtonAction
{
    NSLog(@"BaseView navRightButtonAction");
}






@end