//
//  LWPatientCententCtr.h
//  BreatheDoctor
//
//  Created by comv on 15/11/10.
//  Copyright © 2015年 lwh. All rights reserved.
// 患者中心

#import "LWBaseViewController.h"

@interface LWPatientCententCtr : LWBaseViewController
@property (nonatomic, strong) LWPatientRows *patient;
@property (nonatomic, copy) void(^backBlock)();
@end
