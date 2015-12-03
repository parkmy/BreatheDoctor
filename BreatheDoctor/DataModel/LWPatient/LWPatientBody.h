//
//  LWPatientBody.h
//
//  Created by   on 15/11/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LWPatientPager;

@interface LWPatientBody : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) LWPatientPager *pager;
@property (nonatomic, strong) NSString *refreshTime;
@property (nonatomic, strong) NSArray *rows;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
