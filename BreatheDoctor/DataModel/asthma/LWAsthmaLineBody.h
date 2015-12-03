//
//  LWAsthmaLineBody.h
//
//  Created by   on 15/12/1
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LWAsthmaLineBody : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *assessDt;
@property (nonatomic, assign) double acuteAttack;
@property (nonatomic, assign) double cushion;
@property (nonatomic, strong) NSString *insertDt;
@property (nonatomic, assign) double nightSymptoms;
@property (nonatomic, strong) NSString *sid;
@property (nonatomic, assign) double lom;
@property (nonatomic, strong) NSString *patientId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
