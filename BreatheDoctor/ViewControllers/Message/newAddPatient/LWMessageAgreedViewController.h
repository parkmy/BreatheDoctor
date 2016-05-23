//
//  LWMessageAgreedViewController.h
//  BreatheDoctor
//
//  Created by comv on 16/1/4.
//  Copyright © 2016年 lwh. All rights reserved.
//  患者申请

#import "BaseViewController.h"

@interface LWMessageAgreedViewController : BaseViewController
@property (nonatomic, strong) LWMainRows *patientModel;

@property (nonatomic, copy) void(^addPatientSuccBlock)();
@property (nonatomic, copy) void(^addPatientFaileBlock)();
@end
