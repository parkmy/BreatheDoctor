//
//  LWChatDataStruct.h
//
//  Created by   on 15/11/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LWChatDataStruct : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *assessDt;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *recordDt;
@property (nonatomic, assign) double timeFrame;
@property (nonatomic, strong) NSString *doctorText;
@property (nonatomic, assign) NSInteger contentType;
@property (nonatomic, assign) double voiceMin;
@property (nonatomic, strong) NSString *pEFLevel;
@property (nonatomic, strong) NSString *patientText;
@property (nonatomic, assign) double assessResult;
@property (nonatomic, assign) double pEFValue;

@property (nonatomic, assign) double pharmacyUrgency;
@property (nonatomic, assign) double symptomChestdistress;
@property (nonatomic, assign) double symptomDyspnea;
@property (nonatomic, assign) double symptomCough;
@property (nonatomic, assign) double pharmacyControl;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, assign) double symptomNightWoke;
@property (nonatomic, assign) double symptomGood;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
