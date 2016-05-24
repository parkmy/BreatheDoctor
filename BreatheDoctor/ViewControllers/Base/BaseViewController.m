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
    
    self.view.backgroundColor = [LWThemeManager shareInstance].vcBackgroundColor;
    self.navBarBackColor = [LWThemeManager shareInstance].navBackgroundColor;
}


-(void)addNavBar:(NSString*)title
{
    self.navCenterTitle = title;
}

-(void)addBackButton:(NSString*)backImg
{
    self.navLeftContent = backImg;
}

-(void)addRightButton:(NSString*)rightImg
{

    self.navRightContent = rightImg;
}
@end
