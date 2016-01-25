//
//  LWPatientRelatedModel.m
//
//  Created by   on 16/1/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "LWPatientRelatedModel.h"


NSString *const kLWPatientRelatedModelImages = @"images";
NSString *const kLWPatientRelatedModelModifyDt = @"modifyDt";
NSString *const kLWPatientRelatedModelInsertDt = @"insertDt";
NSString *const kLWPatientRelatedModelDoctorId = @"doctorId";
NSString *const kLWPatientRelatedModelSid = @"sid";
NSString *const kLWPatientRelatedModelTreatmentResult = @"treatmentResult";
NSString *const kLWPatientRelatedModelPatientId = @"patientId";
NSString *const kLWPatientRelatedModelBasicCondition = @"basicCondition";


@interface LWPatientRelatedModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWPatientRelatedModel

@synthesize images = _images;
@synthesize modifyDt = _modifyDt;
@synthesize insertDt = _insertDt;
@synthesize doctorId = _doctorId;
@synthesize sid = _sid;
@synthesize treatmentResult = _treatmentResult;
@synthesize patientId = _patientId;
@synthesize basicCondition = _basicCondition;


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
            self.images = [self objectOrNilForKey:kLWPatientRelatedModelImages fromDictionary:dict];
            self.modifyDt = [self objectOrNilForKey:kLWPatientRelatedModelModifyDt fromDictionary:dict];
            self.insertDt = [self objectOrNilForKey:kLWPatientRelatedModelInsertDt fromDictionary:dict];
            self.doctorId = [self objectOrNilForKey:kLWPatientRelatedModelDoctorId fromDictionary:dict];
            self.sid = [self objectOrNilForKey:kLWPatientRelatedModelSid fromDictionary:dict];
            self.treatmentResult = [self objectOrNilForKey:kLWPatientRelatedModelTreatmentResult fromDictionary:dict];
            self.patientId = [self objectOrNilForKey:kLWPatientRelatedModelPatientId fromDictionary:dict];
            self.basicCondition = [self objectOrNilForKey:kLWPatientRelatedModelBasicCondition fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.images forKey:kLWPatientRelatedModelImages];
    [mutableDict setValue:self.modifyDt forKey:kLWPatientRelatedModelModifyDt];
    [mutableDict setValue:self.insertDt forKey:kLWPatientRelatedModelInsertDt];
    [mutableDict setValue:self.doctorId forKey:kLWPatientRelatedModelDoctorId];
    [mutableDict setValue:self.sid forKey:kLWPatientRelatedModelSid];
    [mutableDict setValue:self.treatmentResult forKey:kLWPatientRelatedModelTreatmentResult];
    [mutableDict setValue:self.patientId forKey:kLWPatientRelatedModelPatientId];
    [mutableDict setValue:self.basicCondition forKey:kLWPatientRelatedModelBasicCondition];

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

    self.images = [aDecoder decodeObjectForKey:kLWPatientRelatedModelImages];
    self.modifyDt = [aDecoder decodeObjectForKey:kLWPatientRelatedModelModifyDt];
    self.insertDt = [aDecoder decodeObjectForKey:kLWPatientRelatedModelInsertDt];
    self.doctorId = [aDecoder decodeObjectForKey:kLWPatientRelatedModelDoctorId];
    self.sid = [aDecoder decodeObjectForKey:kLWPatientRelatedModelSid];
    self.treatmentResult = [aDecoder decodeObjectForKey:kLWPatientRelatedModelTreatmentResult];
    self.patientId = [aDecoder decodeObjectForKey:kLWPatientRelatedModelPatientId];
    self.basicCondition = [aDecoder decodeObjectForKey:kLWPatientRelatedModelBasicCondition];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_images forKey:kLWPatientRelatedModelImages];
    [aCoder encodeObject:_modifyDt forKey:kLWPatientRelatedModelModifyDt];
    [aCoder encodeObject:_insertDt forKey:kLWPatientRelatedModelInsertDt];
    [aCoder encodeObject:_doctorId forKey:kLWPatientRelatedModelDoctorId];
    [aCoder encodeObject:_sid forKey:kLWPatientRelatedModelSid];
    [aCoder encodeObject:_treatmentResult forKey:kLWPatientRelatedModelTreatmentResult];
    [aCoder encodeObject:_patientId forKey:kLWPatientRelatedModelPatientId];
    [aCoder encodeObject:_basicCondition forKey:kLWPatientRelatedModelBasicCondition];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWPatientRelatedModel *copy = [[LWPatientRelatedModel alloc] init];
    
    if (copy) {

        copy.images = [self.images copyWithZone:zone];
        copy.modifyDt = [self.modifyDt copyWithZone:zone];
        copy.insertDt = [self.insertDt copyWithZone:zone];
        copy.doctorId = [self.doctorId copyWithZone:zone];
        copy.sid = [self.sid copyWithZone:zone];
        copy.treatmentResult = [self.treatmentResult copyWithZone:zone];
        copy.patientId = [self.patientId copyWithZone:zone];
        copy.basicCondition = [self.basicCondition copyWithZone:zone];
    }
    
    return copy;
}


@end
