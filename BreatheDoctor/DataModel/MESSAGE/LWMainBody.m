//
//  LWMainBody.m
//
//  Created by   on 15/11/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LWMainBody.h"
#import "LWMainPager.h"
#import "LWMainRows.h"


NSString *const kLWMainBodyPager = @"pager";
NSString *const kLWMainBodyRefreshDate = @"refreshDate";
NSString *const kLWMainBodyRows = @"rows";


@interface LWMainBody ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWMainBody

@synthesize pager = _pager;
@synthesize refreshDate = _refreshDate;
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
            self.pager = [LWMainPager modelObjectWithDictionary:[dict objectForKey:kLWMainBodyPager]];
            self.refreshDate = [self objectOrNilForKey:kLWMainBodyRefreshDate fromDictionary:dict];
    NSObject *receivedLWMainRows = [dict objectForKey:kLWMainBodyRows];
    NSMutableArray *parsedLWMainRows = [NSMutableArray array];
    if ([receivedLWMainRows isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLWMainRows) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                LWMainRows *m = [LWMainRows modelObjectWithDictionary:item];
                m.refreshTime = self.refreshDate;
                [parsedLWMainRows addObject:m];
            }
       }
    } else if ([receivedLWMainRows isKindOfClass:[NSDictionary class]]) {
        LWMainRows *m = [LWMainRows modelObjectWithDictionary:(NSDictionary *)receivedLWMainRows];
        m.refreshTime = self.refreshDate;
       [parsedLWMainRows addObject:m];
    }

    self.rows = [NSArray arrayWithArray:parsedLWMainRows];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.pager dictionaryRepresentation] forKey:kLWMainBodyPager];
    [mutableDict setValue:self.refreshDate forKey:kLWMainBodyRefreshDate];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRows] forKey:kLWMainBodyRows];

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

    self.pager = [aDecoder decodeObjectForKey:kLWMainBodyPager];
    self.refreshDate = [aDecoder decodeObjectForKey:kLWMainBodyRefreshDate];
    self.rows = [aDecoder decodeObjectForKey:kLWMainBodyRows];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_pager forKey:kLWMainBodyPager];
    [aCoder encodeObject:_refreshDate forKey:kLWMainBodyRefreshDate];
    [aCoder encodeObject:_rows forKey:kLWMainBodyRows];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWMainBody *copy = [[LWMainBody alloc] init];
    
    if (copy) {

        copy.pager = [self.pager copyWithZone:zone];
        copy.refreshDate = [self.refreshDate copyWithZone:zone];
        copy.rows = [self.rows copyWithZone:zone];
    }
    
    return copy;
}


@end
