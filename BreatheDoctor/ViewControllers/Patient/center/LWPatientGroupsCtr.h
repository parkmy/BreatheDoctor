//
//  LWPatientGroupsCtr.h
//  BreatheDoctor
//
//  Created by comv on 15/11/11.
//  Copyright © 2015年 lwh. All rights reserved.
//  分组

#import "BaseViewController.h"

@interface LWPatientGroupsCtr : BaseViewController
@property (nonatomic, copy) void(^chooseGroup)(NSString *group,NSInteger tag);
@end
