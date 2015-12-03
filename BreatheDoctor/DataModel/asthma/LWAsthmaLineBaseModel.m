//
//  LWAsthmaLineBaseModel.m
//
//  Created by   on 15/12/1
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LWAsthmaLineBaseModel.h"
#import "LWAsthmaLineBody.h"


NSString *const kLWAsthmaLineBaseModelBody = @"body";
NSString *const kLWAsthmaLineBaseModelJoinId = @"join_id";
NSString *const kLWAsthmaLineBaseModelSessionId = @"sessionId";
NSString *const kLWAsthmaLineBaseModelValid = @"valid";
NSString *const kLWAsthmaLineBaseModelResNum = @"res_num";
NSString *const kLWAsthmaLineBaseModelReqNum = @"req_num";


@interface LWAsthmaLineBaseModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWAsthmaLineBaseModel

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
    NSObject *receivedLWAsthmaLineBody = [dict objectForKey:kLWAsthmaLineBaseModelBody];
    NSMutableArray *parsedLWAsthmaLineBody = [NSMutableArray array];
    if ([receivedLWAsthmaLineBody isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLWAsthmaLineBody) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLWAsthmaLineBody addObject:[LWAsthmaLineBody modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLWAsthmaLineBody isKindOfClass:[NSDictionary class]]) {
       [parsedLWAsthmaLineBody addObject:[LWAsthmaLineBody modelObjectWithDictionary:(NSDictionary *)receivedLWAsthmaLineBody]];
    }

    self.body = [NSArray arrayWithArray:parsedLWAsthmaLineBody];
            self.joinId = [self objectOrNilForKey:kLWAsthmaLineBaseModelJoinId fromDictionary:dict];
            self.sessionId = [self objectOrNilForKey:kLWAsthmaLineBaseModelSessionId fromDictionary:dict];
            self.valid = [self objectOrNilForKey:kLWAsthmaLineBaseModelValid fromDictionary:dict];
            self.resNum = [self objectOrNilForKey:kLWAsthmaLineBaseModelResNum fromDictionary:dict];
            self.reqNum = [self objectOrNilForKey:kLWAsthmaLineBaseModelReqNum fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForBody = [NSMutableArray array];
    for (NSObject *subArrayObject in self.body) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForBody addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForBody addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForBody] forKey:kLWAsthmaLineBaseModelBody];
    [mutableDict setValue:self.joinId forKey:kLWAsthmaLineBaseModelJoinId];
    [mutableDict setValue:self.sessionId forKey:kLWAsthmaLineBaseModelSessionId];
    [mutableDict setValue:self.valid forKey:kLWAsthmaLineBaseModelValid];
    [mutableDict setValue:self.resNum forKey:kLWAsthmaLineBaseModelResNum];
    [mutableDict setValue:self.reqNum forKey:kLWAsthmaLineBaseModelReqNum];

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

    self.body = [aDecoder decodeObjectForKey:kLWAsthmaLineBaseModelBody];
    self.joinId = [aDecoder decodeObjectForKey:kLWAsthmaLineBaseModelJoinId];
    self.sessionId = [aDecoder decodeObjectForKey:kLWAsthmaLineBaseModelSessionId];
    self.valid = [aDecoder decodeObjectForKey:kLWAsthmaLineBaseModelValid];
    self.resNum = [aDecoder decodeObjectForKey:kLWAsthmaLineBaseModelResNum];
    self.reqNum = [aDecoder decodeObjectForKey:kLWAsthmaLineBaseModelReqNum];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_body forKey:kLWAsthmaLineBaseModelBody];
    [aCoder encodeObject:_joinId forKey:kLWAsthmaLineBaseModelJoinId];
    [aCoder encodeObject:_sessionId forKey:kLWAsthmaLineBaseModelSessionId];
    [aCoder encodeObject:_valid forKey:kLWAsthmaLineBaseModelValid];
    [aCoder encodeObject:_resNum forKey:kLWAsthmaLineBaseModelResNum];
    [aCoder encodeObject:_reqNum forKey:kLWAsthmaLineBaseModelReqNum];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWAsthmaLineBaseModel *copy = [[LWAsthmaLineBaseModel alloc] init];
    
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
