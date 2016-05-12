//
//  LWPatientListCtr.h
//  BreatheDoctor
//
//  Created by comv on 15/11/10.
//  Copyright © 2015年 lwh. All rights reserved.
//  患者列表

#import "BaseViewController.h"
#import "KLPatientOperation.h"
@class KLGroupSenderPatientListModel;

@interface LWPatientListCtr : BaseViewController

@property (nonatomic, strong) KLGroupSenderPatientListModel *ListModel;

- (instancetype)initWithListType:(LISTTYPE)type;
- (void)againSenderEdtiorSuccModel:(KLGroupSenderPatientListModel *)model;
- (void)patientListGuoupSenderSuccess;

@end
