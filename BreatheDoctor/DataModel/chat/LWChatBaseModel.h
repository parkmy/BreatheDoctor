//
//  LWChatBaseModel.h
//
//  Created by   on 15/11/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UUMessageFrame.h"

@class LWChatBody;

@interface LWChatBaseModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) LWChatBody *body;
@property (nonatomic, strong) NSString *reqNum;
@property (nonatomic, strong) NSString *sessionId;
@property (nonatomic, strong) NSString *valid;
@property (nonatomic, strong) NSString *resNum;
@property (nonatomic, strong) NSString *joinId;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

- (void)updateModel;
+ (NSMutableArray*)LoadSqliteDataWhere:(NSString *)wheres Offset:(NSInteger)offset count:(NSInteger)counts;
+ (void)minuteOffSetStart:(UUMessageFrame *)start end:(UUMessageFrame *)end;

@end
