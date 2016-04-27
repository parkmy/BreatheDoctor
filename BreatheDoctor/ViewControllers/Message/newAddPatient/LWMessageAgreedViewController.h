//
//  LWMessageAgreedViewController.h
//  BreatheDoctor
//
//  Created by comv on 16/1/4.
//  Copyright © 2016年 lwh. All rights reserved.
//  患者申请

#import "LWBaseViewController.h"

@interface LWMessageAgreedViewController : LWBaseViewController
@property (nonatomic, strong) LWMainRows *patientModel;

@property (nonatomic, copy) void(^addPatientSuccBlock)();
@property (nonatomic, copy) void(^addPatientFaileBlock)();
@end