//
//  KLTimerWeeksViewController.h
//  BreatheDoctor
//
//  Created by comv on 16/3/31.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLTimerWeeksViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *weeks;
@property (nonatomic, copy) void(^backBlock)(NSMutableArray *weeks);
@property (nonatomic, copy) void(^completeDismiss)();

@end
