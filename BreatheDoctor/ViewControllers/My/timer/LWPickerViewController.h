//
//  LWPickerViewController.h
//  BreatheDoctor
//
//  Created by comv on 15/12/31.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWPickerViewController : UIViewController

@property (nonatomic, copy) void(^completeChooseBlock)(NSString *string);

@property (nonatomic, copy) void(^completeDismiss)();

- (void)dismissPickerView;

@end
