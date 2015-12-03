//
//  LWAsthmaAssessLogModel.m
//
//  Created by   on 15/11/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LWAsthmaAssessLogModel.h"
#import "LWAsthmaAssessLogBody.h"


NSString *const kLWAsthmaAssessLogModelBody = @"body";
NSString *const kLWAsthmaAssessLogModelJoinId = @"join_id";
NSString *const kLWAsthmaAssessLogModelSessionId = @"sessionId";
NSString *const kLWAsthmaAssessLogModelValid = @"valid";
NSString *const kLWAsthmaAssessLogModelResNum = @"res_num";
NSString *const kLWAsthmaAssessLogModelReqNum = @"req_num";


@interface LWAsthmaAssessLogModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWAsthmaAssessLogModel

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
    NSObject *receivedLWAsthmaAssessLogBody = [dict objectForKey:kLWAsthmaAssessLogModelBody];
    NSMutableArray *parsedLWAsthmaAssessLogBody = [NSMutableArray array];
    if ([receivedLWAsthmaAssessLogBody isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLWAsthmaAssessLogBody) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLWAsthmaAssessLogBody addObject:[LWAsthmaAssessLogBody modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLWAsthmaAssessLogBody isKindOfClass:[NSDictionary class]]) {
       [parsedLWAsthmaAssessLogBody addObject:[LWAsthmaAssessLogBody modelObjectWithDictionary:(NSDictionary *)receivedLWAsthmaAssessLogBody]];
    }

    self.body = [NSArray arrayWithArray:parsedLWAsthmaAssessLogBody];
            self.joinId = [self objectOrNilForKey:kLWAsthmaAssessLogModelJoinId fromDictionary:dict];
            self.sessionId = [self objectOrNilForKey:kLWAsthmaAssessLogModelSessionId fromDictionary:dict];
            self.valid = [self objectOrNilForKey:kLWAsthmaAssessLogModelValid fromDictionary:dict];
            self.resNum = [self objectOrNilForKey:kLWAsthmaAssessLogModelResNum fromDictionary:dict];
            self.reqNum = [self objectOrNilForKey:kLWAsthmaAssessLogModelReqNum fromDictionary:dict];

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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForBody] forKey:kLWAsthmaAssessLogModelBody];
    [mutableDict setValue:self.joinId forKey:kLWAsthmaAssessLogModelJoinId];
    [mutableDict setValue:self.sessionId forKey:kLWAsthmaAssessLogModelSessionId];
    [mutableDict setValue:self.valid forKey:kLWAsthmaAssessLogModelValid];
    [mutableDict setValue:self.resNum forKey:kLWAsthmaAssessLogModelResNum];
    [mutableDict setValue:self.reqNum forKey:kLWAsthmaAssessLogModelReqNum];

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

    self.body = [aDecoder decodeObjectForKey:kLWAsthmaAssessLogModelBody];
    self.joinId = [aDecoder decodeObjectForKey:kLWAsthmaAssessLogModelJoinId];
    self.sessionId = [aDecoder decodeObjectForKey:kLWAsthmaAssessLogModelSessionId];
    self.valid = [aDecoder decodeObjectForKey:kLWAsthmaAssessLogModelValid];
    self.resNum = [aDecoder decodeObjectForKey:kLWAsthmaAssessLogModelResNum];
    self.reqNum = [aDecoder decodeObjectForKey:kLWAsthmaAssessLogModelReqNum];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_body forKey:kLWAsthmaAssessLogModelBody];
    [aCoder encodeObject:_joinId forKey:kLWAsthmaAssessLogModelJoinId];
    [aCoder encodeObject:_sessionId forKey:kLWAsthmaAssessLogModelSessionId];
    [aCoder encodeObject:_valid forKey:kLWAsthmaAssessLogModelValid];
    [aCoder encodeObject:_resNum forKey:kLWAsthmaAssessLogModelResNum];
    [aCoder encodeObject:_reqNum forKey:kLWAsthmaAssessLogModelReqNum];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWAsthmaAssessLogModel *copy = [[LWAsthmaAssessLogModel alloc] init];
    
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
