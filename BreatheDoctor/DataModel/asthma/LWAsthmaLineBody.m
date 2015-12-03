//
//  LWAsthmaLineBody.m
//
//  Created by   on 15/12/1
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LWAsthmaLineBody.h"


NSString *const kLWAsthmaLineBodyAssessDt = @"assessDt";
NSString *const kLWAsthmaLineBodyAcuteAttack = @"acuteAttack";
NSString *const kLWAsthmaLineBodyCushion = @"cushion";
NSString *const kLWAsthmaLineBodyInsertDt = @"insertDt";
NSString *const kLWAsthmaLineBodyNightSymptoms = @"nightSymptoms";
NSString *const kLWAsthmaLineBodySid = @"sid";
NSString *const kLWAsthmaLineBodyLom = @"lom";
NSString *const kLWAsthmaLineBodyPatientId = @"patientId";


@interface LWAsthmaLineBody ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWAsthmaLineBody

@synthesize assessDt = _assessDt;
@synthesize acuteAttack = _acuteAttack;
@synthesize cushion = _cushion;
@synthesize insertDt = _insertDt;
@synthesize nightSymptoms = _nightSymptoms;
@synthesize sid = _sid;
@synthesize lom = _lom;
@synthesize patientId = _patientId;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.assessDt = [self objectOrNilForKey:kLWAsthmaLineBodyAssessDt fromDictionary:dict];
            self.acuteAttack = [[self objectOrNilForKey:kLWAsthmaLineBodyAcuteAttack fromDictionary:dict] doubleValue];
            self.cushion = [[self objectOrNilForKey:kLWAsthmaLineBodyCushion fromDictionary:dict] doubleValue];
            self.insertDt = [self objectOrNilForKey:kLWAsthmaLineBodyInsertDt fromDictionary:dict];
            self.nightSymptoms = [[self objectOrNilForKey:kLWAsthmaLineBodyNightSymptoms fromDictionary:dict] doubleValue];
            self.sid = [self objectOrNilForKey:kLWAsthmaLineBodySid fromDictionary:dict];
            self.lom = [[self objectOrNilForKey:kLWAsthmaLineBodyLom fromDictionary:dict] doubleValue];
            self.patientId = [self objectOrNilForKey:kLWAsthmaLineBodyPatientId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.assessDt forKey:kLWAsthmaLineBodyAssessDt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.acuteAttack] forKey:kLWAsthmaLineBodyAcuteAttack];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cushion] forKey:kLWAsthmaLineBodyCushion];
    [mutableDict setValue:self.insertDt forKey:kLWAsthmaLineBodyInsertDt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.nightSymptoms] forKey:kLWAsthmaLineBodyNightSymptoms];
    [mutableDict setValue:self.sid forKey:kLWAsthmaLineBodySid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lom] forKey:kLWAsthmaLineBodyLom];
    [mutableDict setValue:self.patientId forKey:kLWAsthmaLineBodyPatientId];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.assessDt = [aDecoder decodeObjectForKey:kLWAsthmaLineBodyAssessDt];
    self.acuteAttack = [aDecoder decodeDoubleForKey:kLWAsthmaLineBodyAcuteAttack];
    self.cushion = [aDecoder decodeDoubleForKey:kLWAsthmaLineBodyCushion];
    self.insertDt = [aDecoder decodeObjectForKey:kLWAsthmaLineBodyInsertDt];
    self.nightSymptoms = [aDecoder decodeDoubleForKey:kLWAsthmaLineBodyNightSymptoms];
    self.sid = [aDecoder decodeObjectForKey:kLWAsthmaLineBodySid];
    self.lom = [aDecoder decodeDoubleForKey:kLWAsthmaLineBodyLom];
    self.patientId = [aDecoder decodeObjectForKey:kLWAsthmaLineBodyPatientId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_assessDt forKey:kLWAsthmaLineBodyAssessDt];
    [aCoder encodeDouble:_acuteAttack forKey:kLWAsthmaLineBodyAcuteAttack];
    [aCoder encodeDouble:_cushion forKey:kLWAsthmaLineBodyCushion];
    [aCoder encodeObject:_insertDt forKey:kLWAsthmaLineBodyInsertDt];
    [aCoder encodeDouble:_nightSymptoms forKey:kLWAsthmaLineBodyNightSymptoms];
    [aCoder encodeObject:_sid forKey:kLWAsthmaLineBodySid];
    [aCoder encodeDouble:_lom forKey:kLWAsthmaLineBodyLom];
    [aCoder encodeObject:_patientId forKey:kLWAsthmaLineBodyPatientId];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWAsthmaLineBody *copy = [[LWAsthmaLineBody alloc] init];
    
    if (copy) {

        copy.assessDt = [self.assessDt copyWithZone:zone];
        copy.acuteAttack = self.acuteAttack;
        copy.cushion = self.cushion;
        copy.insertDt = [self.insertDt copyWithZone:zone];
        copy.nightSymptoms = self.nightSymptoms;
        copy.sid = [self.sid copyWithZone:zone];
        copy.lom = self.lom;
        copy.patientId = [self.patientId copyWithZone:zone];
    }
    
    return copy;
}


@end
