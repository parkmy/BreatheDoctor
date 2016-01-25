//
//  LWPatientPEFLogVC.h
//  BreatheDoctor
//
//  Created by comv on 15/11/22.
//  Copyright © 2015年 lwh. All rights reserved.
// PEF日志

#import <UIKit/UIKit.h>
@class LWPatientLogViewController;

@interface LWPatientPEFLogVC : UIViewController

@property (nonatomic, weak) LWPatientLogViewController *vc;
- (void)refreshPEFRecordIsShowHttpError:(BOOL)isShow;
- (void)showPEFRecordView:(LWPEFRecordList *)record;

@end
