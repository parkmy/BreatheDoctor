//
//  LWMainMessageBaseModel.h
//
//  Created by   on 15/11/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LWMainBody;

@interface LWMainMessageBaseModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *resNum;
@property (nonatomic, strong) NSString *sessionId;
@property (nonatomic, strong) NSString *joinId;
@property (nonatomic, strong) NSString *valid;
@property (nonatomic, strong) NSString *reqNum;
@property (nonatomic, strong) LWMainBody *body;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
