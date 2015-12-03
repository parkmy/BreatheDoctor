//
//  LWAsthmaAssessLogModel.h
//
//  Created by   on 15/11/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LWAsthmaAssessLogModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *body;
@property (nonatomic, strong) NSString *joinId;
@property (nonatomic, strong) NSString *sessionId;
@property (nonatomic, strong) NSString *valid;
@property (nonatomic, strong) NSString *resNum;
@property (nonatomic, strong) NSString *reqNum;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
