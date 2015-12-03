//
//  LWPatientBaseModel.m
//
//  Created by   on 15/11/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LWPatientBaseModel.h"
#import "LWPatientBody.h"


NSString *const kLWPatientBaseModelResNum = @"res_num";
NSString *const kLWPatientBaseModelSessionId = @"sessionId";
NSString *const kLWPatientBaseModelJoinId = @"join_id";
NSString *const kLWPatientBaseModelValid = @"valid";
NSString *const kLWPatientBaseModelReqNum = @"req_num";
NSString *const kLWPatientBaseModelBody = @"body";
NSString *const kLWPatientBaseModelResMsg = @"res_msg";


@interface LWPatientBaseModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWPatientBaseModel

@synthesize resNum = _resNum;
@synthesize sessionId = _sessionId;
@synthesize joinId = _joinId;
@synthesize valid = _valid;
@synthesize reqNum = _reqNum;
@synthesize body = _body;
@synthesize resMsg = _resMsg;


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
            self.resNum = [self objectOrNilForKey:kLWPatientBaseModelResNum fromDictionary:dict];
            self.sessionId = [self objectOrNilForKey:kLWPatientBaseModelSessionId fromDictionary:dict];
            self.joinId = [self objectOrNilForKey:kLWPatientBaseModelJoinId fromDictionary:dict];
            self.valid = [self objectOrNilForKey:kLWPatientBaseModelValid fromDictionary:dict];
            self.reqNum = [self objectOrNilForKey:kLWPatientBaseModelReqNum fromDictionary:dict];
            self.body = [LWPatientBody modelObjectWithDictionary:[dict objectForKey:kLWPatientBaseModelBody]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.resNum forKey:kLWPatientBaseModelResNum];
    [mutableDict setValue:self.sessionId forKey:kLWPatientBaseModelSessionId];
    [mutableDict setValue:self.joinId forKey:kLWPatientBaseModelJoinId];
    [mutableDict setValue:self.valid forKey:kLWPatientBaseModelValid];
    [mutableDict setValue:self.reqNum forKey:kLWPatientBaseModelReqNum];
    [mutableDict setValue:[self.body dictionaryRepresentation] forKey:kLWPatientBaseModelBody];

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

    self.resNum = [aDecoder decodeObjectForKey:kLWPatientBaseModelResNum];
    self.sessionId = [aDecoder decodeObjectForKey:kLWPatientBaseModelSessionId];
    self.joinId = [aDecoder decodeObjectForKey:kLWPatientBaseModelJoinId];
    self.valid = [aDecoder decodeObjectForKey:kLWPatientBaseModelValid];
    self.reqNum = [aDecoder decodeObjectForKey:kLWPatientBaseModelReqNum];
    self.body = [aDecoder decodeObjectForKey:kLWPatientBaseModelBody];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_resNum forKey:kLWPatientBaseModelResNum];
    [aCoder encodeObject:_sessionId forKey:kLWPatientBaseModelSessionId];
    [aCoder encodeObject:_joinId forKey:kLWPatientBaseModelJoinId];
    [aCoder encodeObject:_valid forKey:kLWPatientBaseModelValid];
    [aCoder encodeObject:_reqNum forKey:kLWPatientBaseModelReqNum];
    [aCoder encodeObject:_body forKey:kLWPatientBaseModelBody];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWPatientBaseModel *copy = [[LWPatientBaseModel alloc] init];
    
    if (copy) {

        copy.resNum = [self.resNum copyWithZone:zone];
        copy.sessionId = [self.sessionId copyWithZone:zone];
        copy.joinId = [self.joinId copyWithZone:zone];
        copy.valid = [self.valid copyWithZone:zone];
        copy.reqNum = [self.reqNum copyWithZone:zone];
        copy.body = [self.body copyWithZone:zone];
    }
    
    return copy;
}


@end
