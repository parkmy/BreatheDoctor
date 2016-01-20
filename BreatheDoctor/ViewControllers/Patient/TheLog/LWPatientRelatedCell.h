//
//  LWPatientRelatedCell.h
//  BreatheDoctor
//
//  Created by comv on 16/1/12.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWPatinenConditionModel.h"

typedef NS_ENUM(NSInteger, PatientRelatedType) {
    PatientRelatedTypediagnosis = 0, //诊断结果
    PatientRelatedTypecondition ,//基本病情
    PatientRelatedTypephoto ,//相关照片
};

@interface LWPatientRelatedCell : UITableViewCell
@property (nonatomic, assign) PatientRelatedType patientRelatedType;
@property (nonatomic, strong) LWPatinenConditionModel *model;
@property (nonatomic, strong) UITableView *mTableView;
@end
