//
//  LWPEFLineModel.m
//
//  Created by   on 15/11/25
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LWPEFLineModel.h"
#import "LWPEFBody.h"


NSString *const kLWPEFLineModelBody = @"body";
NSString *const kLWPEFLineModelJoinId = @"join_id";
NSString *const kLWPEFLineModelSessionId = @"sessionId";
NSString *const kLWPEFLineModelValid = @"valid";
NSString *const kLWPEFLineModelResNum = @"res_num";
NSString *const kLWPEFLineModelReqNum = @"req_num";


@interface LWPEFLineModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWPEFLineModel

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
            self.body = [LWPEFBody modelObjectWithDictionary:[dict objectForKey:kLWPEFLineModelBody]];
            self.joinId = [self objectOrNilForKey:kLWPEFLineModelJoinId fromDictionary:dict];
            self.sessionId = [self objectOrNilForKey:kLWPEFLineModelSessionId fromDictionary:dict];
            self.valid = [self objectOrNilForKey:kLWPEFLineModelValid fromDictionary:dict];
            self.resNum = [self objectOrNilForKey:kLWPEFLineModelResNum fromDictionary:dict];
            self.reqNum = [self objectOrNilForKey:kLWPEFLineModelReqNum fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.body dictionaryRepresentation] forKey:kLWPEFLineModelBody];
    [mutableDict setValue:self.joinId forKey:kLWPEFLineModelJoinId];
    [mutableDict setValue:self.sessionId forKey:kLWPEFLineModelSessionId];
    [mutableDict setValue:self.valid forKey:kLWPEFLineModelValid];
    [mutableDict setValue:self.resNum forKey:kLWPEFLineModelResNum];
    [mutableDict setValue:self.reqNum forKey:kLWPEFLineModelReqNum];

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

    self.body = [aDecoder decodeObjectForKey:kLWPEFLineModelBody];
    self.joinId = [aDecoder decodeObjectForKey:kLWPEFLineModelJoinId];
    self.sessionId = [aDecoder decodeObjectForKey:kLWPEFLineModelSessionId];
    self.valid = [aDecoder decodeObjectForKey:kLWPEFLineModelValid];
    self.resNum = [aDecoder decodeObjectForKey:kLWPEFLineModelResNum];
    self.reqNum = [aDecoder decodeObjectForKey:kLWPEFLineModelReqNum];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_body forKey:kLWPEFLineModelBody];
    [aCoder encodeObject:_joinId forKey:kLWPEFLineModelJoinId];
    [aCoder encodeObject:_sessionId forKey:kLWPEFLineModelSessionId];
    [aCoder encodeObject:_valid forKey:kLWPEFLineModelValid];
    [aCoder encodeObject:_resNum forKey:kLWPEFLineModelResNum];
    [aCoder encodeObject:_reqNum forKey:kLWPEFLineModelReqNum];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWPEFLineModel *copy = [[LWPEFLineModel alloc] init];
    
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
