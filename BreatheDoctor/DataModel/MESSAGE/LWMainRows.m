//
//  LWMainRows.m
//
//  Created by   on 15/11/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LWMainRows.h"


NSString *const kLWMainRowsInsertDt = @"insertDt";
NSString *const kLWMainRowsCount = @"count";
NSString *const kLWMainRowsIsDispose = @"isDispose";
NSString *const kLWMainRowsDoctorId = @"doctorId";
NSString *const kLWMainRowsMsgType = @"msgType";
NSString *const kLWMainRowsMsgContent = @"msgContent";
NSString *const kLWMainRowsPatientName = @"patientName";
NSString *const kLWMainRowsRemark = @"remark";
NSString *const kLWMainRowsSid = @"sid";
NSString *const kLWMainRowsMemberId = @"memberId";
NSString *const kLWMainRowsHeadImageUrl = @"headImageUrl";
NSString *const kLWMainRowsDataStr = @"dataStr";
NSString *const kLWMainRowsIsValid = @"isValid";
NSString *const kLWMainRowsOwnerType = @"ownerType";


@interface LWMainRows ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWMainRows

@synthesize insertDt = _insertDt;
@synthesize count = _count;
@synthesize isDispose = _isDispose;
@synthesize doctorId = _doctorId;
@synthesize msgType = _msgType;
@synthesize msgContent = _msgContent;
@synthesize patientName = _patientName;
@synthesize remark = _remark;
@synthesize sid = _sid;
@synthesize memberId = _memberId;
@synthesize headImageUrl = _headImageUrl;
@synthesize dataStr = _dataStr;
@synthesize isValid = _isValid;
@synthesize ownerType = _ownerType;


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
            self.insertDt = [self objectOrNilForKey:kLWMainRowsInsertDt fromDictionary:dict];
            self.count = [[self objectOrNilForKey:kLWMainRowsCount fromDictionary:dict] doubleValue];
            self.isDispose = [[self objectOrNilForKey:kLWMainRowsIsDispose fromDictionary:dict] doubleValue];
            self.doctorId = [self objectOrNilForKey:kLWMainRowsDoctorId fromDictionary:dict];
            self.msgType = [[self objectOrNilForKey:kLWMainRowsMsgType fromDictionary:dict] doubleValue];
            self.msgContent = [self objectOrNilForKey:kLWMainRowsMsgContent fromDictionary:dict];
            self.patientName = [self objectOrNilForKey:kLWMainRowsPatientName fromDictionary:dict];
            self.remark = [self objectOrNilForKey:kLWMainRowsRemark fromDictionary:dict];
            self.sid = [self objectOrNilForKey:kLWMainRowsSid fromDictionary:dict];
            self.memberId = [self objectOrNilForKey:kLWMainRowsMemberId fromDictionary:dict];
            self.headImageUrl = [self objectOrNilForKey:kLWMainRowsHeadImageUrl fromDictionary:dict];
            self.dataStr = [self objectOrNilForKey:kLWMainRowsDataStr fromDictionary:dict];
            self.isValid = [[self objectOrNilForKey:kLWMainRowsIsValid fromDictionary:dict] doubleValue];
            self.ownerType = [[self objectOrNilForKey:kLWMainRowsOwnerType fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.insertDt forKey:kLWMainRowsInsertDt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.count] forKey:kLWMainRowsCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isDispose] forKey:kLWMainRowsIsDispose];
    [mutableDict setValue:self.doctorId forKey:kLWMainRowsDoctorId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.msgType] forKey:kLWMainRowsMsgType];
    [mutableDict setValue:self.msgContent forKey:kLWMainRowsMsgContent];
    [mutableDict setValue:self.patientName forKey:kLWMainRowsPatientName];
    [mutableDict setValue:self.remark forKey:kLWMainRowsRemark];
    [mutableDict setValue:self.sid forKey:kLWMainRowsSid];
    [mutableDict setValue:self.memberId forKey:kLWMainRowsMemberId];
    [mutableDict setValue:self.headImageUrl forKey:kLWMainRowsHeadImageUrl];
    [mutableDict setValue:self.dataStr forKey:kLWMainRowsDataStr];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isValid] forKey:kLWMainRowsIsValid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.ownerType] forKey:kLWMainRowsOwnerType];

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

    self.insertDt = [aDecoder decodeObjectForKey:kLWMainRowsInsertDt];
    self.count = [aDecoder decodeDoubleForKey:kLWMainRowsCount];
    self.isDispose = [aDecoder decodeDoubleForKey:kLWMainRowsIsDispose];
    self.doctorId = [aDecoder decodeObjectForKey:kLWMainRowsDoctorId];
    self.msgType = [aDecoder decodeDoubleForKey:kLWMainRowsMsgType];
    self.msgContent = [aDecoder decodeObjectForKey:kLWMainRowsMsgContent];
    self.patientName = [aDecoder decodeObjectForKey:kLWMainRowsPatientName];
    self.remark = [aDecoder decodeObjectForKey:kLWMainRowsRemark];
    self.sid = [aDecoder decodeObjectForKey:kLWMainRowsSid];
    self.memberId = [aDecoder decodeObjectForKey:kLWMainRowsMemberId];
    self.headImageUrl = [aDecoder decodeObjectForKey:kLWMainRowsHeadImageUrl];
    self.dataStr = [aDecoder decodeObjectForKey:kLWMainRowsDataStr];
    self.isValid = [aDecoder decodeDoubleForKey:kLWMainRowsIsValid];
    self.ownerType = [aDecoder decodeDoubleForKey:kLWMainRowsOwnerType];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_insertDt forKey:kLWMainRowsInsertDt];
    [aCoder encodeDouble:_count forKey:kLWMainRowsCount];
    [aCoder encodeDouble:_isDispose forKey:kLWMainRowsIsDispose];
    [aCoder encodeObject:_doctorId forKey:kLWMainRowsDoctorId];
    [aCoder encodeDouble:_msgType forKey:kLWMainRowsMsgType];
    [aCoder encodeObject:_msgContent forKey:kLWMainRowsMsgContent];
    [aCoder encodeObject:_patientName forKey:kLWMainRowsPatientName];
    [aCoder encodeObject:_remark forKey:kLWMainRowsRemark];
    [aCoder encodeObject:_sid forKey:kLWMainRowsSid];
    [aCoder encodeObject:_memberId forKey:kLWMainRowsMemberId];
    [aCoder encodeObject:_headImageUrl forKey:kLWMainRowsHeadImageUrl];
    [aCoder encodeObject:_dataStr forKey:kLWMainRowsDataStr];
    [aCoder encodeDouble:_isValid forKey:kLWMainRowsIsValid];
    [aCoder encodeDouble:_ownerType forKey:kLWMainRowsOwnerType];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWMainRows *copy = [[LWMainRows alloc] init];
    
    if (copy) {

        copy.insertDt = [self.insertDt copyWithZone:zone];
        copy.count = self.count;
        copy.isDispose = self.isDispose;
        copy.doctorId = [self.doctorId copyWithZone:zone];
        copy.msgType = self.msgType;
        copy.msgContent = [self.msgContent copyWithZone:zone];
        copy.patientName = [self.patientName copyWithZone:zone];
        copy.remark = [self.remark copyWithZone:zone];
        copy.sid = [self.sid copyWithZone:zone];
        copy.memberId = [self.memberId copyWithZone:zone];
        copy.headImageUrl = [self.headImageUrl copyWithZone:zone];
        copy.dataStr = [self.dataStr copyWithZone:zone];
        copy.isValid = self.isValid;
        copy.ownerType = self.ownerType;
    }
    
    return copy;
}


@end
