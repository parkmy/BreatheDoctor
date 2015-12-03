//
//  LWChatRows.m
//
//  Created by   on 15/11/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LWChatRows.h"
#import "LWChatDataStruct.h"


NSString *const kLWChatRowsTimeStamp = @"timeStamp";
NSString *const kLWChatRowsDataStruct = @"dataStruct";
NSString *const kLWChatRowsIsCount = @"isCount";
NSString *const kLWChatRowsInsertDt = @"insertDt";
NSString *const kLWChatRowsIsDispose = @"isDispose";
NSString *const kLWChatRowsModifyDt = @"modifyDt";
NSString *const kLWChatRowsMsgType = @"msgType";
NSString *const kLWChatRowsDoctorId = @"doctorId";
NSString *const kLWChatRowsMemberId = @"memberId";
NSString *const kLWChatRowsMsgContent = @"msgContent";
NSString *const kLWChatRowsSid = @"sid";
NSString *const kLWChatRowsIsValid = @"isValid";
NSString *const kLWChatRowsForeignId = @"foreignId";
NSString *const kLWChatRowsOwnerType = @"ownerType";


@interface LWChatRows ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWChatRows

@synthesize timeStamp = _timeStamp;
@synthesize dataStruct = _dataStruct;
@synthesize isCount = _isCount;
@synthesize insertDt = _insertDt;
@synthesize isDispose = _isDispose;
@synthesize modifyDt = _modifyDt;
@synthesize msgType = _msgType;
@synthesize doctorId = _doctorId;
@synthesize memberId = _memberId;
@synthesize msgContent = _msgContent;
@synthesize sid = _sid;
@synthesize isValid = _isValid;
@synthesize foreignId = _foreignId;
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
            self.timeStamp = [[self objectOrNilForKey:kLWChatRowsTimeStamp fromDictionary:dict] doubleValue];
            self.dataStruct = [LWChatDataStruct modelObjectWithDictionary:[dict objectForKey:kLWChatRowsDataStruct]];
            self.isCount = [[self objectOrNilForKey:kLWChatRowsIsCount fromDictionary:dict] doubleValue];
            self.insertDt = [self objectOrNilForKey:kLWChatRowsInsertDt fromDictionary:dict];
            self.isDispose = [[self objectOrNilForKey:kLWChatRowsIsDispose fromDictionary:dict] doubleValue];
            self.modifyDt = [self objectOrNilForKey:kLWChatRowsModifyDt fromDictionary:dict];
            self.msgType = [[self objectOrNilForKey:kLWChatRowsMsgType fromDictionary:dict] integerValue];
            self.doctorId = [self objectOrNilForKey:kLWChatRowsDoctorId fromDictionary:dict];
            self.memberId = [self objectOrNilForKey:kLWChatRowsMemberId fromDictionary:dict];
            self.msgContent = [self objectOrNilForKey:kLWChatRowsMsgContent fromDictionary:dict];
            self.sid = [self objectOrNilForKey:kLWChatRowsSid fromDictionary:dict];
            self.isValid = [[self objectOrNilForKey:kLWChatRowsIsValid fromDictionary:dict] doubleValue];
            self.foreignId = [self objectOrNilForKey:kLWChatRowsForeignId fromDictionary:dict];
        if ([[self objectOrNilForKey:kLWChatRowsOwnerType fromDictionary:dict] integerValue] == 1) {
            self.ownerType = NO;
        }else
        {
            self.ownerType = YES;

        }
        
        if (self.dataStruct.contentType == 1) { //文本
            self.chatCellType = WSChatCellType_Text;
        }else if (self.dataStruct.contentType == 2)//图片
        {
            self.chatCellType = WSChatCellType_Image;
        }else//语音
        {
            self.chatCellType = WSChatCellType_Audio;
        }
        self.chatMessageType = self.msgType;
        
        if (self.chatMessageType  == 1 || self.chatMessageType  == 2 || self.chatMessageType == 3) {
         
        }else
        {
           self.chatCellType = WSChatCellType_Card;
            self.height = 190;
        }
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.timeStamp] forKey:kLWChatRowsTimeStamp];
    [mutableDict setValue:[self.dataStruct dictionaryRepresentation] forKey:kLWChatRowsDataStruct];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isCount] forKey:kLWChatRowsIsCount];
    [mutableDict setValue:self.insertDt forKey:kLWChatRowsInsertDt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isDispose] forKey:kLWChatRowsIsDispose];
    [mutableDict setValue:self.modifyDt forKey:kLWChatRowsModifyDt];
    [mutableDict setValue:[NSNumber numberWithInteger:self.msgType] forKey:kLWChatRowsMsgType];
    [mutableDict setValue:self.doctorId forKey:kLWChatRowsDoctorId];
    [mutableDict setValue:self.memberId forKey:kLWChatRowsMemberId];
    [mutableDict setValue:self.msgContent forKey:kLWChatRowsMsgContent];
    [mutableDict setValue:self.sid forKey:kLWChatRowsSid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isValid] forKey:kLWChatRowsIsValid];
    [mutableDict setValue:self.foreignId forKey:kLWChatRowsForeignId];
    
    [mutableDict setValue:[NSNumber numberWithBool:self.ownerType] forKey:kLWChatRowsOwnerType];

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

    self.timeStamp = [aDecoder decodeDoubleForKey:kLWChatRowsTimeStamp];
    self.dataStruct = [aDecoder decodeObjectForKey:kLWChatRowsDataStruct];
    self.isCount = [aDecoder decodeDoubleForKey:kLWChatRowsIsCount];
    self.insertDt = [aDecoder decodeObjectForKey:kLWChatRowsInsertDt];
    self.isDispose = [aDecoder decodeDoubleForKey:kLWChatRowsIsDispose];
    self.modifyDt = [aDecoder decodeObjectForKey:kLWChatRowsModifyDt];
    self.msgType = [aDecoder decodeDoubleForKey:kLWChatRowsMsgType];
    self.doctorId = [aDecoder decodeObjectForKey:kLWChatRowsDoctorId];
    self.memberId = [aDecoder decodeObjectForKey:kLWChatRowsMemberId];
    self.msgContent = [aDecoder decodeObjectForKey:kLWChatRowsMsgContent];
    self.sid = [aDecoder decodeObjectForKey:kLWChatRowsSid];
    self.isValid = [aDecoder decodeDoubleForKey:kLWChatRowsIsValid];
    self.foreignId = [aDecoder decodeObjectForKey:kLWChatRowsForeignId];
    self.ownerType = [aDecoder decodeDoubleForKey:kLWChatRowsOwnerType];
    self.voiceFileName = [aDecoder decodeObjectForKey:@"fileNmae"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_timeStamp forKey:kLWChatRowsTimeStamp];
    [aCoder encodeObject:_dataStruct forKey:kLWChatRowsDataStruct];
    [aCoder encodeDouble:_isCount forKey:kLWChatRowsIsCount];
    [aCoder encodeObject:_insertDt forKey:kLWChatRowsInsertDt];
    [aCoder encodeDouble:_isDispose forKey:kLWChatRowsIsDispose];
    [aCoder encodeObject:_modifyDt forKey:kLWChatRowsModifyDt];
    [aCoder encodeDouble:_msgType forKey:kLWChatRowsMsgType];
    [aCoder encodeObject:_doctorId forKey:kLWChatRowsDoctorId];
    [aCoder encodeObject:_memberId forKey:kLWChatRowsMemberId];
    [aCoder encodeObject:_msgContent forKey:kLWChatRowsMsgContent];
    [aCoder encodeObject:_sid forKey:kLWChatRowsSid];
    [aCoder encodeDouble:_isValid forKey:kLWChatRowsIsValid];
    [aCoder encodeObject:_foreignId forKey:kLWChatRowsForeignId];
    [aCoder encodeObject:_voiceFileName forKey:@"fileNmae"];
    [aCoder encodeDouble:_ownerType forKey:kLWChatRowsOwnerType];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWChatRows *copy = [[LWChatRows alloc] init];
    
    if (copy) {

        copy.timeStamp = self.timeStamp;
        copy.dataStruct = [self.dataStruct copyWithZone:zone];
        copy.isCount = self.isCount;
        copy.insertDt = [self.insertDt copyWithZone:zone];
        copy.isDispose = self.isDispose;
        copy.modifyDt = [self.modifyDt copyWithZone:zone];
        copy.msgType = self.msgType;
        copy.doctorId = [self.doctorId copyWithZone:zone];
        copy.memberId = [self.memberId copyWithZone:zone];
        copy.msgContent = [self.msgContent copyWithZone:zone];
        copy.sid = [self.sid copyWithZone:zone];
        copy.isValid = self.isValid;
        copy.foreignId = [self.foreignId copyWithZone:zone];
        copy.voiceFileName = [self.voiceFileName copyWithZone:zone];

        copy.ownerType = self.ownerType;
    }
    
    return copy;
}


@end
