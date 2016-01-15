//
//  LWPatientMedicationLogVC.h
//  BreatheDoctor
//
//  Created by comv on 15/11/22.
//  Copyright © 2015年 lwh. All rights reserved.
//  用药日志

#import <UIKit/UIKit.h>
@class LWPatientLogViewController;

@interface LWPatientMedicationLogVC : UIViewController
@property (nonatomic, weak) LWPatientLogViewController *vc;
- (void)refreshMedicationLogIsShowHttpError:(BOOL)isShow;
@end
