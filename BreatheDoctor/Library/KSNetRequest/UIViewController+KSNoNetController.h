//
//  UIViewController+KSNoNetController.h
//  Test
//
//  Created by KS on 15/11/25.
//  Copyright © 2015年 xianhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSNoNetView.h"
typedef NS_ENUM(NSInteger , showErrorType) {
    showErrorTypeHttp = 0,
    showErrorTypeMore ,
    showErrorType64Hight,
};


@interface UIViewController (KSNoNetController)<KSNoNetViewDelegate>

/**
 *  为控制器扩展方法，刷新网络时候执行，建议必须实现
 */
- (void)reloadRequestWithSender:(UIButton *)sender;

/**
 *  显示error视图
 */
- (void)showErrorMessage:(NSString *)message isShowButton:(BOOL)isShow type:(showErrorType)type;

/**
 *  隐藏error视图
 */
- (void)hiddenNonetWork;

@end
