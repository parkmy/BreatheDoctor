//
//  LWPatientRecordsPatientArchives.h
//
//  Created by   on 15/11/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LWPatientRecordsPatientArchives : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *allergenTest;
@property (nonatomic, strong) NSString *allergicHistory;
@property (nonatomic, strong) NSString *symptomFactor;
@property (nonatomic, strong) NSString *patientPhone;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, assign) double pefPredictedValue;
@property (nonatomic, strong) NSString *syndrome;
@property (nonatomic, strong) NSArray *imageUrlList;
@property (nonatomic, strong) NSString *resultImageUrlStr;
@property (nonatomic, assign) double finishQuestionnaire;
@property (nonatomic, strong) NSString *fvc;
@property (nonatomic, strong) NSString *symptomFactorRemark;
@property (nonatomic, strong) NSString *feno;
@property (nonatomic, strong) NSString *patientName;
@property (nonatomic, strong) NSString *familyHistoryParent;
@property (nonatomic, strong) NSString *medicalHistory;
@property (nonatomic, assign) double diastoleTest;
@property (nonatomic, assign) double sex;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *syndromeRemark;
@property (nonatomic, assign) double height;
@property (nonatomic, strong) NSString *insertDt;
@property (nonatomic, assign) double provocationTest;
@property (nonatomic, strong) NSString *familyHistoryOther;
@property (nonatomic, assign) double isValid;
@property (nonatomic, strong) NSString *fev1Percent;
@property (nonatomic, strong) NSString *modifyDt;
@property (nonatomic, strong) NSString *fev1;
@property (nonatomic, strong) NSString *symptom;
@property (nonatomic, strong) NSString *openId;
@property (nonatomic, strong) NSString *controlLevel;
@property (nonatomic, strong) NSString *patientId;
@property (nonatomic, strong) NSString *fvcPercent;
@property (nonatomic, assign) double isComplete;
@property (nonatomic, assign) double weight;
@property (nonatomic, strong) NSString *headImgUrl;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
