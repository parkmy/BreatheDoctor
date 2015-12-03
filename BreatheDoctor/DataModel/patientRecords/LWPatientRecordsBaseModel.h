//
//  LWPatientRecordsBaseModel.h
//
//  Created by   on 15/11/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LWPatientRecordsBody;

@interface LWPatientRecordsBaseModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) LWPatientRecordsBody *body;
@property (nonatomic, strong) NSString *joinId;
@property (nonatomic, strong) NSString *sessionId;
@property (nonatomic, strong) NSString *valid;
@property (nonatomic, strong) NSString *resNum;
@property (nonatomic, strong) NSString *reqNum;
@property (nonatomic, strong) NSString *paintentId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
