//
//  LWTheFromBaseModel.m
//
//  Created by   on 16/1/13
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "LWTheFromBaseModel.h"
#import "LWTheFromMrows.h"


NSString *const kLWTheFromBaseModelMrows = @"mrows";


@interface LWTheFromBaseModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWTheFromBaseModel

@synthesize mrows = _mrows;


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
    NSObject *receivedLWTheFromMrows = [dict objectForKey:kLWTheFromBaseModelMrows];
    NSMutableArray *parsedLWTheFromMrows = [NSMutableArray array];
    if ([receivedLWTheFromMrows isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLWTheFromMrows) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLWTheFromMrows addObject:[LWTheFromMrows modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLWTheFromMrows isKindOfClass:[NSDictionary class]]) {
       [parsedLWTheFromMrows addObject:[LWTheFromMrows modelObjectWithDictionary:(NSDictionary *)receivedLWTheFromMrows]];
    }

    self.mrows = [NSArray arrayWithArray:parsedLWTheFromMrows];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForMrows = [NSMutableArray array];
    for (NSObject *subArrayObject in self.mrows) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForMrows addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForMrows addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMrows] forKey:kLWTheFromBaseModelMrows];

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

    self.mrows = [aDecoder decodeObjectForKey:kLWTheFromBaseModelMrows];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_mrows forKey:kLWTheFromBaseModelMrows];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWTheFromBaseModel *copy = [[LWTheFromBaseModel alloc] init];
    
    if (copy) {

        copy.mrows = [self.mrows copyWithZone:zone];
    }
    
    return copy;
}


@end
