//
//  LWLoginViewController.h
//  BreatheDoctor
//
//  Created by comv on 15/11/11.
//  Copyright © 2015年 lwh. All rights reserved.
// 登陆界面

#import <UIKit/UIKit.h>

@protocol LWLoginViewControllerDelegate <NSObject>
- (void)loginSucc;
@end

@interface LWLoginViewController : UIViewController
@property (nonatomic, weak) id<LWLoginViewControllerDelegate>delegate;
@end
