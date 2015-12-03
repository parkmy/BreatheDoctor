//
//  LWAsthmaAssessLogBody.h
//
//  Created by   on 15/11/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LWAsthmaAssessLogBody : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double controlLevelY;
@property (nonatomic, strong) NSString *dateX;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
