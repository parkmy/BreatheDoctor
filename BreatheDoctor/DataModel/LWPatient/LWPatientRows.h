//
//  LWPatientRows.h
//
//  Created by   on 15/11/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LWPatientRows : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double isConfirm;
@property (nonatomic, strong) NSString *insertDt;
@property (nonatomic, assign) double sex;
@property (nonatomic, strong) NSString *doctorId;
@property (nonatomic, strong) NSString *modifyDt;
@property (nonatomic, strong) NSString *patientName;
@property (nonatomic, assign) double patientPhone;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, assign) double controlLevel;
@property (nonatomic, assign) double isValid;
@property (nonatomic, strong) NSString *sid;
@property (nonatomic, strong) NSString *groupId;
@property (nonatomic, strong) NSString *patientId;
@property (nonatomic, strong) NSString *headImgUrl;
@property (nonatomic, copy)  NSString *refTimer;

@property (nonatomic, copy) NSString *PinYin;
@property (nonatomic, copy) NSString *qPingying;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
