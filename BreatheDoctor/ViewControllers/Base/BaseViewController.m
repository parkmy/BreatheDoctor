//
//  BaseViewController.m
//  ComveeDoctor
//
//  Created by zhengjw on 14-7-27.
//  Copyright (c) 2014年 zhengjw. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@end

@implementation BaseViewController

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
    
    NSString *pageID = [NSString stringWithFormat:@"%@",NSStringFromClass([self class])];
    NSLog(@"%@-----%@",pageID,[NSString stringWithFormat:@"page_%@",pageID]);
    [MobClick event:pageID label:self.navTitle.text];
    [MobClick beginEvent:[NSString stringWithFormat:@"page_%@",pageID] label:self.navTitle.text];
    [MobClick beginLogPageView:self.navTitle.text];
    self.navigationItem.title = @"";
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSString *pageID = [NSString stringWithFormat:@"page_%@",NSStringFromClass([self class])];
    [MobClick endEvent:[NSString stringWithFormat:@"page_%@",pageID] label:self.navTitle.text];
    [MobClick endLogPageView:self.navTitle.text];
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
    
//    self.navTitle.sd_layout.centerXEqualToView(self.navBar).widthIs(200).heightIs(45).centerYEqualToView(self.navBar);
}
- (UILabel *)navTitle
{
    if (!_navTitle) {
        //标题
        _navTitle = [[UILabel alloc] init];
        _navTitle.frame=CGRectMake(50, 0, self.view.frame.size.width-54-50, systemNavHeight);
//        _navTitle.lineBreakMode = NSLineBreakByTruncatingMiddle;
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
        _navRightButton.frame = CGRectMake(self.view.frame.size.width-54, 0, 54, systemNavHeight);//CGRectMake(5, 15, 50.5, 38/2);
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
    [self.navLeftButton setImage:[UIImage imageNamed:backImg] forState:UIControlStateNormal];
    [self.navBar addSubview:self.navLeftButton];
}

-(void)addRightButton:(NSString*)rightImg
{
    if ([rightImg containsaString:@"png"]) {
        [self.navRightButton setImage:[UIImage imageNamed:rightImg] forState:UIControlStateNormal];
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
//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}
@end
