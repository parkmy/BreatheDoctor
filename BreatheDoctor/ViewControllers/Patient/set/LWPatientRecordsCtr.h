//
//  LWPatientRecordsCtr.h
//  ComveeBreathe
//
//  Created by comv on 15/11/9.
//  Copyright © 2015年 lwh. All rights reserved.
//  患者档案

#import "LWBaseViewController.h"
@class KLPatientListModel;

@interface LWPatientRecordsCtr : LWBaseViewController
@property (nonatomic, strong) KLPatientListModel *patient;
@end
