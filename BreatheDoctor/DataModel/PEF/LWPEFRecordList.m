//
//  LWPEFRecordList.m
//
//  Created by   on 15/11/25
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LWPEFRecordList.h"


NSString *const kLWPEFRecordListRecordDt = @"recordDt";
NSString *const kLWPEFRecordListPharmacyUrgency = @"pharmacyUrgency";
NSString *const kLWPEFRecordListSymptomChestdistress = @"symptomChestdistress";
NSString *const kLWPEFRecordListSymptomDyspnea = @"symptomDyspnea";
NSString *const kLWPEFRecordListInsertDt = @"insertDt";
NSString *const kLWPEFRecordListPerfValue = @"perfValue";
NSString *const kLWPEFRecordListPefValue = @"pefValue";
NSString *const kLWPEFRecordListPatientId = @"patientId";
NSString *const kLWPEFRecordListSymptomCough = @"symptomCough";
NSString *const kLWPEFRecordListPharmacyControl = @"pharmacyControl";
NSString *const kLWPEFRecordListRemark = @"remark";
NSString *const kLWPEFRecordListRecordId = @"recordId";
NSString *const kLWPEFRecordListSymptomNightWoke = @"symptomNightWoke";
NSString *const kLWPEFRecordListTimeFrame = @"timeFrame";
NSString *const kLWPEFRecordListSymptomGasp = @"symptomGasp";
NSString *const kLWPEFRecordListSymptomGood = @"symptomGood";


@interface LWPEFRecordList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWPEFRecordList

@synthesize recordDt = _recordDt;
@synthesize pharmacyUrgency = _pharmacyUrgency;
@synthesize symptomChestdistress = _symptomChestdistress;
@synthesize symptomDyspnea = _symptomDyspnea;
@synthesize insertDt = _insertDt;
@synthesize perfValue = _perfValue;
@synthesize pefValue = _pefValue;
@synthesize patientId = _patientId;
@synthesize symptomCough = _symptomCough;
@synthesize pharmacyControl = _pharmacyControl;
@synthesize remark = _remark;
@synthesize recordId = _recordId;
@synthesize symptomNightWoke = _symptomNightWoke;
@synthesize timeFrame = _timeFrame;
@synthesize symptomGasp = _symptomGasp;
@synthesize symptomGood = _symptomGood;


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
            self.recordDt = [self objectOrNilForKey:kLWPEFRecordListRecordDt fromDictionary:dict];
            self.pharmacyUrgency = [[self objectOrNilForKey:kLWPEFRecordListPharmacyUrgency fromDictionary:dict] doubleValue];
            self.symptomChestdistress = [[self objectOrNilForKey:kLWPEFRecordListSymptomChestdistress fromDictionary:dict] doubleValue];
            self.symptomDyspnea = [[self objectOrNilForKey:kLWPEFRecordListSymptomDyspnea fromDictionary:dict] doubleValue];
            self.insertDt = [self objectOrNilForKey:kLWPEFRecordListInsertDt fromDictionary:dict];
            self.perfValue = [[self objectOrNilForKey:kLWPEFRecordListPerfValue fromDictionary:dict] doubleValue];
            self.pefValue = [[self objectOrNilForKey:kLWPEFRecordListPefValue fromDictionary:dict] doubleValue];
            self.patientId = [self objectOrNilForKey:kLWPEFRecordListPatientId fromDictionary:dict];
            self.symptomCough = [[self objectOrNilForKey:kLWPEFRecordListSymptomCough fromDictionary:dict] doubleValue];
            self.pharmacyControl = [[self objectOrNilForKey:kLWPEFRecordListPharmacyControl fromDictionary:dict] doubleValue];
            self.remark = [self objectOrNilForKey:kLWPEFRecordListRemark fromDictionary:dict];
            self.recordId = [self objectOrNilForKey:kLWPEFRecordListRecordId fromDictionary:dict];
            self.symptomNightWoke = [[self objectOrNilForKey:kLWPEFRecordListSymptomNightWoke fromDictionary:dict] doubleValue];
            self.timeFrame = [[self objectOrNilForKey:kLWPEFRecordListTimeFrame fromDictionary:dict] doubleValue];
            self.symptomGasp = [[self objectOrNilForKey:kLWPEFRecordListSymptomGasp fromDictionary:dict] doubleValue];
            self.symptomGood = [[self objectOrNilForKey:kLWPEFRecordListSymptomGood fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.recordDt forKey:kLWPEFRecordListRecordDt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pharmacyUrgency] forKey:kLWPEFRecordListPharmacyUrgency];
    [mutableDict setValue:[NSNumber numberWithDouble:self.symptomChestdistress] forKey:kLWPEFRecordListSymptomChestdistress];
    [mutableDict setValue:[NSNumber numberWithDouble:self.symptomDyspnea] forKey:kLWPEFRecordListSymptomDyspnea];
    [mutableDict setValue:self.insertDt forKey:kLWPEFRecordListInsertDt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.perfValue] forKey:kLWPEFRecordListPerfValue];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pefValue] forKey:kLWPEFRecordListPefValue];
    [mutableDict setValue:self.patientId forKey:kLWPEFRecordListPatientId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.symptomCough] forKey:kLWPEFRecordListSymptomCough];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pharmacyControl] forKey:kLWPEFRecordListPharmacyControl];
    [mutableDict setValue:self.remark forKey:kLWPEFRecordListRemark];
    [mutableDict setValue:self.recordId forKey:kLWPEFRecordListRecordId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.symptomNightWoke] forKey:kLWPEFRecordListSymptomNightWoke];
    [mutableDict setValue:[NSNumber numberWithDouble:self.timeFrame] forKey:kLWPEFRecordListTimeFrame];
    [mutableDict setValue:[NSNumber numberWithDouble:self.symptomGasp] forKey:kLWPEFRecordListSymptomGasp];
    [mutableDict setValue:[NSNumber numberWithDouble:self.symptomGood] forKey:kLWPEFRecordListSymptomGood];

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

    self.recordDt = [aDecoder decodeObjectForKey:kLWPEFRecordListRecordDt];
    self.pharmacyUrgency = [aDecoder decodeDoubleForKey:kLWPEFRecordListPharmacyUrgency];
    self.symptomChestdistress = [aDecoder decodeDoubleForKey:kLWPEFRecordListSymptomChestdistress];
    self.symptomDyspnea = [aDecoder decodeDoubleForKey:kLWPEFRecordListSymptomDyspnea];
    self.insertDt = [aDecoder decodeObjectForKey:kLWPEFRecordListInsertDt];
    self.perfValue = [aDecoder decodeDoubleForKey:kLWPEFRecordListPerfValue];
    self.pefValue = [aDecoder decodeDoubleForKey:kLWPEFRecordListPefValue];
    self.patientId = [aDecoder decodeObjectForKey:kLWPEFRecordListPatientId];
    self.symptomCough = [aDecoder decodeDoubleForKey:kLWPEFRecordListSymptomCough];
    self.pharmacyControl = [aDecoder decodeDoubleForKey:kLWPEFRecordListPharmacyControl];
    self.remark = [aDecoder decodeObjectForKey:kLWPEFRecordListRemark];
    self.recordId = [aDecoder decodeObjectForKey:kLWPEFRecordListRecordId];
    self.symptomNightWoke = [aDecoder decodeDoubleForKey:kLWPEFRecordListSymptomNightWoke];
    self.timeFrame = [aDecoder decodeDoubleForKey:kLWPEFRecordListTimeFrame];
    self.symptomGasp = [aDecoder decodeDoubleForKey:kLWPEFRecordListSymptomGasp];
    self.symptomGood = [aDecoder decodeDoubleForKey:kLWPEFRecordListSymptomGood];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_recordDt forKey:kLWPEFRecordListRecordDt];
    [aCoder encodeDouble:_pharmacyUrgency forKey:kLWPEFRecordListPharmacyUrgency];
    [aCoder encodeDouble:_symptomChestdistress forKey:kLWPEFRecordListSymptomChestdistress];
    [aCoder encodeDouble:_symptomDyspnea forKey:kLWPEFRecordListSymptomDyspnea];
    [aCoder encodeObject:_insertDt forKey:kLWPEFRecordListInsertDt];
    [aCoder encodeDouble:_perfValue forKey:kLWPEFRecordListPerfValue];
    [aCoder encodeDouble:_pefValue forKey:kLWPEFRecordListPefValue];
    [aCoder encodeObject:_patientId forKey:kLWPEFRecordListPatientId];
    [aCoder encodeDouble:_symptomCough forKey:kLWPEFRecordListSymptomCough];
    [aCoder encodeDouble:_pharmacyControl forKey:kLWPEFRecordListPharmacyControl];
    [aCoder encodeObject:_remark forKey:kLWPEFRecordListRemark];
    [aCoder encodeObject:_recordId forKey:kLWPEFRecordListRecordId];
    [aCoder encodeDouble:_symptomNightWoke forKey:kLWPEFRecordListSymptomNightWoke];
    [aCoder encodeDouble:_timeFrame forKey:kLWPEFRecordListTimeFrame];
    [aCoder encodeDouble:_symptomGasp forKey:kLWPEFRecordListSymptomGasp];
    [aCoder encodeDouble:_symptomGood forKey:kLWPEFRecordListSymptomGood];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWPEFRecordList *copy = [[LWPEFRecordList alloc] init];
    
    if (copy) {

        copy.recordDt = [self.recordDt copyWithZone:zone];
        copy.pharmacyUrgency = self.pharmacyUrgency;
        copy.symptomChestdistress = self.symptomChestdistress;
        copy.symptomDyspnea = self.symptomDyspnea;
        copy.insertDt = [self.insertDt copyWithZone:zone];
        copy.perfValue = self.perfValue;
        copy.pefValue = self.pefValue;
        copy.patientId = [self.patientId copyWithZone:zone];
        copy.symptomCough = self.symptomCough;
        copy.pharmacyControl = self.pharmacyControl;
        copy.remark = [self.remark copyWithZone:zone];
        copy.recordId = [self.recordId copyWithZone:zone];
        copy.symptomNightWoke = self.symptomNightWoke;
        copy.timeFrame = self.timeFrame;
        copy.symptomGasp = self.symptomGasp;
        copy.symptomGood = self.symptomGood;
    }
    
    return copy;
}


@end
