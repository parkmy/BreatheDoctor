//
//  LWTheFromRowArray.m
//
//  Created by   on 16/1/13
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "LWTheFromRowArray.h"


NSString *const kLWTheFromRowArrayContent = @"content";
NSString *const kLWTheFromRowArrayMid = @"mid";


@interface LWTheFromRowArray ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWTheFromRowArray

@synthesize content = _content;
@synthesize mid = _mid;


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
            self.content = [self objectOrNilForKey:kLWTheFromRowArrayContent fromDictionary:dict];
            self.mid = [self objectOrNilForKey:kLWTheFromRowArrayMid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.content forKey:kLWTheFromRowArrayContent];
    [mutableDict setValue:self.mid forKey:kLWTheFromRowArrayMid];

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

    self.content = [aDecoder decodeObjectForKey:kLWTheFromRowArrayContent];
    self.mid = [aDecoder decodeObjectForKey:kLWTheFromRowArrayMid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_content forKey:kLWTheFromRowArrayContent];
    [aCoder encodeObject:_mid forKey:kLWTheFromRowArrayMid];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWTheFromRowArray *copy = [[LWTheFromRowArray alloc] init];
    
    if (copy) {

        copy.content = [self.content copyWithZone:zone];
        copy.mid = [self.mid copyWithZone:zone];
    }
    
    return copy;
}


@end
