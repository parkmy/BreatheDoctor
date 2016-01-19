//
//  LWPatientBiaoDanBody.h
//
//  Created by   on 16/1/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LWPatientBiaoDanBody : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *symptom;
@property (nonatomic, strong) NSString *nightSymptoms;
@property (nonatomic, strong) NSString *doctorId;
@property (nonatomic, strong) NSString *daySymptoms;
@property (nonatomic, strong) NSString *createDt;
@property (nonatomic, strong) NSString *modifyDt;
@property (nonatomic, strong) NSString *makeMedicine;
@property (nonatomic, strong) NSString *sid;
@property (nonatomic, strong) NSString *activity;
@property (nonatomic, strong) NSString *acute;
@property (nonatomic, strong) NSString *urgentMedicine;
@property (nonatomic, strong) NSString *cause;
@property (nonatomic, strong) NSString *patientId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
