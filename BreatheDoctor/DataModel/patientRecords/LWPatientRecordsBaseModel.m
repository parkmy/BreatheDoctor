//
//  LWPatientRecordsBaseModel.m
//
//  Created by   on 15/11/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LWPatientRecordsBaseModel.h"
#import "LWPatientRecordsBody.h"


NSString *const kLWPatientRecordsBaseModelBody = @"body";
NSString *const kLWPatientRecordsBaseModelJoinId = @"join_id";
NSString *const kLWPatientRecordsBaseModelSessionId = @"sessionId";
NSString *const kLWPatientRecordsBaseModelValid = @"valid";
NSString *const kLWPatientRecordsBaseModelResNum = @"res_num";
NSString *const kLWPatientRecordsBaseModelReqNum = @"req_num";


@interface LWPatientRecordsBaseModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWPatientRecordsBaseModel

@synthesize body = _body;
@synthesize joinId = _joinId;
@synthesize sessionId = _sessionId;
@synthesize valid = _valid;
@synthesize resNum = _resNum;
@synthesize reqNum = _reqNum;


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
            self.body = [LWPatientRecordsBody modelObjectWithDictionary:[dict objectForKey:kLWPatientRecordsBaseModelBody]];
            self.joinId = [self objectOrNilForKey:kLWPatientRecordsBaseModelJoinId fromDictionary:dict];
            self.sessionId = [self objectOrNilForKey:kLWPatientRecordsBaseModelSessionId fromDictionary:dict];
            self.valid = [self objectOrNilForKey:kLWPatientRecordsBaseModelValid fromDictionary:dict];
            self.resNum = [self objectOrNilForKey:kLWPatientRecordsBaseModelResNum fromDictionary:dict];
            self.reqNum = [self objectOrNilForKey:kLWPatientRecordsBaseModelReqNum fromDictionary:dict];
            self.paintentId = self.body.patientArchives.patientId;
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.body dictionaryRepresentation] forKey:kLWPatientRecordsBaseModelBody];
    [mutableDict setValue:self.joinId forKey:kLWPatientRecordsBaseModelJoinId];
    [mutableDict setValue:self.sessionId forKey:kLWPatientRecordsBaseModelSessionId];
    [mutableDict setValue:self.valid forKey:kLWPatientRecordsBaseModelValid];
    [mutableDict setValue:self.resNum forKey:kLWPatientRecordsBaseModelResNum];
    [mutableDict setValue:self.reqNum forKey:kLWPatientRecordsBaseModelReqNum];

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

    self.body = [aDecoder decodeObjectForKey:kLWPatientRecordsBaseModelBody];
    self.joinId = [aDecoder decodeObjectForKey:kLWPatientRecordsBaseModelJoinId];
    self.sessionId = [aDecoder decodeObjectForKey:kLWPatientRecordsBaseModelSessionId];
    self.valid = [aDecoder decodeObjectForKey:kLWPatientRecordsBaseModelValid];
    self.resNum = [aDecoder decodeObjectForKey:kLWPatientRecordsBaseModelResNum];
    self.reqNum = [aDecoder decodeObjectForKey:kLWPatientRecordsBaseModelReqNum];
    self.paintentId = [aDecoder decodeObjectForKey:@"pid"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_body forKey:kLWPatientRecordsBaseModelBody];
    [aCoder encodeObject:_joinId forKey:kLWPatientRecordsBaseModelJoinId];
    [aCoder encodeObject:_sessionId forKey:kLWPatientRecordsBaseModelSessionId];
    [aCoder encodeObject:_valid forKey:kLWPatientRecordsBaseModelValid];
    [aCoder encodeObject:_resNum forKey:kLWPatientRecordsBaseModelResNum];
    [aCoder encodeObject:_reqNum forKey:kLWPatientRecordsBaseModelReqNum];
    [aCoder encodeObject:_paintentId forKey:@"pid"];
    
}

- (id)copyWithZone:(NSZone *)zone
{
    LWPatientRecordsBaseModel *copy = [[LWPatientRecordsBaseModel alloc] init];
    
    if (copy) {

        copy.body = [self.body copyWithZone:zone];
        copy.joinId = [self.joinId copyWithZone:zone];
        copy.sessionId = [self.sessionId copyWithZone:zone];
        copy.valid = [self.valid copyWithZone:zone];
        copy.resNum = [self.resNum copyWithZone:zone];
        copy.reqNum = [self.reqNum copyWithZone:zone];
    }
    
    return copy;
}


@end
