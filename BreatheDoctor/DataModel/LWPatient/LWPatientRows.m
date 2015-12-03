//
//  LWPatientRows.m
//
//  Created by   on 15/11/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LWPatientRows.h"
#import "NSString+Pinyin.h"

NSString *const kLWPatientRowsIsConfirm = @"isConfirm";
NSString *const kLWPatientRowsInsertDt = @"insertDt";
NSString *const kLWPatientRowsSex = @"sex";
NSString *const kLWPatientRowsDoctorId = @"doctorId";
NSString *const kLWPatientRowsModifyDt = @"modifyDt";
NSString *const kLWPatientRowsPatientName = @"patientName";
NSString *const kLWPatientRowsPatientPhone = @"patientPhone";
NSString *const kLWPatientRowsRemark = @"remark";
NSString *const kLWPatientRowsControlLevel = @"controlLevel";
NSString *const kLWPatientRowsIsValid = @"isValid";
NSString *const kLWPatientRowsSid = @"sid";
NSString *const kLWPatientRowsGroupId = @"groupId";
NSString *const kLWPatientRowsPatientId = @"patientId";
NSString *const kLWPatientRowsHeadImgUrl = @"headImgUrl";


@interface LWPatientRows ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWPatientRows

@synthesize isConfirm = _isConfirm;
@synthesize insertDt = _insertDt;
@synthesize sex = _sex;
@synthesize doctorId = _doctorId;
@synthesize modifyDt = _modifyDt;
@synthesize patientName = _patientName;
@synthesize patientPhone = _patientPhone;
@synthesize remark = _remark;
@synthesize controlLevel = _controlLevel;
@synthesize isValid = _isValid;
@synthesize sid = _sid;
@synthesize groupId = _groupId;
@synthesize patientId = _patientId;
@synthesize headImgUrl = _headImgUrl;


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
            self.isConfirm = [[self objectOrNilForKey:kLWPatientRowsIsConfirm fromDictionary:dict] doubleValue];
            self.insertDt = [self objectOrNilForKey:kLWPatientRowsInsertDt fromDictionary:dict];
            self.sex = [[self objectOrNilForKey:kLWPatientRowsSex fromDictionary:dict] doubleValue];
            self.doctorId = [self objectOrNilForKey:kLWPatientRowsDoctorId fromDictionary:dict];
            self.modifyDt = [self objectOrNilForKey:kLWPatientRowsModifyDt fromDictionary:dict];
            self.patientName = [self objectOrNilForKey:kLWPatientRowsPatientName fromDictionary:dict];
            self.patientPhone = [[self objectOrNilForKey:kLWPatientRowsPatientPhone fromDictionary:dict] doubleValue];
            self.remark = [self objectOrNilForKey:kLWPatientRowsRemark fromDictionary:dict];
            self.controlLevel = [[self objectOrNilForKey:kLWPatientRowsControlLevel fromDictionary:dict] doubleValue];
            self.isValid = [[self objectOrNilForKey:kLWPatientRowsIsValid fromDictionary:dict] doubleValue];
            self.sid = [self objectOrNilForKey:kLWPatientRowsSid fromDictionary:dict];
            self.groupId = [self objectOrNilForKey:kLWPatientRowsGroupId fromDictionary:dict];
            self.patientId = [self objectOrNilForKey:kLWPatientRowsPatientId fromDictionary:dict];
            self.headImgUrl = [self objectOrNilForKey:kLWPatientRowsHeadImgUrl fromDictionary:dict];
        
        if (self.patientName) {
            if ([self.patientName pinyinInitialsArray].count > 0) {
                self.PinYin = [(NSString *)[[self.patientName pinyinInitialsArray] objectAtIndex:0] uppercaseString];
            }
            self.qPingying = [self.patientName pinyinWithoutBlank];
        }
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isConfirm] forKey:kLWPatientRowsIsConfirm];
    [mutableDict setValue:self.insertDt forKey:kLWPatientRowsInsertDt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sex] forKey:kLWPatientRowsSex];
    [mutableDict setValue:self.doctorId forKey:kLWPatientRowsDoctorId];
    [mutableDict setValue:self.modifyDt forKey:kLWPatientRowsModifyDt];
    [mutableDict setValue:self.patientName forKey:kLWPatientRowsPatientName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.patientPhone] forKey:kLWPatientRowsPatientPhone];
    [mutableDict setValue:self.remark forKey:kLWPatientRowsRemark];
    [mutableDict setValue:[NSNumber numberWithDouble:self.controlLevel] forKey:kLWPatientRowsControlLevel];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isValid] forKey:kLWPatientRowsIsValid];
    [mutableDict setValue:self.sid forKey:kLWPatientRowsSid];
    [mutableDict setValue:self.groupId forKey:kLWPatientRowsGroupId];
    [mutableDict setValue:self.patientId forKey:kLWPatientRowsPatientId];
    [mutableDict setValue:self.headImgUrl forKey:kLWPatientRowsHeadImgUrl];

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

    self.isConfirm = [aDecoder decodeDoubleForKey:kLWPatientRowsIsConfirm];
    self.insertDt = [aDecoder decodeObjectForKey:kLWPatientRowsInsertDt];
    self.sex = [aDecoder decodeDoubleForKey:kLWPatientRowsSex];
    self.doctorId = [aDecoder decodeObjectForKey:kLWPatientRowsDoctorId];
    self.modifyDt = [aDecoder decodeObjectForKey:kLWPatientRowsModifyDt];
    self.patientName = [aDecoder decodeObjectForKey:kLWPatientRowsPatientName];
    self.patientPhone = [aDecoder decodeDoubleForKey:kLWPatientRowsPatientPhone];
    self.remark = [aDecoder decodeObjectForKey:kLWPatientRowsRemark];
    self.controlLevel = [aDecoder decodeDoubleForKey:kLWPatientRowsControlLevel];
    self.isValid = [aDecoder decodeDoubleForKey:kLWPatientRowsIsValid];
    self.sid = [aDecoder decodeObjectForKey:kLWPatientRowsSid];
    self.groupId = [aDecoder decodeObjectForKey:kLWPatientRowsGroupId];
    self.patientId = [aDecoder decodeObjectForKey:kLWPatientRowsPatientId];
    self.headImgUrl = [aDecoder decodeObjectForKey:kLWPatientRowsHeadImgUrl];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_isConfirm forKey:kLWPatientRowsIsConfirm];
    [aCoder encodeObject:_insertDt forKey:kLWPatientRowsInsertDt];
    [aCoder encodeDouble:_sex forKey:kLWPatientRowsSex];
    [aCoder encodeObject:_doctorId forKey:kLWPatientRowsDoctorId];
    [aCoder encodeObject:_modifyDt forKey:kLWPatientRowsModifyDt];
    [aCoder encodeObject:_patientName forKey:kLWPatientRowsPatientName];
    [aCoder encodeDouble:_patientPhone forKey:kLWPatientRowsPatientPhone];
    [aCoder encodeObject:_remark forKey:kLWPatientRowsRemark];
    [aCoder encodeDouble:_controlLevel forKey:kLWPatientRowsControlLevel];
    [aCoder encodeDouble:_isValid forKey:kLWPatientRowsIsValid];
    [aCoder encodeObject:_sid forKey:kLWPatientRowsSid];
    [aCoder encodeObject:_groupId forKey:kLWPatientRowsGroupId];
    [aCoder encodeObject:_patientId forKey:kLWPatientRowsPatientId];
    [aCoder encodeObject:_headImgUrl forKey:kLWPatientRowsHeadImgUrl];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWPatientRows *copy = [[LWPatientRows alloc] init];
    
    if (copy) {

        copy.isConfirm = self.isConfirm;
        copy.insertDt = [self.insertDt copyWithZone:zone];
        copy.sex = self.sex;
        copy.doctorId = [self.doctorId copyWithZone:zone];
        copy.modifyDt = [self.modifyDt copyWithZone:zone];
        copy.patientName = [self.patientName copyWithZone:zone];
        copy.patientPhone = self.patientPhone;
        copy.remark = [self.remark copyWithZone:zone];
        copy.controlLevel = self.controlLevel;
        copy.isValid = self.isValid;
        copy.sid = [self.sid copyWithZone:zone];
        copy.groupId = [self.groupId copyWithZone:zone];
        copy.patientId = [self.patientId copyWithZone:zone];
        copy.headImgUrl = [self.headImgUrl copyWithZone:zone];
    }
    
    return copy;
}


@end
