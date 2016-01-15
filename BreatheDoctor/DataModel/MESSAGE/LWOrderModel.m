//
//  LWOrderModel.m
//
//  Created by   on 16/1/6
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "LWOrderModel.h"


NSString *const kLWOrderModelQuantity = @"quantity";
NSString *const kLWOrderModelOrderId = @"orderId";
NSString *const kLWOrderModelFullName = @"fullName";
NSString *const kLWOrderModelCreateDt = @"createDt";


@interface LWOrderModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWOrderModel

@synthesize quantity = _quantity;
@synthesize orderId = _orderId;
@synthesize fullName = _fullName;
@synthesize createDt = _createDt;


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
            self.quantity = [[self objectOrNilForKey:kLWOrderModelQuantity fromDictionary:dict] doubleValue];
            self.orderId = [self objectOrNilForKey:kLWOrderModelOrderId fromDictionary:dict];
            self.fullName = [self objectOrNilForKey:kLWOrderModelFullName fromDictionary:dict];
            self.createDt = [self objectOrNilForKey:kLWOrderModelCreateDt fromDictionary:dict];
            self.patientName = [self objectOrNilForKey:@"patientName" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.quantity] forKey:kLWOrderModelQuantity];
    [mutableDict setValue:self.orderId forKey:kLWOrderModelOrderId];
    [mutableDict setValue:self.fullName forKey:kLWOrderModelFullName];
    [mutableDict setValue:self.createDt forKey:kLWOrderModelCreateDt];

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

    self.quantity = [aDecoder decodeDoubleForKey:kLWOrderModelQuantity];
    self.orderId = [aDecoder decodeObjectForKey:kLWOrderModelOrderId];
    self.fullName = [aDecoder decodeObjectForKey:kLWOrderModelFullName];
    self.createDt = [aDecoder decodeObjectForKey:kLWOrderModelCreateDt];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_quantity forKey:kLWOrderModelQuantity];
    [aCoder encodeObject:_orderId forKey:kLWOrderModelOrderId];
    [aCoder encodeObject:_fullName forKey:kLWOrderModelFullName];
    [aCoder encodeObject:_createDt forKey:kLWOrderModelCreateDt];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWOrderModel *copy = [[LWOrderModel alloc] init];
    
    if (copy) {

        copy.quantity = self.quantity;
        copy.orderId = [self.orderId copyWithZone:zone];
        copy.fullName = [self.fullName copyWithZone:zone];
        copy.createDt = [self.createDt copyWithZone:zone];
    }
    
    return copy;
}


@end
