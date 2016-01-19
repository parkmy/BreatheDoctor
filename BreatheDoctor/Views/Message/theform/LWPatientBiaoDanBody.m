//
//  LWPatientBiaoDanBody.m
//
//  Created by   on 16/1/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "LWPatientBiaoDanBody.h"


NSString *const kLWPatientBiaoDanBodySymptom = @"symptom";
NSString *const kLWPatientBiaoDanBodyNightSymptoms = @"nightSymptoms";
NSString *const kLWPatientBiaoDanBodyDoctorId = @"doctorId";
NSString *const kLWPatientBiaoDanBodyDaySymptoms = @"daySymptoms";
NSString *const kLWPatientBiaoDanBodyCreateDt = @"createDt";
NSString *const kLWPatientBiaoDanBodyModifyDt = @"modifyDt";
NSString *const kLWPatientBiaoDanBodyMakeMedicine = @"makeMedicine";
NSString *const kLWPatientBiaoDanBodySid = @"sid";
NSString *const kLWPatientBiaoDanBodyActivity = @"activity";
NSString *const kLWPatientBiaoDanBodyAcute = @"acute";
NSString *const kLWPatientBiaoDanBodyUrgentMedicine = @"urgentMedicine";
NSString *const kLWPatientBiaoDanBodyCause = @"cause";
NSString *const kLWPatientBiaoDanBodyPatientId = @"patientId";


@interface LWPatientBiaoDanBody ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWPatientBiaoDanBody

@synthesize symptom = _symptom;
@synthesize nightSymptoms = _nightSymptoms;
@synthesize doctorId = _doctorId;
@synthesize daySymptoms = _daySymptoms;
@synthesize createDt = _createDt;
@synthesize modifyDt = _modifyDt;
@synthesize makeMedicine = _makeMedicine;
@synthesize sid = _sid;
@synthesize activity = _activity;
@synthesize acute = _acute;
@synthesize urgentMedicine = _urgentMedicine;
@synthesize cause = _cause;
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
            self.symptom = [self objectOrNilForKey:kLWPatientBiaoDanBodySymptom fromDictionary:dict];
            self.nightSymptoms = [self objectOrNilForKey:kLWPatientBiaoDanBodyNightSymptoms fromDictionary:dict];
            self.doctorId = [self objectOrNilForKey:kLWPatientBiaoDanBodyDoctorId fromDictionary:dict];
            self.daySymptoms = [self objectOrNilForKey:kLWPatientBiaoDanBodyDaySymptoms fromDictionary:dict];
            self.createDt = [self objectOrNilForKey:kLWPatientBiaoDanBodyCreateDt fromDictionary:dict];
            self.modifyDt = [self objectOrNilForKey:kLWPatientBiaoDanBodyModifyDt fromDictionary:dict];
            self.makeMedicine = [self objectOrNilForKey:kLWPatientBiaoDanBodyMakeMedicine fromDictionary:dict];
            self.sid = [self objectOrNilForKey:kLWPatientBiaoDanBodySid fromDictionary:dict];
            self.activity = [self objectOrNilForKey:kLWPatientBiaoDanBodyActivity fromDictionary:dict];
            self.acute = [self objectOrNilForKey:kLWPatientBiaoDanBodyAcute fromDictionary:dict];
            self.urgentMedicine = [self objectOrNilForKey:kLWPatientBiaoDanBodyUrgentMedicine fromDictionary:dict];
            self.cause = [self objectOrNilForKey:kLWPatientBiaoDanBodyCause fromDictionary:dict];
            self.patientId = [self objectOrNilForKey:kLWPatientBiaoDanBodyPatientId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.symptom forKey:kLWPatientBiaoDanBodySymptom];
    [mutableDict setValue:self.nightSymptoms forKey:kLWPatientBiaoDanBodyNightSymptoms];
    [mutableDict setValue:self.doctorId forKey:kLWPatientBiaoDanBodyDoctorId];
    [mutableDict setValue:self.daySymptoms forKey:kLWPatientBiaoDanBodyDaySymptoms];
    [mutableDict setValue:self.createDt forKey:kLWPatientBiaoDanBodyCreateDt];
    [mutableDict setValue:self.modifyDt forKey:kLWPatientBiaoDanBodyModifyDt];
    [mutableDict setValue:self.makeMedicine forKey:kLWPatientBiaoDanBodyMakeMedicine];
    [mutableDict setValue:self.sid forKey:kLWPatientBiaoDanBodySid];
    [mutableDict setValue:self.activity forKey:kLWPatientBiaoDanBodyActivity];
    [mutableDict setValue:self.acute forKey:kLWPatientBiaoDanBodyAcute];
    [mutableDict setValue:self.urgentMedicine forKey:kLWPatientBiaoDanBodyUrgentMedicine];
    [mutableDict setValue:self.cause forKey:kLWPatientBiaoDanBodyCause];
    [mutableDict setValue:self.patientId forKey:kLWPatientBiaoDanBodyPatientId];

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

    self.symptom = [aDecoder decodeObjectForKey:kLWPatientBiaoDanBodySymptom];
    self.nightSymptoms = [aDecoder decodeObjectForKey:kLWPatientBiaoDanBodyNightSymptoms];
    self.doctorId = [aDecoder decodeObjectForKey:kLWPatientBiaoDanBodyDoctorId];
    self.daySymptoms = [aDecoder decodeObjectForKey:kLWPatientBiaoDanBodyDaySymptoms];
    self.createDt = [aDecoder decodeObjectForKey:kLWPatientBiaoDanBodyCreateDt];
    self.modifyDt = [aDecoder decodeObjectForKey:kLWPatientBiaoDanBodyModifyDt];
    self.makeMedicine = [aDecoder decodeObjectForKey:kLWPatientBiaoDanBodyMakeMedicine];
    self.sid = [aDecoder decodeObjectForKey:kLWPatientBiaoDanBodySid];
    self.activity = [aDecoder decodeObjectForKey:kLWPatientBiaoDanBodyActivity];
    self.acute = [aDecoder decodeObjectForKey:kLWPatientBiaoDanBodyAcute];
    self.urgentMedicine = [aDecoder decodeObjectForKey:kLWPatientBiaoDanBodyUrgentMedicine];
    self.cause = [aDecoder decodeObjectForKey:kLWPatientBiaoDanBodyCause];
    self.patientId = [aDecoder decodeObjectForKey:kLWPatientBiaoDanBodyPatientId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_symptom forKey:kLWPatientBiaoDanBodySymptom];
    [aCoder encodeObject:_nightSymptoms forKey:kLWPatientBiaoDanBodyNightSymptoms];
    [aCoder encodeObject:_doctorId forKey:kLWPatientBiaoDanBodyDoctorId];
    [aCoder encodeObject:_daySymptoms forKey:kLWPatientBiaoDanBodyDaySymptoms];
    [aCoder encodeObject:_createDt forKey:kLWPatientBiaoDanBodyCreateDt];
    [aCoder encodeObject:_modifyDt forKey:kLWPatientBiaoDanBodyModifyDt];
    [aCoder encodeObject:_makeMedicine forKey:kLWPatientBiaoDanBodyMakeMedicine];
    [aCoder encodeObject:_sid forKey:kLWPatientBiaoDanBodySid];
    [aCoder encodeObject:_activity forKey:kLWPatientBiaoDanBodyActivity];
    [aCoder encodeObject:_acute forKey:kLWPatientBiaoDanBodyAcute];
    [aCoder encodeObject:_urgentMedicine forKey:kLWPatientBiaoDanBodyUrgentMedicine];
    [aCoder encodeObject:_cause forKey:kLWPatientBiaoDanBodyCause];
    [aCoder encodeObject:_patientId forKey:kLWPatientBiaoDanBodyPatientId];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWPatientBiaoDanBody *copy = [[LWPatientBiaoDanBody alloc] init];
    
    if (copy) {

        copy.symptom = [self.symptom copyWithZone:zone];
        copy.nightSymptoms = [self.nightSymptoms copyWithZone:zone];
        copy.doctorId = [self.doctorId copyWithZone:zone];
        copy.daySymptoms = [self.daySymptoms copyWithZone:zone];
        copy.createDt = [self.createDt copyWithZone:zone];
        copy.modifyDt = [self.modifyDt copyWithZone:zone];
        copy.makeMedicine = [self.makeMedicine copyWithZone:zone];
        copy.sid = [self.sid copyWithZone:zone];
        copy.activity = [self.activity copyWithZone:zone];
        copy.acute = [self.acute copyWithZone:zone];
        copy.urgentMedicine = [self.urgentMedicine copyWithZone:zone];
        copy.cause = [self.cause copyWithZone:zone];
        copy.patientId = [self.patientId copyWithZone:zone];
    }
    
    return copy;
}


@end
