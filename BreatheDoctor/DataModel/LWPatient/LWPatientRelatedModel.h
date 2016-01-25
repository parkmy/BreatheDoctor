//
//  LWPatientRelatedModel.h
//
//  Created by   on 16/1/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LWPatientRelatedModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *images;
@property (nonatomic, strong) NSString *modifyDt;
@property (nonatomic, strong) NSString *insertDt;
@property (nonatomic, strong) NSString *doctorId;
@property (nonatomic, strong) NSString *sid;
@property (nonatomic, strong) NSString *treatmentResult;
@property (nonatomic, strong) NSString *patientId;
@property (nonatomic, strong) NSString *basicCondition;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
