//
//  LWACTModel.m
//
//  Created by   on 15/11/24
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LWACTModel.h"


NSString *const kLWACTModelInsertDt = @"insertDt";
NSString *const kLWACTModelAct5 = @"act_5";
NSString *const kLWACTModelActResult = @"actResult";
NSString *const kLWACTModelAct3 = @"act_3";
NSString *const kLWACTModelActId = @"actId";
NSString *const kLWACTModelAct1 = @"act_1";
NSString *const kLWACTModelAssessDt = @"assessDt";
NSString *const kLWACTModelActType = @"actType";
NSString *const kLWACTModelAct4 = @"act_4";
NSString *const kLWACTModelGrade = @"grade";
NSString *const kLWACTModelPatientId = @"patientId";
NSString *const kLWACTModelAct2 = @"act_2";


@interface LWACTModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWACTModel

@synthesize insertDt = _insertDt;
@synthesize act5 = _act5;
@synthesize actResult = _actResult;
@synthesize act3 = _act3;
@synthesize actId = _actId;
@synthesize act1 = _act1;
@synthesize assessDt = _assessDt;
@synthesize actType = _actType;
@synthesize act4 = _act4;
@synthesize grade = _grade;
@synthesize patientId = _patientId;
@synthesize act2 = _act2;


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
            self.insertDt = [self objectOrNilForKey:kLWACTModelInsertDt fromDictionary:dict];
            self.act5 = [[self objectOrNilForKey:kLWACTModelAct5 fromDictionary:dict] doubleValue];
            self.actResult = [[self objectOrNilForKey:kLWACTModelActResult fromDictionary:dict] integerValue];
            self.act3 = [[self objectOrNilForKey:kLWACTModelAct3 fromDictionary:dict] doubleValue];
            self.actId = [self objectOrNilForKey:kLWACTModelActId fromDictionary:dict];
            self.act1 = [[self objectOrNilForKey:kLWACTModelAct1 fromDictionary:dict] doubleValue];
            self.assessDt = [self objectOrNilForKey:kLWACTModelAssessDt fromDictionary:dict];
            self.actType = [[self objectOrNilForKey:kLWACTModelActType fromDictionary:dict] doubleValue];
            self.act4 = [[self objectOrNilForKey:kLWACTModelAct4 fromDictionary:dict] doubleValue];
            self.grade = [[self objectOrNilForKey:kLWACTModelGrade fromDictionary:dict] doubleValue];
            self.patientId = [self objectOrNilForKey:kLWACTModelPatientId fromDictionary:dict];
            self.act2 = [[self objectOrNilForKey:kLWACTModelAct2 fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.insertDt forKey:kLWACTModelInsertDt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.act5] forKey:kLWACTModelAct5];
    [mutableDict setValue:[NSNumber numberWithDouble:self.actResult] forKey:kLWACTModelActResult];
    [mutableDict setValue:[NSNumber numberWithDouble:self.act3] forKey:kLWACTModelAct3];
    [mutableDict setValue:self.actId forKey:kLWACTModelActId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.act1] forKey:kLWACTModelAct1];
    [mutableDict setValue:self.assessDt forKey:kLWACTModelAssessDt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.actType] forKey:kLWACTModelActType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.act4] forKey:kLWACTModelAct4];
    [mutableDict setValue:[NSNumber numberWithDouble:self.grade] forKey:kLWACTModelGrade];
    [mutableDict setValue:self.patientId forKey:kLWACTModelPatientId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.act2] forKey:kLWACTModelAct2];

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

    self.insertDt = [aDecoder decodeObjectForKey:kLWACTModelInsertDt];
    self.act5 = [aDecoder decodeDoubleForKey:kLWACTModelAct5];
    self.actResult = [aDecoder decodeIntegerForKey:kLWACTModelActResult];
    self.act3 = [aDecoder decodeDoubleForKey:kLWACTModelAct3];
    self.actId = [aDecoder decodeObjectForKey:kLWACTModelActId];
    self.act1 = [aDecoder decodeDoubleForKey:kLWACTModelAct1];
    self.assessDt = [aDecoder decodeObjectForKey:kLWACTModelAssessDt];
    self.actType = [aDecoder decodeDoubleForKey:kLWACTModelActType];
    self.act4 = [aDecoder decodeDoubleForKey:kLWACTModelAct4];
    self.grade = [aDecoder decodeDoubleForKey:kLWACTModelGrade];
    self.patientId = [aDecoder decodeObjectForKey:kLWACTModelPatientId];
    self.act2 = [aDecoder decodeDoubleForKey:kLWACTModelAct2];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_insertDt forKey:kLWACTModelInsertDt];
    [aCoder encodeDouble:_act5 forKey:kLWACTModelAct5];
    [aCoder encodeInteger:_actResult forKey:kLWACTModelActResult];
    [aCoder encodeDouble:_act3 forKey:kLWACTModelAct3];
    [aCoder encodeObject:_actId forKey:kLWACTModelActId];
    [aCoder encodeDouble:_act1 forKey:kLWACTModelAct1];
    [aCoder encodeObject:_assessDt forKey:kLWACTModelAssessDt];
    [aCoder encodeDouble:_actType forKey:kLWACTModelActType];
    [aCoder encodeDouble:_act4 forKey:kLWACTModelAct4];
    [aCoder encodeDouble:_grade forKey:kLWACTModelGrade];
    [aCoder encodeObject:_patientId forKey:kLWACTModelPatientId];
    [aCoder encodeDouble:_act2 forKey:kLWACTModelAct2];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWACTModel *copy = [[LWACTModel alloc] init];
    
    if (copy) {

        copy.insertDt = [self.insertDt copyWithZone:zone];
        copy.act5 = self.act5;
        copy.actResult = self.actResult;
        copy.act3 = self.act3;
        copy.actId = [self.actId copyWithZone:zone];
        copy.act1 = self.act1;
        copy.assessDt = [self.assessDt copyWithZone:zone];
        copy.actType = self.actType;
        copy.act4 = self.act4;
        copy.grade = self.grade;
        copy.patientId = [self.patientId copyWithZone:zone];
        copy.act2 = self.act2;
    }
    
    return copy;
}


@end
