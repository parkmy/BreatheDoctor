//
//  LWLineACTAssessmentVC.h
//  BreatheDoctor
//
//  Created by comv on 15/12/1.
//  Copyright © 2015年 lwh. All rights reserved.
//  曲线ACT评估

#import "LWBaseViewController.h"

@interface LWLineACTAssessmentVC : LWBaseViewController

@property (nonatomic, copy) NSString *starDate;
@property (nonatomic, copy) NSString *endDate;
@property (nonatomic, copy) NSString *patientID;
@property (nonatomic, copy) NSString *patientName;
@property (nonatomic, assign) NSInteger type;
@end
