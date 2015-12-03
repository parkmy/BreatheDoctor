//
//  LWMainBody.h
//
//  Created by   on 15/11/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LWMainPager;

@interface LWMainBody : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) LWMainPager *pager;
@property (nonatomic, strong) NSString *refreshDate;
@property (nonatomic, strong) NSArray *rows;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
