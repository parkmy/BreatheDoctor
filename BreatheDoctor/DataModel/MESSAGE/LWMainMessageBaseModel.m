//
//  LWMainMessageBaseModel.m
//
//  Created by   on 15/11/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LWMainMessageBaseModel.h"
#import "LWMainBody.h"


NSString *const kLWMainMessageBaseModelResNum = @"res_num";
NSString *const kLWMainMessageBaseModelSessionId = @"sessionId";
NSString *const kLWMainMessageBaseModelJoinId = @"join_id";
NSString *const kLWMainMessageBaseModelValid = @"valid";
NSString *const kLWMainMessageBaseModelReqNum = @"req_num";
NSString *const kLWMainMessageBaseModelBody = @"body";


@interface LWMainMessageBaseModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWMainMessageBaseModel

@synthesize resNum = _resNum;
@synthesize sessionId = _sessionId;
@synthesize joinId = _joinId;
@synthesize valid = _valid;
@synthesize reqNum = _reqNum;
@synthesize body = _body;


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
            self.resNum = [self objectOrNilForKey:kLWMainMessageBaseModelResNum fromDictionary:dict];
            self.sessionId = [self objectOrNilForKey:kLWMainMessageBaseModelSessionId fromDictionary:dict];
            self.joinId = [self objectOrNilForKey:kLWMainMessageBaseModelJoinId fromDictionary:dict];
            self.valid = [self objectOrNilForKey:kLWMainMessageBaseModelValid fromDictionary:dict];
            self.reqNum = [self objectOrNilForKey:kLWMainMessageBaseModelReqNum fromDictionary:dict];
            self.body = [LWMainBody modelObjectWithDictionary:[dict objectForKey:kLWMainMessageBaseModelBody]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.resNum forKey:kLWMainMessageBaseModelResNum];
    [mutableDict setValue:self.sessionId forKey:kLWMainMessageBaseModelSessionId];
    [mutableDict setValue:self.joinId forKey:kLWMainMessageBaseModelJoinId];
    [mutableDict setValue:self.valid forKey:kLWMainMessageBaseModelValid];
    [mutableDict setValue:self.reqNum forKey:kLWMainMessageBaseModelReqNum];
    [mutableDict setValue:[self.body dictionaryRepresentation] forKey:kLWMainMessageBaseModelBody];

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

    self.resNum = [aDecoder decodeObjectForKey:kLWMainMessageBaseModelResNum];
    self.sessionId = [aDecoder decodeObjectForKey:kLWMainMessageBaseModelSessionId];
    self.joinId = [aDecoder decodeObjectForKey:kLWMainMessageBaseModelJoinId];
    self.valid = [aDecoder decodeObjectForKey:kLWMainMessageBaseModelValid];
    self.reqNum = [aDecoder decodeObjectForKey:kLWMainMessageBaseModelReqNum];
    self.body = [aDecoder decodeObjectForKey:kLWMainMessageBaseModelBody];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_resNum forKey:kLWMainMessageBaseModelResNum];
    [aCoder encodeObject:_sessionId forKey:kLWMainMessageBaseModelSessionId];
    [aCoder encodeObject:_joinId forKey:kLWMainMessageBaseModelJoinId];
    [aCoder encodeObject:_valid forKey:kLWMainMessageBaseModelValid];
    [aCoder encodeObject:_reqNum forKey:kLWMainMessageBaseModelReqNum];
    [aCoder encodeObject:_body forKey:kLWMainMessageBaseModelBody];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWMainMessageBaseModel *copy = [[LWMainMessageBaseModel alloc] init];
    
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
