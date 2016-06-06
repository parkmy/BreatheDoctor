//
//  KLGoodsDetailedModel.h
//
//  Created by   on 16/4/29
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface KLGoodsDetailedModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *specification;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic, assign) double marketPrice;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, assign) double isRecommend;
@property (nonatomic, strong) NSString *servicePhone;
@property (nonatomic, assign) double originalPrice;
@property (nonatomic, strong) NSArray *imageUrlList;
@property (nonatomic, strong) NSString *tagName;
@property (nonatomic, assign) double isCarousel;
@property (nonatomic, strong) NSString *serviceQq;

@property (nonatomic, assign) double  productFreight;
@property (nonatomic, assign) double  productInventoryCount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
