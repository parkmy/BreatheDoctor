//
//  LWBaseViewController.h
//  BreatheDoctor
//
//  Created by comv on 15/11/10.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDMacro.h"
#import "NSString+Contains.h"
#import "LWTool.h"

@interface LWBaseViewController : UITableViewController

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
