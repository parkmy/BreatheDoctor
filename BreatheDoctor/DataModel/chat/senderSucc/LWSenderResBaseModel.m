//
//  LWSenderResBaseModel.m
//
//  Created by   on 15/11/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LWSenderResBaseModel.h"
#import "LWSenderResBody.h"


NSString *const kLWSenderResBaseModelBody = @"body";
NSString *const kLWSenderResBaseModelJoinId = @"join_id";
NSString *const kLWSenderResBaseModelSessionId = @"sessionId";
NSString *const kLWSenderResBaseModelValid = @"valid";
NSString *const kLWSenderResBaseModelResNum = @"res_num";
NSString *const kLWSenderResBaseModelReqNum = @"req_num";


@interface LWSenderResBaseModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWSenderResBaseModel

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
            self.body = [LWSenderResBody modelObjectWithDictionary:[dict objectForKey:kLWSenderResBaseModelBody]];
            self.joinId = [self objectOrNilForKey:kLWSenderResBaseModelJoinId fromDictionary:dict];
            self.sessionId = [self objectOrNilForKey:kLWSenderResBaseModelSessionId fromDictionary:dict];
            self.valid = [self objectOrNilForKey:kLWSenderResBaseModelValid fromDictionary:dict];
            self.resNum = [self objectOrNilForKey:kLWSenderResBaseModelResNum fromDictionary:dict];
            self.reqNum = [self objectOrNilForKey:kLWSenderResBaseModelReqNum fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.body dictionaryRepresentation] forKey:kLWSenderResBaseModelBody];
    [mutableDict setValue:self.joinId forKey:kLWSenderResBaseModelJoinId];
    [mutableDict setValue:self.sessionId forKey:kLWSenderResBaseModelSessionId];
    [mutableDict setValue:self.valid forKey:kLWSenderResBaseModelValid];
    [mutableDict setValue:self.resNum forKey:kLWSenderResBaseModelResNum];
    [mutableDict setValue:self.reqNum forKey:kLWSenderResBaseModelReqNum];

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

    self.body = [aDecoder decodeObjectForKey:kLWSenderResBaseModelBody];
    self.joinId = [aDecoder decodeObjectForKey:kLWSenderResBaseModelJoinId];
    self.sessionId = [aDecoder decodeObjectForKey:kLWSenderResBaseModelSessionId];
    self.valid = [aDecoder decodeObjectForKey:kLWSenderResBaseModelValid];
    self.resNum = [aDecoder decodeObjectForKey:kLWSenderResBaseModelResNum];
    self.reqNum = [aDecoder decodeObjectForKey:kLWSenderResBaseModelReqNum];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_body forKey:kLWSenderResBaseModelBody];
    [aCoder encodeObject:_joinId forKey:kLWSenderResBaseModelJoinId];
    [aCoder encodeObject:_sessionId forKey:kLWSenderResBaseModelSessionId];
    [aCoder encodeObject:_valid forKey:kLWSenderResBaseModelValid];
    [aCoder encodeObject:_resNum forKey:kLWSenderResBaseModelResNum];
    [aCoder encodeObject:_reqNum forKey:kLWSenderResBaseModelReqNum];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWSenderResBaseModel *copy = [[LWSenderResBaseModel alloc] init];
    
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
