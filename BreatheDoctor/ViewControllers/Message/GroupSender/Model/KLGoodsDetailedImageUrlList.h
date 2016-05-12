//
//  KLGoodsDetailedImageUrlList.h
//
//  Created by   on 16/4/29
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface KLGoodsDetailedImageUrlList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *imageId;
@property (nonatomic, assign) double type;
@property (nonatomic, strong) NSString *imageUrl;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
