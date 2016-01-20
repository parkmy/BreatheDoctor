//
//  LWTheFormViewController.h
//  BreatheDoctor
//
//  Created by comv on 16/1/13.
//  Copyright © 2016年 lwh. All rights reserved.
// 表单详情

#import "BaseViewController.h"
#import "LWTheFormCell.h"
#import "LWPatientBiaoDanBody.h"

@interface LWTheFormViewController : BaseViewController
@property (nonatomic, assign) showTheFormType showType;
@property (nonatomic,   copy) NSString *foreignId;
@property (nonatomic, copy) NSString *patientId;
@property (nonatomic, strong) LWPatientBiaoDanBody *model;

@end
