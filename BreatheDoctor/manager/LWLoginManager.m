//
//  LWLoginManager.m
//  BreatheDoctor
//
//  Created by comv on 15/11/11.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWLoginManager.h"
#import "LWLoginViewController.h"
#import "CODataCacheManager.h"
#import "LWMessageCtr.h"
#import "GJMFileHelper.h"
#import <SDImageCache.h>

@interface LWLoginManager ()<LWLoginViewControllerDelegate>

@property (nonatomic, strong) UIViewController *showLoginVC;
@end

@implementation LWLoginManager

+ (LWLoginManager *)shareInstance
{
    static dispatch_once_t onceToken;
    static LWLoginManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[LWLoginManager alloc] init];
    });
    return manager;
}

+ (BOOL)isLogin
{
    if ([[CODataCacheManager shareInstance] userModel]) {
        return YES;
    }
    return NO;
}

- (void)exitLoginViewVc:(UIViewController *)vc
{
 
    [[SDImageCache sharedImageCache] clearDisk]; //清除图片缓存
    
    [[NSFileManager defaultManager] removeItemAtPath:[LKDBHelper getDBPathWithDBName:[LKDBHelper baseTableName]] error:nil]; //删除数据库
    
    [[CODataCacheManager shareInstance] clearUserModel]; //删除用户信息
    
    [self showLoginViewNav:vc]; //回到登陆
    
}
- (void)showLoginViewNav:(UIViewController *)vc
{
    self.showLoginVC = vc;
    self.showLoginVC.navigationController.navigationBarHidden = YES;
    vc.hidesBottomBarWhenPushed = YES;
    LWLoginViewController *loginVC = (LWLoginViewController *)[UIViewController CreateControllerWithTag:CtrlTag_Login];
    loginVC.delegate = self;
    [self.showLoginVC.navigationController pushViewController:loginVC animated:NO];
}
- (void)loginSucc
{
    [[NSNotificationCenter defaultCenter] postNotificationName:APP_LOGIN_SUCC object:nil];

    if (self.showLoginVC.tabBarController.selectedIndex != 0) {
        self.showLoginVC.tabBarController.selectedIndex = 0;
    }
    self.showLoginVC.navigationController.navigationBarHidden = NO;
    self.showLoginVC.hidesBottomBarWhenPushed = NO;
    [self.showLoginVC.navigationController popToRootViewControllerAnimated:NO];
    

}

@end