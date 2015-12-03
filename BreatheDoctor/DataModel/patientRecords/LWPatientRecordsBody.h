//
//  LWPatientRecordsBody.h
//
//  Created by   on 15/11/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LWPatientRecordsPatientArchives, LWPatientRecordsLineChart;

@interface LWPatientRecordsBody : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) LWPatientRecordsPatientArchives *patientArchives;
@property (nonatomic, strong) id lineChart;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
