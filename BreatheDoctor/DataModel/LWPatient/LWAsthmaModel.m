//
//  LWAsthmaModel.m
//
//  Created by   on 15/11/24
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LWAsthmaModel.h"


NSString *const kLWAsthmaModelAssessDt = @"assessDt";
NSString *const kLWAsthmaModelAcuteAttack = @"acuteAttack";
NSString *const kLWAsthmaModelCushion = @"cushion";
NSString *const kLWAsthmaModelInsertDt = @"insertDt";
NSString *const kLWAsthmaModelNightSymptoms = @"nightSymptoms";
NSString *const kLWAsthmaModelSid = @"sid";
NSString *const kLWAsthmaModelLom = @"lom";
NSString *const kLWAsthmaModelPatientId = @"patientId";


@interface LWAsthmaModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWAsthmaModel

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
            self.assessDt = [self objectOrNilForKey:kLWAsthmaModelAssessDt fromDictionary:dict];
            self.acuteAttack = [[self objectOrNilForKey:kLWAsthmaModelAcuteAttack fromDictionary:dict] doubleValue];
            self.cushion = [[self objectOrNilForKey:kLWAsthmaModelCushion fromDictionary:dict] doubleValue];
            self.insertDt = [self objectOrNilForKey:kLWAsthmaModelInsertDt fromDictionary:dict];
            self.nightSymptoms = [[self objectOrNilForKey:kLWAsthmaModelNightSymptoms fromDictionary:dict] doubleValue];
            self.sid = [self objectOrNilForKey:kLWAsthmaModelSid fromDictionary:dict];
            self.lom = [[self objectOrNilForKey:kLWAsthmaModelLom fromDictionary:dict] doubleValue];
            self.patientId = [self objectOrNilForKey:kLWAsthmaModelPatientId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.assessDt forKey:kLWAsthmaModelAssessDt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.acuteAttack] forKey:kLWAsthmaModelAcuteAttack];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cushion] forKey:kLWAsthmaModelCushion];
    [mutableDict setValue:self.insertDt forKey:kLWAsthmaModelInsertDt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.nightSymptoms] forKey:kLWAsthmaModelNightSymptoms];
    [mutableDict setValue:self.sid forKey:kLWAsthmaModelSid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lom] forKey:kLWAsthmaModelLom];
    [mutableDict setValue:self.patientId forKey:kLWAsthmaModelPatientId];

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

    self.assessDt = [aDecoder decodeObjectForKey:kLWAsthmaModelAssessDt];
    self.acuteAttack = [aDecoder decodeDoubleForKey:kLWAsthmaModelAcuteAttack];
    self.cushion = [aDecoder decodeDoubleForKey:kLWAsthmaModelCushion];
    self.insertDt = [aDecoder decodeObjectForKey:kLWAsthmaModelInsertDt];
    self.nightSymptoms = [aDecoder decodeDoubleForKey:kLWAsthmaModelNightSymptoms];
    self.sid = [aDecoder decodeObjectForKey:kLWAsthmaModelSid];
    self.lom = [aDecoder decodeDoubleForKey:kLWAsthmaModelLom];
    self.patientId = [aDecoder decodeObjectForKey:kLWAsthmaModelPatientId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_assessDt forKey:kLWAsthmaModelAssessDt];
    [aCoder encodeDouble:_acuteAttack forKey:kLWAsthmaModelAcuteAttack];
    [aCoder encodeDouble:_cushion forKey:kLWAsthmaModelCushion];
    [aCoder encodeObject:_insertDt forKey:kLWAsthmaModelInsertDt];
    [aCoder encodeDouble:_nightSymptoms forKey:kLWAsthmaModelNightSymptoms];
    [aCoder encodeObject:_sid forKey:kLWAsthmaModelSid];
    [aCoder encodeDouble:_lom forKey:kLWAsthmaModelLom];
    [aCoder encodeObject:_patientId forKey:kLWAsthmaModelPatientId];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWAsthmaModel *copy = [[LWAsthmaModel alloc] init];
    
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
