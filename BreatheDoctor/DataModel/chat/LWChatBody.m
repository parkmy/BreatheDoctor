//
//  LWChatBody.m
//
//  Created by   on 15/11/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LWChatBody.h"
#import "LWChatRows.h"
#import "LWChatPager.h"


NSString *const kLWChatBodyRemark = @"remark";
NSString *const kLWChatBodyRefreshDate = @"refreshDate";
NSString *const kLWChatBodyPatientName = @"patientName";
NSString *const kLWChatBodyRows = @"rows";
NSString *const kLWChatBodyHeadImgUrl = @"headImgUrl";
NSString *const kLWChatBodyPager = @"pager";
NSString *const kLWChatBodyControlLevel = @"controlLevel";
NSString *const kLWChatBodyReturnDate = @"returnDate";


@interface LWChatBody ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWChatBody

@synthesize remark = _remark;
@synthesize refreshDate = _refreshDate;
@synthesize patientName = _patientName;
@synthesize rows = _rows;
@synthesize headImgUrl = _headImgUrl;
@synthesize pager = _pager;
@synthesize controlLevel = _controlLevel;
@synthesize returnDate = _returnDate;


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
            self.remark = [self objectOrNilForKey:kLWChatBodyRemark fromDictionary:dict];
            self.refreshDate = [self objectOrNilForKey:kLWChatBodyRefreshDate fromDictionary:dict];
            self.patientName = [self objectOrNilForKey:kLWChatBodyPatientName fromDictionary:dict];
    NSObject *receivedLWChatRows = [dict objectForKey:kLWChatBodyRows];
    NSMutableArray *parsedLWChatRows = [NSMutableArray array];
    if ([receivedLWChatRows isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLWChatRows) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLWChatRows addObject:[LWChatRows modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLWChatRows isKindOfClass:[NSDictionary class]]) {
       [parsedLWChatRows addObject:[LWChatRows modelObjectWithDictionary:(NSDictionary *)receivedLWChatRows]];
    }

    self.rows = [NSArray arrayWithArray:parsedLWChatRows];
            self.headImgUrl = [self objectOrNilForKey:kLWChatBodyHeadImgUrl fromDictionary:dict];
            self.pager = [LWChatPager modelObjectWithDictionary:[dict objectForKey:kLWChatBodyPager]];
            self.controlLevel = [[self objectOrNilForKey:kLWChatBodyControlLevel fromDictionary:dict] doubleValue];
            self.returnDate = [self objectOrNilForKey:kLWChatBodyReturnDate fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.remark forKey:kLWChatBodyRemark];
    [mutableDict setValue:self.refreshDate forKey:kLWChatBodyRefreshDate];
    [mutableDict setValue:self.patientName forKey:kLWChatBodyPatientName];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRows] forKey:kLWChatBodyRows];
    [mutableDict setValue:self.headImgUrl forKey:kLWChatBodyHeadImgUrl];
    [mutableDict setValue:[self.pager dictionaryRepresentation] forKey:kLWChatBodyPager];
    [mutableDict setValue:[NSNumber numberWithDouble:self.controlLevel] forKey:kLWChatBodyControlLevel];
    [mutableDict setValue:self.returnDate forKey:kLWChatBodyReturnDate];

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

    self.remark = [aDecoder decodeObjectForKey:kLWChatBodyRemark];
    self.refreshDate = [aDecoder decodeObjectForKey:kLWChatBodyRefreshDate];
    self.patientName = [aDecoder decodeObjectForKey:kLWChatBodyPatientName];
    self.rows = [aDecoder decodeObjectForKey:kLWChatBodyRows];
    self.headImgUrl = [aDecoder decodeObjectForKey:kLWChatBodyHeadImgUrl];
    self.pager = [aDecoder decodeObjectForKey:kLWChatBodyPager];
    self.controlLevel = [aDecoder decodeDoubleForKey:kLWChatBodyControlLevel];
    self.returnDate = [aDecoder decodeObjectForKey:kLWChatBodyReturnDate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_remark forKey:kLWChatBodyRemark];
    [aCoder encodeObject:_refreshDate forKey:kLWChatBodyRefreshDate];
    [aCoder encodeObject:_patientName forKey:kLWChatBodyPatientName];
    [aCoder encodeObject:_rows forKey:kLWChatBodyRows];
    [aCoder encodeObject:_headImgUrl forKey:kLWChatBodyHeadImgUrl];
    [aCoder encodeObject:_pager forKey:kLWChatBodyPager];
    [aCoder encodeDouble:_controlLevel forKey:kLWChatBodyControlLevel];
    [aCoder encodeObject:_returnDate forKey:kLWChatBodyReturnDate];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWChatBody *copy = [[LWChatBody alloc] init];
    
    if (copy) {

        copy.remark = [self.remark copyWithZone:zone];
        copy.refreshDate = [self.refreshDate copyWithZone:zone];
        copy.patientName = [self.patientName copyWithZone:zone];
        copy.rows = [self.rows copyWithZone:zone];
        copy.headImgUrl = [self.headImgUrl copyWithZone:zone];
        copy.pager = [self.pager copyWithZone:zone];
        copy.controlLevel = self.controlLevel;
        copy.returnDate = [self.returnDate copyWithZone:zone];
    }
    
    return copy;
}


@end
