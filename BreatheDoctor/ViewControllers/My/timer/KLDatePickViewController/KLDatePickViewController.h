//
//  KLDatePickViewController.h
//  COButton
//
//  Created by comv on 16/3/31.
//  Copyright © 2016年 comv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLDatePickViewController : UIViewController

@property (nonatomic, copy) void(^completeChooseBlock)(NSString *string);
@property (nonatomic, copy) void(^completeDismiss)();

- (void)setleftButtonTitleInfo:(NSString *)title;
- (void)setrightButtonTitleInfo:(NSString *)title;
- (void)setcenterTitleLabelStringInfo:(NSString *)title;

- (void)setRightPickViewCountIndex:(NSInteger)index;
- (void)setleftPickViewCountIndex:(NSInteger)index;
@end
