//
//  LWPEFBody.h
//
//  Created by   on 15/11/25
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LWPEFBody : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *recordList;
@property (nonatomic, assign) double pefPredictedValue;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
