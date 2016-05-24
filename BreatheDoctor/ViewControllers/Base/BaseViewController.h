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
#import "KLSuperViewController.h"


@interface BaseViewController : KLSuperViewController

- (void)addNavBar:(NSString*)title;
- (void)addBackButton:(NSString*)backImg;
- (void)addRightButton:(NSString*)rightImg;


@end
