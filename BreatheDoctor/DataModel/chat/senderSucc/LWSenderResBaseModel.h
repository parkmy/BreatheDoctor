//
//  LWSenderResBaseModel.h
//
//  Created by   on 15/11/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LWSenderResBody;

@interface LWSenderResBaseModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) LWSenderResBody *body;
@property (nonatomic, strong) NSString *joinId;
@property (nonatomic, strong) NSString *sessionId;
@property (nonatomic, strong) NSString *valid;
@property (nonatomic, strong) NSString *resNum;
@property (nonatomic, strong) NSString *reqNum;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
