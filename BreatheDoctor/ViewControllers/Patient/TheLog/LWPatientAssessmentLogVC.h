//
//  LWPatientAssessmentLogVC.h
//  BreatheDoctor
//
//  Created by comv on 15/11/22.
//  Copyright © 2015年 lwh. All rights reserved.
// 评估日志

#import <UIKit/UIKit.h>
@class LWPatientLogViewController;

@interface LWPatientAssessmentLogVC : UIViewController

@property (nonatomic, weak) LWPatientLogViewController *vc;
- (void)refreshAssessmentLog:(NSString *)patientID;
@end
