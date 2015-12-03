//
//  LWAsthmaAssessLogBody.m
//
//  Created by   on 15/11/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LWAsthmaAssessLogBody.h"


NSString *const kLWAsthmaAssessLogBodyControlLevelY = @"controlLevel_y";
NSString *const kLWAsthmaAssessLogBodyDateX = @"date_x";


@interface LWAsthmaAssessLogBody ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWAsthmaAssessLogBody

@synthesize controlLevelY = _controlLevelY;
@synthesize dateX = _dateX;


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
            self.controlLevelY = [[self objectOrNilForKey:kLWAsthmaAssessLogBodyControlLevelY fromDictionary:dict] doubleValue];
            self.dateX = [self objectOrNilForKey:kLWAsthmaAssessLogBodyDateX fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.controlLevelY] forKey:kLWAsthmaAssessLogBodyControlLevelY];
    [mutableDict setValue:self.dateX forKey:kLWAsthmaAssessLogBodyDateX];

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

    self.controlLevelY = [aDecoder decodeDoubleForKey:kLWAsthmaAssessLogBodyControlLevelY];
    self.dateX = [aDecoder decodeObjectForKey:kLWAsthmaAssessLogBodyDateX];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_controlLevelY forKey:kLWAsthmaAssessLogBodyControlLevelY];
    [aCoder encodeObject:_dateX forKey:kLWAsthmaAssessLogBodyDateX];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWAsthmaAssessLogBody *copy = [[LWAsthmaAssessLogBody alloc] init];
    
    if (copy) {

        copy.controlLevelY = self.controlLevelY;
        copy.dateX = [self.dateX copyWithZone:zone];
    }
    
    return copy;
}


@end
