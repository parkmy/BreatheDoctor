//
//  LWPatientRecordsBody.m
//
//  Created by   on 15/11/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LWPatientRecordsBody.h"
#import "LWPatientRecordsPatientArchives.h"


NSString *const kLWPatientRecordsBodyPatientArchives = @"patientArchives";
NSString *const kLWPatientRecordsBodyLineChart = @"lineChart";


@interface LWPatientRecordsBody ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWPatientRecordsBody

@synthesize patientArchives = _patientArchives;
@synthesize lineChart = _lineChart;


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
            self.patientArchives = [LWPatientRecordsPatientArchives modelObjectWithDictionary:[dict objectForKey:kLWPatientRecordsBodyPatientArchives]];
            self.lineChart = [dict objectForKey:kLWPatientRecordsBodyLineChart];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.patientArchives dictionaryRepresentation] forKey:kLWPatientRecordsBodyPatientArchives];
    [mutableDict setValue:[self.lineChart dictionaryRepresentation] forKey:kLWPatientRecordsBodyLineChart];

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

    self.patientArchives = [aDecoder decodeObjectForKey:kLWPatientRecordsBodyPatientArchives];
    self.lineChart = [aDecoder decodeObjectForKey:kLWPatientRecordsBodyLineChart];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_patientArchives forKey:kLWPatientRecordsBodyPatientArchives];
    [aCoder encodeObject:_lineChart forKey:kLWPatientRecordsBodyLineChart];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWPatientRecordsBody *copy = [[LWPatientRecordsBody alloc] init];
    
    if (copy) {

        copy.patientArchives = [self.patientArchives copyWithZone:zone];
        copy.lineChart = [self.lineChart copyWithZone:zone];
    }
    
    return copy;
}


@end
