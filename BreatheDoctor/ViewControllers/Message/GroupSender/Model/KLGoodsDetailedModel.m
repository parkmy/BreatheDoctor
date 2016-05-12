//
//  KLGoodsDetailedModel.m
//
//  Created by   on 16/4/29
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "KLGoodsDetailedModel.h"
#import "KLGoodsDetailedImageUrlList.h"


NSString *const kKLGoodsDetailedModelProductId = @"productId";
NSString *const kKLGoodsDetailedModelSpecification = @"specification";
NSString *const kKLGoodsDetailedModelProductName = @"productName";
NSString *const kKLGoodsDetailedModelTags = @"tags";
NSString *const kKLGoodsDetailedModelMarketPrice = @"marketPrice";
NSString *const kKLGoodsDetailedModelImageUrl = @"imageUrl";
NSString *const kKLGoodsDetailedModelIsRecommend = @"isRecommend";
NSString *const kKLGoodsDetailedModelServicePhone = @"servicePhone";
NSString *const kKLGoodsDetailedModelOriginalPrice = @"originalPrice";
NSString *const kKLGoodsDetailedModelImageUrlList = @"imageUrlList";
NSString *const kKLGoodsDetailedModelTagName = @"tagName";
NSString *const kKLGoodsDetailedModelIsCarousel = @"isCarousel";
NSString *const kKLGoodsDetailedModelServiceQq = @"serviceQq";


@interface KLGoodsDetailedModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation KLGoodsDetailedModel

@synthesize productId = _productId;
@synthesize specification = _specification;
@synthesize productName = _productName;
@synthesize tags = _tags;
@synthesize marketPrice = _marketPrice;
@synthesize imageUrl = _imageUrl;
@synthesize isRecommend = _isRecommend;
@synthesize servicePhone = _servicePhone;
@synthesize originalPrice = _originalPrice;
@synthesize imageUrlList = _imageUrlList;
@synthesize tagName = _tagName;
@synthesize isCarousel = _isCarousel;
@synthesize serviceQq = _serviceQq;


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
        
        self.productFreight = [[dict objectForKey:@"freight"] doubleValue];
        self.productInventoryCount = [[dict objectForKey:@"inventory"] doubleValue];
        
        self.productId = [self objectOrNilForKey:kKLGoodsDetailedModelProductId fromDictionary:dict];
        self.specification = [self objectOrNilForKey:kKLGoodsDetailedModelSpecification fromDictionary:dict];
        self.productName = [self objectOrNilForKey:kKLGoodsDetailedModelProductName fromDictionary:dict];
        self.tags = [self objectOrNilForKey:kKLGoodsDetailedModelTags fromDictionary:dict];
        self.marketPrice = [[self objectOrNilForKey:kKLGoodsDetailedModelMarketPrice fromDictionary:dict] doubleValue];
        self.imageUrl = [self objectOrNilForKey:kKLGoodsDetailedModelImageUrl fromDictionary:dict];
        self.isRecommend = [[self objectOrNilForKey:kKLGoodsDetailedModelIsRecommend fromDictionary:dict] doubleValue];
        self.servicePhone = [self objectOrNilForKey:kKLGoodsDetailedModelServicePhone fromDictionary:dict];
        self.originalPrice = [[self objectOrNilForKey:kKLGoodsDetailedModelOriginalPrice fromDictionary:dict] doubleValue];
        NSObject *receivedKLGoodsDetailedImageUrlList = [dict objectForKey:kKLGoodsDetailedModelImageUrlList];
        NSMutableArray *parsedKLGoodsDetailedImageUrlList = [NSMutableArray array];
        if ([receivedKLGoodsDetailedImageUrlList isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedKLGoodsDetailedImageUrlList) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedKLGoodsDetailedImageUrlList addObject:[KLGoodsDetailedImageUrlList modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedKLGoodsDetailedImageUrlList isKindOfClass:[NSDictionary class]]) {
            [parsedKLGoodsDetailedImageUrlList addObject:[KLGoodsDetailedImageUrlList modelObjectWithDictionary:(NSDictionary *)receivedKLGoodsDetailedImageUrlList]];
        }
        
        self.imageUrlList = [NSArray arrayWithArray:parsedKLGoodsDetailedImageUrlList];
        self.tagName = [self objectOrNilForKey:kKLGoodsDetailedModelTagName fromDictionary:dict];
        self.isCarousel = [[self objectOrNilForKey:kKLGoodsDetailedModelIsCarousel fromDictionary:dict] doubleValue];
        self.serviceQq = [self objectOrNilForKey:kKLGoodsDetailedModelServiceQq fromDictionary:dict];
        
    }
    
    
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.productId forKey:kKLGoodsDetailedModelProductId];
    [mutableDict setValue:self.specification forKey:kKLGoodsDetailedModelSpecification];
    [mutableDict setValue:self.productName forKey:kKLGoodsDetailedModelProductName];
    [mutableDict setValue:self.tags forKey:kKLGoodsDetailedModelTags];
    [mutableDict setValue:[NSNumber numberWithDouble:self.marketPrice] forKey:kKLGoodsDetailedModelMarketPrice];
    [mutableDict setValue:self.imageUrl forKey:kKLGoodsDetailedModelImageUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isRecommend] forKey:kKLGoodsDetailedModelIsRecommend];
    [mutableDict setValue:self.servicePhone forKey:kKLGoodsDetailedModelServicePhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.originalPrice] forKey:kKLGoodsDetailedModelOriginalPrice];
    NSMutableArray *tempArrayForImageUrlList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.imageUrlList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForImageUrlList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForImageUrlList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForImageUrlList] forKey:kKLGoodsDetailedModelImageUrlList];
    [mutableDict setValue:self.tagName forKey:kKLGoodsDetailedModelTagName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isCarousel] forKey:kKLGoodsDetailedModelIsCarousel];
    [mutableDict setValue:self.serviceQq forKey:kKLGoodsDetailedModelServiceQq];
    
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
    
    self.productId = [aDecoder decodeObjectForKey:kKLGoodsDetailedModelProductId];
    self.specification = [aDecoder decodeObjectForKey:kKLGoodsDetailedModelSpecification];
    self.productName = [aDecoder decodeObjectForKey:kKLGoodsDetailedModelProductName];
    self.tags = [aDecoder decodeObjectForKey:kKLGoodsDetailedModelTags];
    self.marketPrice = [aDecoder decodeDoubleForKey:kKLGoodsDetailedModelMarketPrice];
    self.imageUrl = [aDecoder decodeObjectForKey:kKLGoodsDetailedModelImageUrl];
    self.isRecommend = [aDecoder decodeDoubleForKey:kKLGoodsDetailedModelIsRecommend];
    self.servicePhone = [aDecoder decodeObjectForKey:kKLGoodsDetailedModelServicePhone];
    self.originalPrice = [aDecoder decodeDoubleForKey:kKLGoodsDetailedModelOriginalPrice];
    self.imageUrlList = [aDecoder decodeObjectForKey:kKLGoodsDetailedModelImageUrlList];
    self.tagName = [aDecoder decodeObjectForKey:kKLGoodsDetailedModelTagName];
    self.isCarousel = [aDecoder decodeDoubleForKey:kKLGoodsDetailedModelIsCarousel];
    self.serviceQq = [aDecoder decodeObjectForKey:kKLGoodsDetailedModelServiceQq];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_productId forKey:kKLGoodsDetailedModelProductId];
    [aCoder encodeObject:_specification forKey:kKLGoodsDetailedModelSpecification];
    [aCoder encodeObject:_productName forKey:kKLGoodsDetailedModelProductName];
    [aCoder encodeObject:_tags forKey:kKLGoodsDetailedModelTags];
    [aCoder encodeDouble:_marketPrice forKey:kKLGoodsDetailedModelMarketPrice];
    [aCoder encodeObject:_imageUrl forKey:kKLGoodsDetailedModelImageUrl];
    [aCoder encodeDouble:_isRecommend forKey:kKLGoodsDetailedModelIsRecommend];
    [aCoder encodeObject:_servicePhone forKey:kKLGoodsDetailedModelServicePhone];
    [aCoder encodeDouble:_originalPrice forKey:kKLGoodsDetailedModelOriginalPrice];
    [aCoder encodeObject:_imageUrlList forKey:kKLGoodsDetailedModelImageUrlList];
    [aCoder encodeObject:_tagName forKey:kKLGoodsDetailedModelTagName];
    [aCoder encodeDouble:_isCarousel forKey:kKLGoodsDetailedModelIsCarousel];
    [aCoder encodeObject:_serviceQq forKey:kKLGoodsDetailedModelServiceQq];
}

- (id)copyWithZone:(NSZone *)zone
{
    KLGoodsDetailedModel *copy = [[KLGoodsDetailedModel alloc] init];
    
    if (copy) {
        
        copy.productId = [self.productId copyWithZone:zone];
        copy.specification = [self.specification copyWithZone:zone];
        copy.productName = [self.productName copyWithZone:zone];
        copy.tags = [self.tags copyWithZone:zone];
        copy.marketPrice = self.marketPrice;
        copy.imageUrl = [self.imageUrl copyWithZone:zone];
        copy.isRecommend = self.isRecommend;
        copy.servicePhone = [self.servicePhone copyWithZone:zone];
        copy.originalPrice = self.originalPrice;
        copy.imageUrlList = [self.imageUrlList copyWithZone:zone];
        copy.tagName = [self.tagName copyWithZone:zone];
        copy.isCarousel = self.isCarousel;
        copy.serviceQq = [self.serviceQq copyWithZone:zone];
    }
    
    return copy;
}


@end
