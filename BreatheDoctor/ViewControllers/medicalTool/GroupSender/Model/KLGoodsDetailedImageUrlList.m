//
//  KLGoodsDetailedImageUrlList.m
//
//  Created by   on 16/4/29
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "KLGoodsDetailedImageUrlList.h"


NSString *const kKLGoodsDetailedImageUrlListImageId = @"imageId";
NSString *const kKLGoodsDetailedImageUrlListType = @"type";
NSString *const kKLGoodsDetailedImageUrlListImageUrl = @"imageUrl";


@interface KLGoodsDetailedImageUrlList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation KLGoodsDetailedImageUrlList

@synthesize imageId = _imageId;
@synthesize type = _type;
@synthesize imageUrl = _imageUrl;


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
            self.imageId = [self objectOrNilForKey:kKLGoodsDetailedImageUrlListImageId fromDictionary:dict];
            self.type = [[self objectOrNilForKey:kKLGoodsDetailedImageUrlListType fromDictionary:dict] doubleValue];
            self.imageUrl = [self objectOrNilForKey:kKLGoodsDetailedImageUrlListImageUrl fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.imageId forKey:kKLGoodsDetailedImageUrlListImageId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kKLGoodsDetailedImageUrlListType];
    [mutableDict setValue:self.imageUrl forKey:kKLGoodsDetailedImageUrlListImageUrl];

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

    self.imageId = [aDecoder decodeObjectForKey:kKLGoodsDetailedImageUrlListImageId];
    self.type = [aDecoder decodeDoubleForKey:kKLGoodsDetailedImageUrlListType];
    self.imageUrl = [aDecoder decodeObjectForKey:kKLGoodsDetailedImageUrlListImageUrl];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_imageId forKey:kKLGoodsDetailedImageUrlListImageId];
    [aCoder encodeDouble:_type forKey:kKLGoodsDetailedImageUrlListType];
    [aCoder encodeObject:_imageUrl forKey:kKLGoodsDetailedImageUrlListImageUrl];
}

- (id)copyWithZone:(NSZone *)zone
{
    KLGoodsDetailedImageUrlList *copy = [[KLGoodsDetailedImageUrlList alloc] init];
    
    if (copy) {

        copy.imageId = [self.imageId copyWithZone:zone];
        copy.type = self.type;
        copy.imageUrl = [self.imageUrl copyWithZone:zone];
    }
    
    return copy;
}


@end
