//
//  LWSenderResBody.h
//
//  Created by   on 15/11/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LWSenderResBody : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *doctorName;
@property (nonatomic, assign) double showType;
@property (nonatomic, strong) NSString *insertDt;
@property (nonatomic, assign) double isCount;
@property (nonatomic, assign) double msgType;
@property (nonatomic, strong) NSString *doctorDepart;
@property (nonatomic, strong) NSString *userMsg;
@property (nonatomic, strong) NSString *patientName;
@property (nonatomic, assign) double isShow;
@property (nonatomic, strong) NSString *relateDoctorId;
@property (nonatomic, assign) double isDispose;
@property (nonatomic, assign) double channel;
@property (nonatomic, assign) double count;
@property (nonatomic, strong) NSString *modifyDt;
@property (nonatomic, assign) double origin;
@property (nonatomic, assign) double isValid;
@property (nonatomic, strong) NSString *doctorId;
@property (nonatomic, strong) NSString *sid;
@property (nonatomic, assign) double platform;
@property (nonatomic, strong) NSString *msgContent;
@property (nonatomic, strong) NSString *msgTypeStr;
@property (nonatomic, strong) NSString *doctorMsg;
@property (nonatomic, assign) double ownerType;
@property (nonatomic, strong) NSString *trueDoctorId;
@property (nonatomic, strong) NSString *trueDoctorName;
@property (nonatomic, strong) NSString *memberId;
@property (nonatomic, strong) NSString *headImageUrl;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *foreignId;
@property (nonatomic, strong) NSString *dataStr;
@property (nonatomic, assign) id dataStruct;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
