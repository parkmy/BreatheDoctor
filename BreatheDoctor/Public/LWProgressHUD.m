//
//  LWProgressHUD.m
//  BreatheDoctor
//
//  Created by comv on 15/11/12.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWProgressHUD.h"
#import "CDMacro.h"
#import "NSString+Size.h"

@implementation LWProgressHUD

NSTimer *timer;
CDPromptView * PromptView= nil;
UIView* showView = nil;

+(void)displayProgressHUD:(UIView *)view displayText:(NSString*)text
{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;

    UIView *bgview = [[UIView alloc] initWithFrame:window.bounds];
    bgview.backgroundColor = RGBA(0, 0, 0, .3);
    bgview.tag = -112;
    [window addSubview:bgview];
    
    UIActivityIndicatorView* activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30*sizeScaleX, 30)];
    activity.tag = -110;
    activity.center = bgview.center;
    [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];//设置进度轮显示类型
    [window addSubview:activity];
    [activity startAnimating];
    
    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 15)];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.xCenter = activity.xCenter;
    lable.yCenter = activity.yCenter+35;
    lable.font = [UIFont systemFontOfSize:14];
    lable.text = text;
    lable.tag = -111;
    lable.textColor = [UIColor whiteColor];
    [window addSubview:lable];
    
    CGSize  sizes = [stringJudgeNull(lable.text) sizeWithFont:[UIFont systemFontOfSize:14] constrainedToHeight:15];
    lable.width = MAX(sizes.width+10, screenWidth);
    
    showView = window;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[self class] closeProgressHUD:showView];
    });
    
    
}

+(void)closeProgressHUD:(UIView *)view
{
    
    if (view == nil && showView==nil)
    {
        return;
    }
    else if(view == nil)
    {
        view = showView;
    }
    
    UIView * vie = [showView viewWithTag:-110];
    [vie removeFromSuperview];
    vie = nil;
    
    vie = [showView viewWithTag:-111];
    [vie removeFromSuperview];
    vie = nil;
    
    vie = [showView viewWithTag:-112];
    [vie removeFromSuperview];
    vie = nil;
}

+(void)showAlertViewWithText:(NSString *)text
{
    UIAlertView *t_alertView = [[UIAlertView alloc] initWithTitle:@"" message:text delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [t_alertView show];
    
}

+(void)showALAlertBannerWithView:(UIView*)view Style:(int)style Position:(int)position Subtitle:(NSString*)subtitle{
    
    [LCCoolHUD showFailureOblong:subtitle zoom:YES shadow:NO];
    
//    if ([LWPublicDataManager shareInstance].ifRemoveFromSuperview==NO)
//    {
//        
//        CGSize size = [subtitle sizeWithFont:[UIFont systemFontOfSize:13] constrainedToWidth:screenWidth-40];
//        
//        int y = view.height-59-systemTabbarHeight;
//        
//        if (position==0)
//        {
//            y-= 66;
//            
//        }
//        if (position==1)
//        {
//            y-= 170;
//        }
//        CDPromptView * PromptView = [[CDPromptView alloc]initWithFrame:CGRectMake(view.frame.size.width/2-size.width/2 -10,
//                                                                                  y, size.width + 20, size.height + 20)];
//        PromptView.ifDelegate = YES;
//        
//        [view addSubview:PromptView];
//        [PromptView showViewWithMsg:subtitle];
//        
//        
////        sender.userInteractionEnabled = NO;
//        [LWPublicDataManager shareInstance].ifRemoveFromSuperview=YES;
//        [LWPublicDataManager shareInstance].alther = PromptView;
//    }
    
}


@end
