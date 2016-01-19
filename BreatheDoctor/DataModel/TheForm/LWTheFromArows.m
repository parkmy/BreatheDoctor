//
//  LWTheFromArows.m
//
//  Created by   on 16/1/13
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "LWTheFromArows.h"
#import "LWTheFromRowArray.h"


NSString *const kLWTheFromArowsTitle = @"title";
NSString *const kLWTheFromArowsRowArray = @"rowArray";


@interface LWTheFromArows ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWTheFromArows

@synthesize title = _title;
@synthesize rowArray = _rowArray;


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
        self.title = [self objectOrNilForKey:kLWTheFromArowsTitle fromDictionary:dict];
        self.isMulti = [[self objectOrNilForKey:@"multi" fromDictionary:dict] boolValue];
    NSObject *receivedLWTheFromRowArray = [dict objectForKey:kLWTheFromArowsRowArray];
    NSMutableArray *parsedLWTheFromRowArray = [NSMutableArray array];
    if ([receivedLWTheFromRowArray isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLWTheFromRowArray) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLWTheFromRowArray addObject:[LWTheFromRowArray modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLWTheFromRowArray isKindOfClass:[NSDictionary class]]) {
       [parsedLWTheFromRowArray addObject:[LWTheFromRowArray modelObjectWithDictionary:(NSDictionary *)receivedLWTheFromRowArray]];
    }

    self.rowArray = [NSArray arrayWithArray:parsedLWTheFromRowArray];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.title forKey:kLWTheFromArowsTitle];
    NSMutableArray *tempArrayForRowArray = [NSMutableArray array];
    for (NSObject *subArrayObject in self.rowArray) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRowArray addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRowArray addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRowArray] forKey:kLWTheFromArowsRowArray];

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

    self.title = [aDecoder decodeObjectForKey:kLWTheFromArowsTitle];
    self.rowArray = [aDecoder decodeObjectForKey:kLWTheFromArowsRowArray];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_title forKey:kLWTheFromArowsTitle];
    [aCoder encodeObject:_rowArray forKey:kLWTheFromArowsRowArray];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWTheFromArows *copy = [[LWTheFromArows alloc] init];
    
    if (copy) {

        copy.title = [self.title copyWithZone:zone];
        copy.rowArray = [self.rowArray copyWithZone:zone];
    }
    
    return copy;
}


@end
