//
//  BaseViewController.h
//  ComveeDoctor
//
//  Created by zhengjw on 14-7-27.
//  Copyright (c) 2014年 zhengjw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDMacro.h"
#import "NSString+Contains.h"
@interface BaseViewController : UIViewController

@property (nonatomic,strong) UILabel *navTitle;
@property (nonatomic,strong) UIButton *navLeftButton;
@property (nonatomic,strong) UIButton *navRightButton;
@property (nonatomic,strong) UINavigationBar *navBar;
@property (nonatomic, strong) UIView *navBackView;

- (void)addNavBar:(NSString*)title;
- (void)addBackButton:(NSString*)backImg;
- (void)addRightButton:(NSString*)rightImg;
- (void)navLeftButtonAction;
- (void)navRightButtonAction;

@end
