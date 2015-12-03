//
//  UIViewController+KSNoNetController.m
//  Test
//
//  Created by KS on 15/11/25.
//  Copyright © 2015年 xianhe. All rights reserved.
//

#import "UIViewController+KSNoNetController.h"
#import "KSNetRequest.h"
#import "KSNoNetView.h"

@implementation UIViewController (KSNoNetController)

- (void)showErrorMessage:(NSString *)message
{
    KSNoNetView* view = [KSNoNetView instanceNoNetView];
    view.messageLabel.text = message;
    [self.view addSubview:view];
}
- (void)hiddenNonetWork
{
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[KSNoNetView class]]) {
            [view removeFromSuperview];
        }
    }
}
- (void)reloadNetworkDataSource:(id)sender
{
    if ([self respondsToSelector:@selector(reloadRequest)]) {
        [self performSelector:@selector(reloadRequest)];
    }
}
- (void)reloadRequest
{
    NSLog(@"必须由网络控制器(%@)重写这个方法(%@)，才可以使用再次刷新网络",NSStringFromClass([self class]),NSStringFromSelector(@selector(reloadRequest)));
}
@end
