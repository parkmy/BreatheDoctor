//
//  LWTheFromMrows.h
//
//  Created by   on 16/1/13
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LWTheFromMrows : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *arows;
@property (nonatomic, strong) NSString *sectiontitle;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
