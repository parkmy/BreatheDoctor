//
//  LWChatBaseModel.m
//
//  Created by   on 15/11/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LWChatBaseModel.h"
#import "LWChatBody.h"
#import "LWChatModel.h"
#import "NSDate+Utils.h"

NSString *const kLWChatBaseModelBody = @"body";
NSString *const kLWChatBaseModelReqNum = @"req_num";
NSString *const kLWChatBaseModelSessionId = @"sessionId";
NSString *const kLWChatBaseModelValid = @"valid";
NSString *const kLWChatBaseModelResNum = @"res_num";
NSString *const kLWChatBaseModelJoinId = @"join_id";


@interface LWChatBaseModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWChatBaseModel

@synthesize body = _body;
@synthesize reqNum = _reqNum;
@synthesize sessionId = _sessionId;
@synthesize valid = _valid;
@synthesize resNum = _resNum;
@synthesize joinId = _joinId;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.body = [LWChatBody modelObjectWithDictionary:[dict objectForKey:kLWChatBaseModelBody]];
            self.reqNum = [self objectOrNilForKey:kLWChatBaseModelReqNum fromDictionary:dict];
            self.sessionId = [self objectOrNilForKey:kLWChatBaseModelSessionId fromDictionary:dict];
            self.valid = [self objectOrNilForKey:kLWChatBaseModelValid fromDictionary:dict];
            self.resNum = [self objectOrNilForKey:kLWChatBaseModelResNum fromDictionary:dict];
            self.joinId = [self objectOrNilForKey:kLWChatBaseModelJoinId fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.body dictionaryRepresentation] forKey:kLWChatBaseModelBody];
    [mutableDict setValue:self.reqNum forKey:kLWChatBaseModelReqNum];
    [mutableDict setValue:self.sessionId forKey:kLWChatBaseModelSessionId];
    [mutableDict setValue:self.valid forKey:kLWChatBaseModelValid];
    [mutableDict setValue:self.resNum forKey:kLWChatBaseModelResNum];
    [mutableDict setValue:self.joinId forKey:kLWChatBaseModelJoinId];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.body = [aDecoder decodeObjectForKey:kLWChatBaseModelBody];
    self.reqNum = [aDecoder decodeObjectForKey:kLWChatBaseModelReqNum];
    self.sessionId = [aDecoder decodeObjectForKey:kLWChatBaseModelSessionId];
    self.valid = [aDecoder decodeObjectForKey:kLWChatBaseModelValid];
    self.resNum = [aDecoder decodeObjectForKey:kLWChatBaseModelResNum];
    self.joinId = [aDecoder decodeObjectForKey:kLWChatBaseModelJoinId];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_body forKey:kLWChatBaseModelBody];
    [aCoder encodeObject:_reqNum forKey:kLWChatBaseModelReqNum];
    [aCoder encodeObject:_sessionId forKey:kLWChatBaseModelSessionId];
    [aCoder encodeObject:_valid forKey:kLWChatBaseModelValid];
    [aCoder encodeObject:_resNum forKey:kLWChatBaseModelResNum];
    [aCoder encodeObject:_joinId forKey:kLWChatBaseModelJoinId];

}

- (id)copyWithZone:(NSZone *)zone
{
    LWChatBaseModel *copy = [[LWChatBaseModel alloc] init];
    
    if (copy) {

        copy.body = [self.body copyWithZone:zone];
        copy.reqNum = [self.reqNum copyWithZone:zone];
        copy.sessionId = [self.sessionId copyWithZone:zone];
        copy.valid = [self.valid copyWithZone:zone];
        copy.resNum = [self.resNum copyWithZone:zone];
        copy.joinId = [self.joinId copyWithZone:zone];
    }
    
    return copy;
}


+ (NSMutableArray*)LoadSqliteDataWhere:(NSString *)wheres Offset:(NSInteger)offset count:(NSInteger)counts
{
    
    NSMutableArray* array = [[LKDBHelper getUsingLKDBHelper] search:[LWChatModel class] where:wheres orderBy:@"insertDt DESC" offset:0 count:counts];
    
    NSMutableArray *arrays = [NSMutableArray array];
    
    @autoreleasepool {
        
        for (LWChatModel *model in array) {
            UUMessageFrame *modelFram = [[UUMessageFrame alloc] init];
            modelFram.model = model;
            [arrays addObject:modelFram];
        }
        
    }
    
    
    return arrays;
}

+ (void)minuteOffSetArray:(NSMutableArray *)array
{

    @autoreleasepool {
        for (int i = 0; i < array.count; i++)
        {
            UUMessageFrame *model1 = array[i];
            UUMessageFrame *model2;
            if ((i+1) < array.count)
            {
                model2 = array[i+1];
            }
            if (model2)
            {
                [[self class] minuteOffSetStart:model1 end:model2];
            }
        }
    }
}

+ (void)minuteOffSetStart:(UUMessageFrame *)start end:(UUMessageFrame *)end
{
    if (!end) {
        start.showTime = YES;
        return;
    }
    
    NSDate *startDate = [NSDate dateFromString:start.model.insertDt withFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *endDate = [NSDate dateFromString:end.model.insertDt withFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //这个是相隔的秒数
    NSTimeInterval timeInterval = [startDate timeIntervalSinceDate:endDate];
    
    //相距5分钟显示时间Label
    if (fabs (timeInterval) > 5*60) {
        start.showTime = YES;
    }else{
        start.showTime = NO;
    }
    
}

- (void)updateModel
{
    @autoreleasepool {
        
        for (LWChatRows *row in self.body.rows) {
            LWChatModel *model = [LWChatModel modelWith:self WithRow:row];
            
            NSString * wheres = [NSString stringWithFormat:@"memberId = %@ and sid = %@",model.memberId,model.sid];
            
            if ([[LKDBHelper getUsingLKDBHelper] rowCount:[LWChatModel class] where:wheres]>0) {
                [[LKDBHelper getUsingLKDBHelper] updateToDB:model where:wheres];
            }else
            {
                [[LKDBHelper getUsingLKDBHelper] insertToDB:model];
            }
        }
    }
}
@end
