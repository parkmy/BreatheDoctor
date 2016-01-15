//
//  LWChatDataStruct.m
//
//  Created by   on 15/11/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LWChatDataStruct.h"


NSString *const kLWChatDataStructAssessDt = @"assessDt";
NSString *const kLWChatDataStructContent = @"content";
NSString *const kLWChatDataStructRecordDt = @"recordDt";
NSString *const kLWChatDataStructTimeFrame = @"timeFrame";
NSString *const kLWChatDataStructDoctorText = @"doctorText";
NSString *const kLWChatDataStructContentType = @"contentType";
NSString *const kLWChatDataStructVoiceMin = @"voiceMin";
NSString *const kLWChatDataStructPEFLevel = @"pEFLevel";
NSString *const kLWChatDataStructPatientText = @"patientText";
NSString *const kLWChatDataStructAssessResult = @"assessResult";
NSString *const kLWChatDataStructPEFValue = @"pEFValue";


@interface LWChatDataStruct ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWChatDataStruct

@synthesize assessDt = _assessDt;
@synthesize content = _content;
@synthesize recordDt = _recordDt;
@synthesize timeFrame = _timeFrame;
@synthesize doctorText = _doctorText;
@synthesize contentType = _contentType;
@synthesize voiceMin = _voiceMin;
@synthesize pEFLevel = _pEFLevel;
@synthesize patientText = _patientText;
@synthesize assessResult = _assessResult;
@synthesize pEFValue = _pEFValue;


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
            self.assessDt = [self objectOrNilForKey:kLWChatDataStructAssessDt fromDictionary:dict];
            self.content = [self objectOrNilForKey:kLWChatDataStructContent fromDictionary:dict];
            self.recordDt = [self objectOrNilForKey:kLWChatDataStructRecordDt fromDictionary:dict];
            self.timeFrame = [[self objectOrNilForKey:kLWChatDataStructTimeFrame fromDictionary:dict] doubleValue];
            self.doctorText = [self objectOrNilForKey:kLWChatDataStructDoctorText fromDictionary:dict];
            self.contentType = [[self objectOrNilForKey:kLWChatDataStructContentType fromDictionary:dict] integerValue];
            self.voiceMin = [[self objectOrNilForKey:kLWChatDataStructVoiceMin fromDictionary:dict] doubleValue];
            self.pEFLevel = [self objectOrNilForKey:kLWChatDataStructPEFLevel fromDictionary:dict];
            self.patientText = [self objectOrNilForKey:kLWChatDataStructPatientText fromDictionary:dict];
            self.assessResult = [[self objectOrNilForKey:kLWChatDataStructAssessResult fromDictionary:dict] doubleValue];
            self.pEFValue = [[self objectOrNilForKey:kLWChatDataStructPEFValue fromDictionary:dict] doubleValue];

        
        self.pharmacyUrgency = [[self objectOrNilForKey:@"pharmacyUrgency" fromDictionary:dict] doubleValue];
        self.symptomChestdistress = [[self objectOrNilForKey:@"symptomChestdistress" fromDictionary:dict] doubleValue];
        self.symptomDyspnea = [[self objectOrNilForKey:@"symptomDyspnea" fromDictionary:dict] doubleValue];
        self.symptomCough = [[self objectOrNilForKey:@"symptomCough" fromDictionary:dict] doubleValue];
        self.pharmacyControl = [[self objectOrNilForKey:@"pharmacyControl" fromDictionary:dict] doubleValue];
        self.remark = [self objectOrNilForKey:@"remark" fromDictionary:dict];
        self.symptomNightWoke = [[self objectOrNilForKey:@"symptomNightWoke" fromDictionary:dict] doubleValue];
        self.symptomGood = [[self objectOrNilForKey:@"symptomGood" fromDictionary:dict] doubleValue];
        
        
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.assessDt forKey:kLWChatDataStructAssessDt];
    [mutableDict setValue:self.content forKey:kLWChatDataStructContent];
    [mutableDict setValue:self.recordDt forKey:kLWChatDataStructRecordDt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.timeFrame] forKey:kLWChatDataStructTimeFrame];
    [mutableDict setValue:self.doctorText forKey:kLWChatDataStructDoctorText];
    [mutableDict setValue:[NSNumber numberWithInteger:self.contentType] forKey:kLWChatDataStructContentType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.voiceMin] forKey:kLWChatDataStructVoiceMin];
    [mutableDict setValue:self.pEFLevel forKey:kLWChatDataStructPEFLevel];
    [mutableDict setValue:self.patientText forKey:kLWChatDataStructPatientText];
    [mutableDict setValue:[NSNumber numberWithDouble:self.assessResult] forKey:kLWChatDataStructAssessResult];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pEFValue] forKey:kLWChatDataStructPEFValue];

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

    self.assessDt = [aDecoder decodeObjectForKey:kLWChatDataStructAssessDt];
    self.content = [aDecoder decodeObjectForKey:kLWChatDataStructContent];
    self.recordDt = [aDecoder decodeObjectForKey:kLWChatDataStructRecordDt];
    self.timeFrame = [aDecoder decodeDoubleForKey:kLWChatDataStructTimeFrame];
    self.doctorText = [aDecoder decodeObjectForKey:kLWChatDataStructDoctorText];
    self.contentType = [aDecoder decodeDoubleForKey:kLWChatDataStructContentType];
    self.voiceMin = [aDecoder decodeDoubleForKey:kLWChatDataStructVoiceMin];
    self.pEFLevel = [aDecoder decodeObjectForKey:kLWChatDataStructPEFLevel];
    self.patientText = [aDecoder decodeObjectForKey:kLWChatDataStructPatientText];
    self.assessResult = [aDecoder decodeDoubleForKey:kLWChatDataStructAssessResult];
    self.pEFValue = [aDecoder decodeDoubleForKey:kLWChatDataStructPEFValue];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_assessDt forKey:kLWChatDataStructAssessDt];
    [aCoder encodeObject:_content forKey:kLWChatDataStructContent];
    [aCoder encodeObject:_recordDt forKey:kLWChatDataStructRecordDt];
    [aCoder encodeDouble:_timeFrame forKey:kLWChatDataStructTimeFrame];
    [aCoder encodeObject:_doctorText forKey:kLWChatDataStructDoctorText];
    [aCoder encodeDouble:_contentType forKey:kLWChatDataStructContentType];
    [aCoder encodeDouble:_voiceMin forKey:kLWChatDataStructVoiceMin];
    [aCoder encodeObject:_pEFLevel forKey:kLWChatDataStructPEFLevel];
    [aCoder encodeObject:_patientText forKey:kLWChatDataStructPatientText];
    [aCoder encodeDouble:_assessResult forKey:kLWChatDataStructAssessResult];
    [aCoder encodeDouble:_pEFValue forKey:kLWChatDataStructPEFValue];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWChatDataStruct *copy = [[LWChatDataStruct alloc] init];
    
    if (copy) {

        copy.assessDt = [self.assessDt copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
        copy.recordDt = [self.recordDt copyWithZone:zone];
        copy.timeFrame = self.timeFrame;
        copy.doctorText = [self.doctorText copyWithZone:zone];
        copy.contentType = self.contentType;
        copy.voiceMin = self.voiceMin;
        copy.pEFLevel = [self.pEFLevel copyWithZone:zone];
        copy.patientText = [self.patientText copyWithZone:zone];
        copy.assessResult = self.assessResult;
        copy.pEFValue = self.pEFValue;
    }
    
    return copy;
}


@end
