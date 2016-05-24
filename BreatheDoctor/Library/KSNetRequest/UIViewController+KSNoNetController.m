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
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hiddenNonetWork];
        
        KSNoNetView* view = [[KSNoNetView alloc] initWithFrame:self.view.frame];
        
        view.isShowErrorButton = isShow;
        view.ErrorButtonTag = type;
        if (!isShow)
        {
            if (type == showErrorTypeHttp || type == showErrorType64Hight) {
                [view setErrorButtonTitleInfo:@"点击重试"];
            }else
            {
                [view setErrorButtonTitleInfo:@"添加患者"];
            }
        }
        
        view.delegate = self;
        [view setErrorLabelMessageInfo:message];
        [self.view addSubview:view];
        view.sd_layout.spaceToSuperView(UIEdgeInsetsMake(64, 0, 0, 0));

    });
}
- (void)hiddenNonetWork
{
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[KSNoNetView class]]) {
            if (view) {
                [view removeFromSuperview];
            }
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
