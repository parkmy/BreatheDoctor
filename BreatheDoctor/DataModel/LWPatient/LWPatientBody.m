//
//  LWPatientBody.m
//
//  Created by   on 15/11/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LWPatientBody.h"
#import "LWPatientPager.h"
#import "LWPatientRows.h"


NSString *const kLWPatientBodyPager = @"pager";
NSString *const kLWPatientBodyRefreshTime = @"refreshTime";
NSString *const kLWPatientBodyRows = @"rows";


@interface LWPatientBody ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWPatientBody

@synthesize pager = _pager;
@synthesize refreshTime = _refreshTime;
@synthesize rows = _rows;


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
            self.pager = [LWPatientPager modelObjectWithDictionary:[dict objectForKey:kLWPatientBodyPager]];
            self.refreshTime = [self objectOrNilForKey:kLWPatientBodyRefreshTime fromDictionary:dict];
    NSObject *receivedLWPatientRows = [dict objectForKey:kLWPatientBodyRows];
    NSMutableArray *parsedLWPatientRows = [NSMutableArray array];
    if ([receivedLWPatientRows isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLWPatientRows) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLWPatientRows addObject:[LWPatientRows modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLWPatientRows isKindOfClass:[NSDictionary class]]) {
        LWPatientRows *m = [LWPatientRows modelObjectWithDictionary:(NSDictionary *)receivedLWPatientRows];
        m.refTimer = self.refreshTime;
       [parsedLWPatientRows addObject:m];
    }

    self.rows = [NSArray arrayWithArray:parsedLWPatientRows];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.pager dictionaryRepresentation] forKey:kLWPatientBodyPager];
    [mutableDict setValue:self.refreshTime forKey:kLWPatientBodyRefreshTime];
    NSMutableArray *tempArrayForRows = [NSMutableArray array];
    for (NSObject *subArrayObject in self.rows) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRows addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRows addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRows] forKey:kLWPatientBodyRows];

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

    self.pager = [aDecoder decodeObjectForKey:kLWPatientBodyPager];
    self.refreshTime = [aDecoder decodeObjectForKey:kLWPatientBodyRefreshTime];
    self.rows = [aDecoder decodeObjectForKey:kLWPatientBodyRows];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_pager forKey:kLWPatientBodyPager];
    [aCoder encodeObject:_refreshTime forKey:kLWPatientBodyRefreshTime];
    [aCoder encodeObject:_rows forKey:kLWPatientBodyRows];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWPatientBody *copy = [[LWPatientBody alloc] init];
    
    if (copy) {

        copy.pager = [self.pager copyWithZone:zone];
        copy.refreshTime = [self.refreshTime copyWithZone:zone];
        copy.rows = [self.rows copyWithZone:zone];
    }
    
    return copy;
}


@end
