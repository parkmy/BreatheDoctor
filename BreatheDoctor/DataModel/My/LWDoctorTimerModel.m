//
//  LWDoctorTimerModel.m
//
//  Created by   on 16/1/14
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "LWDoctorTimerModel.h"


NSString *const kLWDoctorTimerModelStartTime = @"startTime";
NSString *const kLWDoctorTimerModelSid = @"sid";
NSString *const kLWDoctorTimerModelRepeatWeek = @"repeatWeek";
NSString *const kLWDoctorTimerModelEndTime = @"endTime";
NSString *const kLWDoctorTimerModelDoctorId = @"doctorId";


@interface LWDoctorTimerModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWDoctorTimerModel

@synthesize startTime = _startTime;
@synthesize sid = _sid;
@synthesize repeatWeek = _repeatWeek;
@synthesize endTime = _endTime;
@synthesize doctorId = _doctorId;

+ (instancetype)getInitModel
{
    LWDoctorTimerModel *model = [[LWDoctorTimerModel alloc] init];
    model.startTime = @"00:00";
    model.endTime = @"00:00";
    model.repeatWeek = @"";
    return model;
}
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
            self.startTime = [self objectOrNilForKey:kLWDoctorTimerModelStartTime fromDictionary:dict];
            self.sid = [self objectOrNilForKey:kLWDoctorTimerModelSid fromDictionary:dict];
            self.repeatWeek = [self objectOrNilForKey:kLWDoctorTimerModelRepeatWeek fromDictionary:dict];
            self.endTime = [self objectOrNilForKey:kLWDoctorTimerModelEndTime fromDictionary:dict];
            self.doctorId = [self objectOrNilForKey:kLWDoctorTimerModelDoctorId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.startTime forKey:kLWDoctorTimerModelStartTime];
    [mutableDict setValue:self.sid forKey:kLWDoctorTimerModelSid];
    [mutableDict setValue:self.repeatWeek forKey:kLWDoctorTimerModelRepeatWeek];
    [mutableDict setValue:self.endTime forKey:kLWDoctorTimerModelEndTime];
    [mutableDict setValue:self.doctorId forKey:kLWDoctorTimerModelDoctorId];

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

    self.startTime = [aDecoder decodeObjectForKey:kLWDoctorTimerModelStartTime];
    self.sid = [aDecoder decodeObjectForKey:kLWDoctorTimerModelSid];
    self.repeatWeek = [aDecoder decodeObjectForKey:kLWDoctorTimerModelRepeatWeek];
    self.endTime = [aDecoder decodeObjectForKey:kLWDoctorTimerModelEndTime];
    self.doctorId = [aDecoder decodeObjectForKey:kLWDoctorTimerModelDoctorId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_startTime forKey:kLWDoctorTimerModelStartTime];
    [aCoder encodeObject:_sid forKey:kLWDoctorTimerModelSid];
    [aCoder encodeObject:_repeatWeek forKey:kLWDoctorTimerModelRepeatWeek];
    [aCoder encodeObject:_endTime forKey:kLWDoctorTimerModelEndTime];
    [aCoder encodeObject:_doctorId forKey:kLWDoctorTimerModelDoctorId];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWDoctorTimerModel *copy = [[LWDoctorTimerModel alloc] init];
    
    if (copy) {

        copy.startTime = [self.startTime copyWithZone:zone];
        copy.sid = [self.sid copyWithZone:zone];
        copy.repeatWeek = [self.repeatWeek copyWithZone:zone];
        copy.endTime = [self.endTime copyWithZone:zone];
        copy.doctorId = [self.doctorId copyWithZone:zone];
    }
    
    return copy;
}


@end
