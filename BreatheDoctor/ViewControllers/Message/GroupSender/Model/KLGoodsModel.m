//
//  KLBody.m
//
//  Created by   on 16/4/27
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "KLGoodsModel.h"


NSString *const kKLBodyProductName = @"productName";
NSString *const kKLBodyMarketPrice = @"marketPrice";
NSString *const kKLBodyTags = @"tags";
NSString *const kKLBodyOriginalPrice = @"originalPrice";
NSString *const kKLBodyImageUrl = @"imageUrl";
NSString *const kKLBodyProductId = @"productId";


@interface KLGoodsModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation KLGoodsModel

@synthesize productName = _productName;
@synthesize marketPrice = _marketPrice;
@synthesize tags = _tags;
@synthesize originalPrice = _originalPrice;
@synthesize imageUrl = _imageUrl;
@synthesize productId = _productId;


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
            self.productName = [self objectOrNilForKey:kKLBodyProductName fromDictionary:dict];
            self.marketPrice = [[self objectOrNilForKey:kKLBodyMarketPrice fromDictionary:dict] doubleValue];
            self.tags = [self objectOrNilForKey:kKLBodyTags fromDictionary:dict];
            self.originalPrice = [[self objectOrNilForKey:kKLBodyOriginalPrice fromDictionary:dict] doubleValue];
            self.imageUrl = [self objectOrNilForKey:kKLBodyImageUrl fromDictionary:dict];
            self.productId = [self objectOrNilForKey:kKLBodyProductId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.productName forKey:kKLBodyProductName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.marketPrice] forKey:kKLBodyMarketPrice];
    [mutableDict setValue:self.tags forKey:kKLBodyTags];
    [mutableDict setValue:[NSNumber numberWithDouble:self.originalPrice] forKey:kKLBodyOriginalPrice];
    [mutableDict setValue:self.imageUrl forKey:kKLBodyImageUrl];
    [mutableDict setValue:self.productId forKey:kKLBodyProductId];

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

    self.productName = [aDecoder decodeObjectForKey:kKLBodyProductName];
    self.marketPrice = [aDecoder decodeDoubleForKey:kKLBodyMarketPrice];
    self.tags = [aDecoder decodeObjectForKey:kKLBodyTags];
    self.originalPrice = [aDecoder decodeDoubleForKey:kKLBodyOriginalPrice];
    self.imageUrl = [aDecoder decodeObjectForKey:kKLBodyImageUrl];
    self.productId = [aDecoder decodeObjectForKey:kKLBodyProductId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_productName forKey:kKLBodyProductName];
    [aCoder encodeDouble:_marketPrice forKey:kKLBodyMarketPrice];
    [aCoder encodeObject:_tags forKey:kKLBodyTags];
    [aCoder encodeDouble:_originalPrice forKey:kKLBodyOriginalPrice];
    [aCoder encodeObject:_imageUrl forKey:kKLBodyImageUrl];
    [aCoder encodeObject:_productId forKey:kKLBodyProductId];
}

- (id)copyWithZone:(NSZone *)zone
{
    KLGoodsModel *copy = [[KLGoodsModel alloc] init];
    
    if (copy) {

        copy.productName = [self.productName copyWithZone:zone];
        copy.marketPrice = self.marketPrice;
        copy.tags = [self.tags copyWithZone:zone];
        copy.originalPrice = self.originalPrice;
        copy.imageUrl = [self.imageUrl copyWithZone:zone];
        copy.productId = [self.productId copyWithZone:zone];
    }
    
    return copy;
}


@end
