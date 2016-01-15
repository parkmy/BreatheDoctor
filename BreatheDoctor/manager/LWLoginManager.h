//
//  LWLoginManager.h
//  BreatheDoctor
//
//  Created by comv on 15/11/11.
//  Copyright © 2015年 lwh. All rights reserved.
//  登陆管理者

#import <Foundation/Foundation.h>

@interface LWLoginManager : NSObject

+ (LWLoginManager *)shareInstance;

+ (BOOL)isLogin;
- (void)exitLoginViewVc:(UIViewController *)vc;
- (void)showLoginViewNav:(UIViewController *)vc;

@end
