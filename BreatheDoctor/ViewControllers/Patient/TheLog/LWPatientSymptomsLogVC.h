//
//  LWPatientSymptomsLogVC.h
//  BreatheDoctor
//
//  Created by comv on 15/11/22.
//  Copyright © 2015年 lwh. All rights reserved.
// 症状日志

#import <UIKit/UIKit.h>
@class LWPatientLogViewController;

@interface LWPatientSymptomsLogVC : UIViewController
@property (nonatomic, weak) LWPatientLogViewController *vc;
- (void)refreshSymptomsLogIsShowHttpError:(BOOL)isShow;
@end
