//
//  KLBody.h
//
//  Created by   on 16/4/27
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface KLGoodsModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *productName;
@property (nonatomic, assign) double marketPrice;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic, assign) double originalPrice;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *productId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
