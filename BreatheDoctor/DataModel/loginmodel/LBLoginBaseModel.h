//
//  LBLoginBaseModel.h
//
//  Created by   on 15/11/6
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LBLoginBody;

@interface LBLoginBaseModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) LBLoginBody *body;
@property (nonatomic, strong) NSString *reqNum;
@property (nonatomic, strong) NSString *sessionId;
@property (nonatomic, strong) NSString *valid;
@property (nonatomic, strong) NSString *joinId;
@property (nonatomic, strong) NSString *resNum;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
