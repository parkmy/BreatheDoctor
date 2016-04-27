//
//  KLPatientListModel.h
//  BreatheDoctor
//
//  Created by comv on 16/4/14.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLPatientListModel : NSObject

@property (nonatomic, assign) BOOL isSele;

@property (nonatomic, assign) BOOL isConfirm;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, assign) double patientPhone;
@property (nonatomic, assign) double controlLevel;
@property (nonatomic, assign) double isValid;

@property (nonatomic, copy) NSString *insertDt;
@property (nonatomic, copy) NSString *doctorId;
@property (nonatomic, copy) NSString *modifyDt;
@property (nonatomic, copy) NSString *patientName;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *sid;
@property (nonatomic, copy) NSString *groupId;
@property (nonatomic, copy) NSString *patientId;
@property (nonatomic, copy) NSString *headImgUrl;
@property (nonatomic, copy) NSString *refTimer;
@property (nonatomic, copy) NSString *PinYin;
@property (nonatomic, copy) NSString *qPingying;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
