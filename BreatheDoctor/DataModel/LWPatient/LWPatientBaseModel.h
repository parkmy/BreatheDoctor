//
//  LWPatientBaseModel.h
//
//  Created by   on 15/11/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LWPatientBody, LWPatientResMsg;

@interface LWPatientBaseModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *resNum;
@property (nonatomic, strong) NSString *sessionId;
@property (nonatomic, strong) NSString *joinId;
@property (nonatomic, strong) NSString *valid;
@property (nonatomic, strong) NSString *reqNum;
@property (nonatomic, strong) LWPatientBody *body;
@property (nonatomic, strong) LWPatientResMsg *resMsg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
