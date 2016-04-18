//
//  LWMainRows.h
//
//  Created by   on 15/11/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LWMainRows : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *insertDt;
@property (nonatomic, assign) double count;
@property (nonatomic, assign) double isDispose;
@property (nonatomic, strong) NSString *doctorId;
@property (nonatomic, assign) double msgType;
@property (nonatomic, strong) NSString *msgContent;
@property (nonatomic, strong) NSString *patientName;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *sid;
@property (nonatomic, strong) NSString *memberId;
@property (nonatomic, strong) NSString *headImageUrl;
@property (nonatomic, strong) NSString *dataStr;
@property (nonatomic, assign) double isValid;
@property (nonatomic, assign) double ownerType;
@property (nonatomic, strong) NSString *refreshTime;

@property (nonatomic, strong) NSMutableArray *requestArray;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
