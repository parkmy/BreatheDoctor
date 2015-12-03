//
//  LWPEFBody.m
//
//  Created by   on 15/11/25
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LWPEFBody.h"
#import "LWPEFRecordList.h"


NSString *const kLWPEFBodyRecordList = @"recordList";
NSString *const kLWPEFBodyPefPredictedValue = @"pefPredictedValue";


@interface LWPEFBody ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWPEFBody

@synthesize recordList = _recordList;
@synthesize pefPredictedValue = _pefPredictedValue;


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
    NSObject *receivedLWPEFRecordList = [dict objectForKey:kLWPEFBodyRecordList];
    NSMutableArray *parsedLWPEFRecordList = [NSMutableArray array];
    if ([receivedLWPEFRecordList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLWPEFRecordList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLWPEFRecordList addObject:[LWPEFRecordList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLWPEFRecordList isKindOfClass:[NSDictionary class]]) {
       [parsedLWPEFRecordList addObject:[LWPEFRecordList modelObjectWithDictionary:(NSDictionary *)receivedLWPEFRecordList]];
    }

    self.recordList = [NSArray arrayWithArray:parsedLWPEFRecordList];
            self.pefPredictedValue = [[self objectOrNilForKey:kLWPEFBodyPefPredictedValue fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForRecordList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.recordList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRecordList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRecordList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRecordList] forKey:kLWPEFBodyRecordList];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pefPredictedValue] forKey:kLWPEFBodyPefPredictedValue];

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

    self.recordList = [aDecoder decodeObjectForKey:kLWPEFBodyRecordList];
    self.pefPredictedValue = [aDecoder decodeDoubleForKey:kLWPEFBodyPefPredictedValue];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_recordList forKey:kLWPEFBodyRecordList];
    [aCoder encodeDouble:_pefPredictedValue forKey:kLWPEFBodyPefPredictedValue];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWPEFBody *copy = [[LWPEFBody alloc] init];
    
    if (copy) {

        copy.recordList = [self.recordList copyWithZone:zone];
        copy.pefPredictedValue = self.pefPredictedValue;
    }
    
    return copy;
}


@end
