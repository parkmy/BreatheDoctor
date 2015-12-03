//
//  LWSenderResBody.m
//
//  Created by   on 15/11/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LWSenderResBody.h"


NSString *const kLWSenderResBodyDoctorName = @"doctorName";
NSString *const kLWSenderResBodyShowType = @"showType";
NSString *const kLWSenderResBodyInsertDt = @"insertDt";
NSString *const kLWSenderResBodyIsCount = @"isCount";
NSString *const kLWSenderResBodyMsgType = @"msgType";
NSString *const kLWSenderResBodyDoctorDepart = @"doctorDepart";
NSString *const kLWSenderResBodyUserMsg = @"userMsg";
NSString *const kLWSenderResBodyPatientName = @"patientName";
NSString *const kLWSenderResBodyIsShow = @"isShow";
NSString *const kLWSenderResBodyRelateDoctorId = @"relateDoctorId";
NSString *const kLWSenderResBodyIsDispose = @"isDispose";
NSString *const kLWSenderResBodyChannel = @"channel";
NSString *const kLWSenderResBodyCount = @"count";
NSString *const kLWSenderResBodyModifyDt = @"modifyDt";
NSString *const kLWSenderResBodyOrigin = @"origin";
NSString *const kLWSenderResBodyIsValid = @"isValid";
NSString *const kLWSenderResBodyDoctorId = @"doctorId";
NSString *const kLWSenderResBodySid = @"sid";
NSString *const kLWSenderResBodyPlatform = @"platform";
NSString *const kLWSenderResBodyMsgContent = @"msgContent";
NSString *const kLWSenderResBodyMsgTypeStr = @"msgTypeStr";
NSString *const kLWSenderResBodyDoctorMsg = @"doctorMsg";
NSString *const kLWSenderResBodyOwnerType = @"ownerType";
NSString *const kLWSenderResBodyTrueDoctorId = @"trueDoctorId";
NSString *const kLWSenderResBodyTrueDoctorName = @"trueDoctorName";
NSString *const kLWSenderResBodyMemberId = @"memberId";
NSString *const kLWSenderResBodyHeadImageUrl = @"headImageUrl";
NSString *const kLWSenderResBodyRemark = @"remark";
NSString *const kLWSenderResBodyForeignId = @"foreignId";
NSString *const kLWSenderResBodyDataStr = @"dataStr";
NSString *const kLWSenderResBodyDataStruct = @"dataStruct";


@interface LWSenderResBody ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWSenderResBody

@synthesize doctorName = _doctorName;
@synthesize showType = _showType;
@synthesize insertDt = _insertDt;
@synthesize isCount = _isCount;
@synthesize msgType = _msgType;
@synthesize doctorDepart = _doctorDepart;
@synthesize userMsg = _userMsg;
@synthesize patientName = _patientName;
@synthesize isShow = _isShow;
@synthesize relateDoctorId = _relateDoctorId;
@synthesize isDispose = _isDispose;
@synthesize channel = _channel;
@synthesize count = _count;
@synthesize modifyDt = _modifyDt;
@synthesize origin = _origin;
@synthesize isValid = _isValid;
@synthesize doctorId = _doctorId;
@synthesize sid = _sid;
@synthesize platform = _platform;
@synthesize msgContent = _msgContent;
@synthesize msgTypeStr = _msgTypeStr;
@synthesize doctorMsg = _doctorMsg;
@synthesize ownerType = _ownerType;
@synthesize trueDoctorId = _trueDoctorId;
@synthesize trueDoctorName = _trueDoctorName;
@synthesize memberId = _memberId;
@synthesize headImageUrl = _headImageUrl;
@synthesize remark = _remark;
@synthesize foreignId = _foreignId;
@synthesize dataStr = _dataStr;
@synthesize dataStruct = _dataStruct;


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
            self.doctorName = [self objectOrNilForKey:kLWSenderResBodyDoctorName fromDictionary:dict];
            self.showType = [[self objectOrNilForKey:kLWSenderResBodyShowType fromDictionary:dict] doubleValue];
            self.insertDt = [self objectOrNilForKey:kLWSenderResBodyInsertDt fromDictionary:dict];
            self.isCount = [[self objectOrNilForKey:kLWSenderResBodyIsCount fromDictionary:dict] doubleValue];
            self.msgType = [[self objectOrNilForKey:kLWSenderResBodyMsgType fromDictionary:dict] doubleValue];
            self.doctorDepart = [self objectOrNilForKey:kLWSenderResBodyDoctorDepart fromDictionary:dict];
            self.userMsg = [self objectOrNilForKey:kLWSenderResBodyUserMsg fromDictionary:dict];
            self.patientName = [self objectOrNilForKey:kLWSenderResBodyPatientName fromDictionary:dict];
            self.isShow = [[self objectOrNilForKey:kLWSenderResBodyIsShow fromDictionary:dict] doubleValue];
            self.relateDoctorId = [self objectOrNilForKey:kLWSenderResBodyRelateDoctorId fromDictionary:dict];
            self.isDispose = [[self objectOrNilForKey:kLWSenderResBodyIsDispose fromDictionary:dict] doubleValue];
            self.channel = [[self objectOrNilForKey:kLWSenderResBodyChannel fromDictionary:dict] doubleValue];
            self.count = [[self objectOrNilForKey:kLWSenderResBodyCount fromDictionary:dict] doubleValue];
            self.modifyDt = [self objectOrNilForKey:kLWSenderResBodyModifyDt fromDictionary:dict];
            self.origin = [[self objectOrNilForKey:kLWSenderResBodyOrigin fromDictionary:dict] doubleValue];
            self.isValid = [[self objectOrNilForKey:kLWSenderResBodyIsValid fromDictionary:dict] doubleValue];
            self.doctorId = [self objectOrNilForKey:kLWSenderResBodyDoctorId fromDictionary:dict];
            self.sid = [self objectOrNilForKey:kLWSenderResBodySid fromDictionary:dict];
            self.platform = [[self objectOrNilForKey:kLWSenderResBodyPlatform fromDictionary:dict] doubleValue];
            self.msgContent = [self objectOrNilForKey:kLWSenderResBodyMsgContent fromDictionary:dict];
            self.msgTypeStr = [self objectOrNilForKey:kLWSenderResBodyMsgTypeStr fromDictionary:dict];
            self.doctorMsg = [self objectOrNilForKey:kLWSenderResBodyDoctorMsg fromDictionary:dict];
            self.ownerType = [[self objectOrNilForKey:kLWSenderResBodyOwnerType fromDictionary:dict] doubleValue];
            self.trueDoctorId = [self objectOrNilForKey:kLWSenderResBodyTrueDoctorId fromDictionary:dict];
            self.trueDoctorName = [self objectOrNilForKey:kLWSenderResBodyTrueDoctorName fromDictionary:dict];
            self.memberId = [self objectOrNilForKey:kLWSenderResBodyMemberId fromDictionary:dict];
            self.headImageUrl = [self objectOrNilForKey:kLWSenderResBodyHeadImageUrl fromDictionary:dict];
            self.remark = [self objectOrNilForKey:kLWSenderResBodyRemark fromDictionary:dict];
            self.foreignId = [self objectOrNilForKey:kLWSenderResBodyForeignId fromDictionary:dict];
            self.dataStr = [self objectOrNilForKey:kLWSenderResBodyDataStr fromDictionary:dict];
            self.dataStruct = [self objectOrNilForKey:kLWSenderResBodyDataStruct fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.doctorName forKey:kLWSenderResBodyDoctorName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.showType] forKey:kLWSenderResBodyShowType];
    [mutableDict setValue:self.insertDt forKey:kLWSenderResBodyInsertDt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isCount] forKey:kLWSenderResBodyIsCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.msgType] forKey:kLWSenderResBodyMsgType];
    [mutableDict setValue:self.doctorDepart forKey:kLWSenderResBodyDoctorDepart];
    [mutableDict setValue:self.userMsg forKey:kLWSenderResBodyUserMsg];
    [mutableDict setValue:self.patientName forKey:kLWSenderResBodyPatientName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isShow] forKey:kLWSenderResBodyIsShow];
    [mutableDict setValue:self.relateDoctorId forKey:kLWSenderResBodyRelateDoctorId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isDispose] forKey:kLWSenderResBodyIsDispose];
    [mutableDict setValue:[NSNumber numberWithDouble:self.channel] forKey:kLWSenderResBodyChannel];
    [mutableDict setValue:[NSNumber numberWithDouble:self.count] forKey:kLWSenderResBodyCount];
    [mutableDict setValue:self.modifyDt forKey:kLWSenderResBodyModifyDt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.origin] forKey:kLWSenderResBodyOrigin];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isValid] forKey:kLWSenderResBodyIsValid];
    [mutableDict setValue:self.doctorId forKey:kLWSenderResBodyDoctorId];
    [mutableDict setValue:self.sid forKey:kLWSenderResBodySid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.platform] forKey:kLWSenderResBodyPlatform];
    [mutableDict setValue:self.msgContent forKey:kLWSenderResBodyMsgContent];
    [mutableDict setValue:self.msgTypeStr forKey:kLWSenderResBodyMsgTypeStr];
    [mutableDict setValue:self.doctorMsg forKey:kLWSenderResBodyDoctorMsg];
    [mutableDict setValue:[NSNumber numberWithDouble:self.ownerType] forKey:kLWSenderResBodyOwnerType];
    [mutableDict setValue:self.trueDoctorId forKey:kLWSenderResBodyTrueDoctorId];
    [mutableDict setValue:self.trueDoctorName forKey:kLWSenderResBodyTrueDoctorName];
    [mutableDict setValue:self.memberId forKey:kLWSenderResBodyMemberId];
    [mutableDict setValue:self.headImageUrl forKey:kLWSenderResBodyHeadImageUrl];
    [mutableDict setValue:self.remark forKey:kLWSenderResBodyRemark];
    [mutableDict setValue:self.foreignId forKey:kLWSenderResBodyForeignId];
    [mutableDict setValue:self.dataStr forKey:kLWSenderResBodyDataStr];
    [mutableDict setValue:self.dataStruct forKey:kLWSenderResBodyDataStruct];

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

    self.doctorName = [aDecoder decodeObjectForKey:kLWSenderResBodyDoctorName];
    self.showType = [aDecoder decodeDoubleForKey:kLWSenderResBodyShowType];
    self.insertDt = [aDecoder decodeObjectForKey:kLWSenderResBodyInsertDt];
    self.isCount = [aDecoder decodeDoubleForKey:kLWSenderResBodyIsCount];
    self.msgType = [aDecoder decodeDoubleForKey:kLWSenderResBodyMsgType];
    self.doctorDepart = [aDecoder decodeObjectForKey:kLWSenderResBodyDoctorDepart];
    self.userMsg = [aDecoder decodeObjectForKey:kLWSenderResBodyUserMsg];
    self.patientName = [aDecoder decodeObjectForKey:kLWSenderResBodyPatientName];
    self.isShow = [aDecoder decodeDoubleForKey:kLWSenderResBodyIsShow];
    self.relateDoctorId = [aDecoder decodeObjectForKey:kLWSenderResBodyRelateDoctorId];
    self.isDispose = [aDecoder decodeDoubleForKey:kLWSenderResBodyIsDispose];
    self.channel = [aDecoder decodeDoubleForKey:kLWSenderResBodyChannel];
    self.count = [aDecoder decodeDoubleForKey:kLWSenderResBodyCount];
    self.modifyDt = [aDecoder decodeObjectForKey:kLWSenderResBodyModifyDt];
    self.origin = [aDecoder decodeDoubleForKey:kLWSenderResBodyOrigin];
    self.isValid = [aDecoder decodeDoubleForKey:kLWSenderResBodyIsValid];
    self.doctorId = [aDecoder decodeObjectForKey:kLWSenderResBodyDoctorId];
    self.sid = [aDecoder decodeObjectForKey:kLWSenderResBodySid];
    self.platform = [aDecoder decodeDoubleForKey:kLWSenderResBodyPlatform];
    self.msgContent = [aDecoder decodeObjectForKey:kLWSenderResBodyMsgContent];
    self.msgTypeStr = [aDecoder decodeObjectForKey:kLWSenderResBodyMsgTypeStr];
    self.doctorMsg = [aDecoder decodeObjectForKey:kLWSenderResBodyDoctorMsg];
    self.ownerType = [aDecoder decodeDoubleForKey:kLWSenderResBodyOwnerType];
    self.trueDoctorId = [aDecoder decodeObjectForKey:kLWSenderResBodyTrueDoctorId];
    self.trueDoctorName = [aDecoder decodeObjectForKey:kLWSenderResBodyTrueDoctorName];
    self.memberId = [aDecoder decodeObjectForKey:kLWSenderResBodyMemberId];
    self.headImageUrl = [aDecoder decodeObjectForKey:kLWSenderResBodyHeadImageUrl];
    self.remark = [aDecoder decodeObjectForKey:kLWSenderResBodyRemark];
    self.foreignId = [aDecoder decodeObjectForKey:kLWSenderResBodyForeignId];
    self.dataStr = [aDecoder decodeObjectForKey:kLWSenderResBodyDataStr];
    self.dataStruct = [aDecoder decodeObjectForKey:kLWSenderResBodyDataStruct];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_doctorName forKey:kLWSenderResBodyDoctorName];
    [aCoder encodeDouble:_showType forKey:kLWSenderResBodyShowType];
    [aCoder encodeObject:_insertDt forKey:kLWSenderResBodyInsertDt];
    [aCoder encodeDouble:_isCount forKey:kLWSenderResBodyIsCount];
    [aCoder encodeDouble:_msgType forKey:kLWSenderResBodyMsgType];
    [aCoder encodeObject:_doctorDepart forKey:kLWSenderResBodyDoctorDepart];
    [aCoder encodeObject:_userMsg forKey:kLWSenderResBodyUserMsg];
    [aCoder encodeObject:_patientName forKey:kLWSenderResBodyPatientName];
    [aCoder encodeDouble:_isShow forKey:kLWSenderResBodyIsShow];
    [aCoder encodeObject:_relateDoctorId forKey:kLWSenderResBodyRelateDoctorId];
    [aCoder encodeDouble:_isDispose forKey:kLWSenderResBodyIsDispose];
    [aCoder encodeDouble:_channel forKey:kLWSenderResBodyChannel];
    [aCoder encodeDouble:_count forKey:kLWSenderResBodyCount];
    [aCoder encodeObject:_modifyDt forKey:kLWSenderResBodyModifyDt];
    [aCoder encodeDouble:_origin forKey:kLWSenderResBodyOrigin];
    [aCoder encodeDouble:_isValid forKey:kLWSenderResBodyIsValid];
    [aCoder encodeObject:_doctorId forKey:kLWSenderResBodyDoctorId];
    [aCoder encodeObject:_sid forKey:kLWSenderResBodySid];
    [aCoder encodeDouble:_platform forKey:kLWSenderResBodyPlatform];
    [aCoder encodeObject:_msgContent forKey:kLWSenderResBodyMsgContent];
    [aCoder encodeObject:_msgTypeStr forKey:kLWSenderResBodyMsgTypeStr];
    [aCoder encodeObject:_doctorMsg forKey:kLWSenderResBodyDoctorMsg];
    [aCoder encodeDouble:_ownerType forKey:kLWSenderResBodyOwnerType];
    [aCoder encodeObject:_trueDoctorId forKey:kLWSenderResBodyTrueDoctorId];
    [aCoder encodeObject:_trueDoctorName forKey:kLWSenderResBodyTrueDoctorName];
    [aCoder encodeObject:_memberId forKey:kLWSenderResBodyMemberId];
    [aCoder encodeObject:_headImageUrl forKey:kLWSenderResBodyHeadImageUrl];
    [aCoder encodeObject:_remark forKey:kLWSenderResBodyRemark];
    [aCoder encodeObject:_foreignId forKey:kLWSenderResBodyForeignId];
    [aCoder encodeObject:_dataStr forKey:kLWSenderResBodyDataStr];
    [aCoder encodeObject:_dataStruct forKey:kLWSenderResBodyDataStruct];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWSenderResBody *copy = [[LWSenderResBody alloc] init];
    
    if (copy) {

        copy.doctorName = [self.doctorName copyWithZone:zone];
        copy.showType = self.showType;
        copy.insertDt = [self.insertDt copyWithZone:zone];
        copy.isCount = self.isCount;
        copy.msgType = self.msgType;
        copy.doctorDepart = [self.doctorDepart copyWithZone:zone];
        copy.userMsg = [self.userMsg copyWithZone:zone];
        copy.patientName = [self.patientName copyWithZone:zone];
        copy.isShow = self.isShow;
        copy.relateDoctorId = [self.relateDoctorId copyWithZone:zone];
        copy.isDispose = self.isDispose;
        copy.channel = self.channel;
        copy.count = self.count;
        copy.modifyDt = [self.modifyDt copyWithZone:zone];
        copy.origin = self.origin;
        copy.isValid = self.isValid;
        copy.doctorId = [self.doctorId copyWithZone:zone];
        copy.sid = [self.sid copyWithZone:zone];
        copy.platform = self.platform;
        copy.msgContent = [self.msgContent copyWithZone:zone];
        copy.msgTypeStr = [self.msgTypeStr copyWithZone:zone];
        copy.doctorMsg = [self.doctorMsg copyWithZone:zone];
        copy.ownerType = self.ownerType;
        copy.trueDoctorId = [self.trueDoctorId copyWithZone:zone];
        copy.trueDoctorName = [self.trueDoctorName copyWithZone:zone];
        copy.memberId = [self.memberId copyWithZone:zone];
        copy.headImageUrl = [self.headImageUrl copyWithZone:zone];
        copy.remark = [self.remark copyWithZone:zone];
        copy.foreignId = [self.foreignId copyWithZone:zone];
        copy.dataStr = [self.dataStr copyWithZone:zone];
//        copy.dataStruct = [self.dataStruct copyWithZone:zone];
    }
    
    return copy;
}


@end
