//
//  LWProgressHUD.h
//  BreatheDoctor
//
//  Created by comv on 15/11/12.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWProgressHUD : NSObject

//进度条
+(void)displayProgressHUD:(UIView *)view displayText:(NSString*)text;
+(void)closeProgressHUD:(UIView *)view;

+(void)showAlertViewWithText:(NSString *)text;
+(void)showALAlertBannerWithView:(UIView*)view Style:(int)style Position:(int)position Subtitle:(NSString*)subtitle;

@end
