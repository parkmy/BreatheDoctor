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

- (void)showErrorMessage:(NSString *)message isShowButton:(BOOL)isShow type:(showErrorType)type
{
    [self hiddenNonetWork];
    
    KSNoNetView* view = [KSNoNetView instanceNoNetView];
    view.ErrorButton.hidden = isShow;
    view.ErrorButton.tag = type;
    if (!isShow)
    {
        if (type == showErrorTypeHttp || type == showErrorType64Hight) {
            [view.ErrorButton setTitle:@"点击重试" forState:UIControlStateNormal];
        }else
        {
            [view.ErrorButton setTitle:@"添加患者" forState:UIControlStateNormal];
        }
    }

    view.delegate = self;
    view.messageLabel.text = message;
    if (type == showErrorType64Hight) {
        view.frame = self.view.bounds;
        view.yOrigin = 64+40;
    }
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
- (void)reloadNetworkDataSource:(UIButton *)sender
{
    if ([self respondsToSelector:@selector(reloadRequestWithSender:)]) {
        [self performSelector:@selector(reloadRequestWithSender:) withObject:sender];
    }
}
- (void)reloadRequestWithSender:(UIButton *)sender
{

}
@end
