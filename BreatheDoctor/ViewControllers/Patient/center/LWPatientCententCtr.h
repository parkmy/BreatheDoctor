//
//  LWPatientCententCtr.h
//  BreatheDoctor
//
//  Created by comv on 15/11/10.
//  Copyright © 2015年 lwh. All rights reserved.
// 患者中心

#import "LWBaseViewController.h"
@class KLPatientListModel;

@interface LWPatientCententCtr : LWBaseViewController
@property (nonatomic, strong) KLPatientListModel *patient;
@property (nonatomic, copy) void(^backBlock)();
@end
