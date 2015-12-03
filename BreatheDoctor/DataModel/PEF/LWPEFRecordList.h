//
//  LWPEFRecordList.h
//
//  Created by   on 15/11/25
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LWPEFRecordList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *recordDt;
@property (nonatomic, assign) double pharmacyUrgency;
@property (nonatomic, assign) double symptomChestdistress;
@property (nonatomic, assign) double symptomDyspnea;
@property (nonatomic, strong) NSString *insertDt;
@property (nonatomic, assign) double perfValue;
@property (nonatomic, assign) double pefValue;
@property (nonatomic, strong) NSString *patientId;
@property (nonatomic, assign) double symptomCough;
@property (nonatomic, assign) double pharmacyControl;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *recordId;
@property (nonatomic, assign) double symptomNightWoke;
@property (nonatomic, assign) double timeFrame;
@property (nonatomic, assign) double symptomGasp;
@property (nonatomic, assign) double symptomGood;

@property (nonatomic, assign) double rowHight;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
