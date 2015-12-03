//
//  LWChatBody.h
//
//  Created by   on 15/11/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LWChatPager;

@interface LWChatBody : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *refreshDate;
@property (nonatomic, strong) NSString *patientName;
@property (nonatomic, strong) NSArray *rows;
@property (nonatomic, strong) NSString *headImgUrl;
@property (nonatomic, strong) LWChatPager *pager;
@property (nonatomic, assign) double controlLevel;
@property (nonatomic, strong) NSString *returnDate;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
