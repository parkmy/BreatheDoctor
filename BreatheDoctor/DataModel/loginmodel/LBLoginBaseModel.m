//
//  LBLoginBaseModel.m
//
//  Created by   on 15/11/6
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LBLoginBaseModel.h"
#import "LBLoginBody.h"


NSString *const kLBLoginBaseModelBody = @"body";
NSString *const kLBLoginBaseModelReqNum = @"req_num";
NSString *const kLBLoginBaseModelSessionId = @"sessionId";
NSString *const kLBLoginBaseModelValid = @"valid";
NSString *const kLBLoginBaseModelJoinId = @"join_id";
NSString *const kLBLoginBaseModelResNum = @"res_num";


@interface LBLoginBaseModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LBLoginBaseModel

@synthesize body = _body;
@synthesize reqNum = _reqNum;
@synthesize sessionId = _sessionId;
@synthesize valid = _valid;
@synthesize joinId = _joinId;
@synthesize resNum = _resNum;


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
            self.body = [LBLoginBody modelObjectWithDictionary:[dict objectForKey:kLBLoginBaseModelBody]];
            self.reqNum = [self objectOrNilForKey:kLBLoginBaseModelReqNum fromDictionary:dict];
            self.sessionId = [self objectOrNilForKey:kLBLoginBaseModelSessionId fromDictionary:dict];
            self.valid = [self objectOrNilForKey:kLBLoginBaseModelValid fromDictionary:dict];
            self.joinId = [self objectOrNilForKey:kLBLoginBaseModelJoinId fromDictionary:dict];
            self.resNum = [self objectOrNilForKey:kLBLoginBaseModelResNum fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.body dictionaryRepresentation] forKey:kLBLoginBaseModelBody];
    [mutableDict setValue:self.reqNum forKey:kLBLoginBaseModelReqNum];
    [mutableDict setValue:self.sessionId forKey:kLBLoginBaseModelSessionId];
    [mutableDict setValue:self.valid forKey:kLBLoginBaseModelValid];
    [mutableDict setValue:self.joinId forKey:kLBLoginBaseModelJoinId];
    [mutableDict setValue:self.resNum forKey:kLBLoginBaseModelResNum];

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

    self.body = [aDecoder decodeObjectForKey:kLBLoginBaseModelBody];
    self.reqNum = [aDecoder decodeObjectForKey:kLBLoginBaseModelReqNum];
    self.sessionId = [aDecoder decodeObjectForKey:kLBLoginBaseModelSessionId];
    self.valid = [aDecoder decodeObjectForKey:kLBLoginBaseModelValid];
    self.joinId = [aDecoder decodeObjectForKey:kLBLoginBaseModelJoinId];
    self.resNum = [aDecoder decodeObjectForKey:kLBLoginBaseModelResNum];
    self.loginMiMa = [aDecoder decodeObjectForKey:@"loginMiMa"];
    self.loginZhangHao = [aDecoder decodeObjectForKey:@"loginZhangHao"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_body forKey:kLBLoginBaseModelBody];
    [aCoder encodeObject:_reqNum forKey:kLBLoginBaseModelReqNum];
    [aCoder encodeObject:_sessionId forKey:kLBLoginBaseModelSessionId];
    [aCoder encodeObject:_valid forKey:kLBLoginBaseModelValid];
    [aCoder encodeObject:_joinId forKey:kLBLoginBaseModelJoinId];
    [aCoder encodeObject:_resNum forKey:kLBLoginBaseModelResNum];
    [aCoder encodeObject:_loginMiMa forKey:@"loginMiMa"];
    [aCoder encodeObject:_loginZhangHao forKey:@"loginZhangHao"];

}

- (id)copyWithZone:(NSZone *)zone
{
    LBLoginBaseModel *copy = [[LBLoginBaseModel alloc] init];
    
    if (copy) {

        copy.body = [self.body copyWithZone:zone];
        copy.reqNum = [self.reqNum copyWithZone:zone];
        copy.sessionId = [self.sessionId copyWithZone:zone];
        copy.valid = [self.valid copyWithZone:zone];
        copy.joinId = [self.joinId copyWithZone:zone];
        copy.resNum = [self.resNum copyWithZone:zone];
    }
    
    return copy;
}

+ (BOOL)isCheckStatusTheIsShow:(BOOL)show{

    //开通服务请拨打客服电话 4007-038-039 ，或联系身边工作人员
    LBLoginBaseModel *model = [[CODataCacheManager shareInstance] userModel];
    
    BOOL isCheck = [model.body.CheckStatus boolValue];
    if (!isCheck&&show) {
        SHOWAlertView(@"", @"开通服务请拨打客服电话 4007-038-039 ，或联系身边工作人员");
    }
    return isCheck;
}


+ (void)updateUserModel{

    LBLoginBaseModel *model = [[CODataCacheManager shareInstance] userModel];
    NSLog(@"%@",model.body.CheckStatus);
    if (!model.body.CheckStatus) {
        
        model.body.CheckStatus = @"1";
        [CODataCacheManager shareInstance].userModel = model;
        [[CODataCacheManager shareInstance] saveUserModel];
    }
}

@end
