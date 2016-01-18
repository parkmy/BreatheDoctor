//
//  LWTheFormViewController.h
//  BreatheDoctor
//
//  Created by comv on 16/1/13.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "BaseViewController.h"
#import "LWTheFormCell.h"

@interface LWTheFormViewController : BaseViewController
@property (nonatomic, assign) showTheFormType showType;
@property (nonatomic,   copy) NSString *foreignId;
@property (nonatomic, copy) NSString *patientId;
@end
