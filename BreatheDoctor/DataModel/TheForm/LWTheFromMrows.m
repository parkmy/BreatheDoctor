//
//  LWTheFromMrows.m
//
//  Created by   on 16/1/13
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "LWTheFromMrows.h"
#import "LWTheFromArows.h"


NSString *const kLWTheFromMrowsArows = @"arows";
NSString *const kLWTheFromMrowsSectiontitle = @"sectiontitle";


@interface LWTheFromMrows ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWTheFromMrows

@synthesize arows = _arows;
@synthesize sectiontitle = _sectiontitle;


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
    NSObject *receivedLWTheFromArows = [dict objectForKey:kLWTheFromMrowsArows];
    NSMutableArray *parsedLWTheFromArows = [NSMutableArray array];
    if ([receivedLWTheFromArows isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLWTheFromArows) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLWTheFromArows addObject:[LWTheFromArows modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLWTheFromArows isKindOfClass:[NSDictionary class]]) {
       [parsedLWTheFromArows addObject:[LWTheFromArows modelObjectWithDictionary:(NSDictionary *)receivedLWTheFromArows]];
    }

    self.arows = [NSArray arrayWithArray:parsedLWTheFromArows];
            self.sectiontitle = [self objectOrNilForKey:kLWTheFromMrowsSectiontitle fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForArows = [NSMutableArray array];
    for (NSObject *subArrayObject in self.arows) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForArows addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForArows addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForArows] forKey:kLWTheFromMrowsArows];
    [mutableDict setValue:self.sectiontitle forKey:kLWTheFromMrowsSectiontitle];

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

    self.arows = [aDecoder decodeObjectForKey:kLWTheFromMrowsArows];
    self.sectiontitle = [aDecoder decodeObjectForKey:kLWTheFromMrowsSectiontitle];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_arows forKey:kLWTheFromMrowsArows];
    [aCoder encodeObject:_sectiontitle forKey:kLWTheFromMrowsSectiontitle];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWTheFromMrows *copy = [[LWTheFromMrows alloc] init];
    
    if (copy) {

        copy.arows = [self.arows copyWithZone:zone];
        copy.sectiontitle = [self.sectiontitle copyWithZone:zone];
    }
    
    return copy;
}


@end
