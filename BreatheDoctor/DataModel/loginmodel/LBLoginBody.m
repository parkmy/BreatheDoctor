//
//  LBLoginBody.m
//
//  Created by   on 15/11/6
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LBLoginBody.h"


NSString *const kLBLoginBodyQrcodePath = @"qrcodePath";
NSString *const kLBLoginBodyPerName = @"perName";
NSString *const kLBLoginBodyPosition = @"position";
NSString *const kLBLoginBodyQrcodeId = @"qrcodeId";
NSString *const kLBLoginBodyPerRealPhotoS = @"perRealPhotoS";
NSString *const kLBLoginBodyPerRealPhoto = @"perRealPhoto";
NSString *const kLBLoginBodyHospitalNameText = @"hospitalNameText";
NSString *const kLBLoginBodyDoctorId = @"doctorId";
NSString *const kLBLoginBodyHospitalName = @"hospitalName";
NSString *const kLBLoginBodyDepartmentNameText = @"departmentNameText";
NSString *const kLBLoginBodyProvince = @"province";
NSString *const kLBLoginBodyBirthday = @"birthday";
NSString *const kLBLoginBodyCity = @"city";
NSString *const kLBLoginBodyPositionText = @"positionText";
NSString *const kLBLoginBodySignature = @"tags";
NSString *const kLBLoginBodyPerSpacil = @"perSpacil";
NSString *const kLBLoginBodyPerSex = @"perSex";
NSString *const kLBLoginBodyDepartmentName = @"departmentName";
NSString *const kLBLoginBodyCheckStatus = @"checkStatus";

@interface LBLoginBody ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LBLoginBody

@synthesize qrcodePath = _qrcodePath;
@synthesize perName = _perName;
@synthesize position = _position;
@synthesize qrcodeId = _qrcodeId;
@synthesize perRealPhotoS = _perRealPhotoS;
@synthesize perRealPhoto = _perRealPhoto;
@synthesize hospitalNameText = _hospitalNameText;
@synthesize doctorId = _doctorId;
@synthesize hospitalName = _hospitalName;
@synthesize departmentNameText = _departmentNameText;
@synthesize province = _province;
@synthesize birthday = _birthday;
@synthesize city = _city;
@synthesize positionText = _positionText;
@synthesize signature = _signature;
@synthesize perSpacil = _perSpacil;
@synthesize perSex = _perSex;
@synthesize departmentName = _departmentName;


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
            self.qrcodePath = [self objectOrNilForKey:kLBLoginBodyQrcodePath fromDictionary:dict];
            self.perName = [self objectOrNilForKey:kLBLoginBodyPerName fromDictionary:dict];
            self.position = [self objectOrNilForKey:kLBLoginBodyPosition fromDictionary:dict];
            self.qrcodeId = [self objectOrNilForKey:kLBLoginBodyQrcodeId fromDictionary:dict];
            self.perRealPhotoS = [self objectOrNilForKey:kLBLoginBodyPerRealPhotoS fromDictionary:dict];
            self.perRealPhoto = [self objectOrNilForKey:kLBLoginBodyPerRealPhoto fromDictionary:dict];
            self.hospitalNameText = [self objectOrNilForKey:kLBLoginBodyHospitalNameText fromDictionary:dict];
            self.doctorId = [self objectOrNilForKey:kLBLoginBodyDoctorId fromDictionary:dict];
            self.hospitalName = [self objectOrNilForKey:kLBLoginBodyHospitalName fromDictionary:dict];
            self.departmentNameText = [self objectOrNilForKey:kLBLoginBodyDepartmentNameText fromDictionary:dict];
            self.province = [self objectOrNilForKey:kLBLoginBodyProvince fromDictionary:dict];
            self.birthday = [self objectOrNilForKey:kLBLoginBodyBirthday fromDictionary:dict];
            self.city = [self objectOrNilForKey:kLBLoginBodyCity fromDictionary:dict];
            self.positionText = [self objectOrNilForKey:kLBLoginBodyPositionText fromDictionary:dict];
            self.signature = [self objectOrNilForKey:kLBLoginBodySignature fromDictionary:dict];
            self.perSpacil = [self objectOrNilForKey:kLBLoginBodyPerSpacil fromDictionary:dict];
            self.perSex = [[self objectOrNilForKey:kLBLoginBodyPerSex fromDictionary:dict] doubleValue];
            self.departmentName = [self objectOrNilForKey:kLBLoginBodyDepartmentName fromDictionary:dict];
            self.CheckStatus =  [self objectOrNilForKey:kLBLoginBodyCheckStatus fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.qrcodePath forKey:kLBLoginBodyQrcodePath];
    [mutableDict setValue:self.perName forKey:kLBLoginBodyPerName];
    [mutableDict setValue:self.position forKey:kLBLoginBodyPosition];
    [mutableDict setValue:self.qrcodeId forKey:kLBLoginBodyQrcodeId];
    [mutableDict setValue:self.perRealPhotoS forKey:kLBLoginBodyPerRealPhotoS];
    [mutableDict setValue:self.perRealPhoto forKey:kLBLoginBodyPerRealPhoto];
    [mutableDict setValue:self.hospitalNameText forKey:kLBLoginBodyHospitalNameText];
    [mutableDict setValue:self.doctorId forKey:kLBLoginBodyDoctorId];
    [mutableDict setValue:self.hospitalName forKey:kLBLoginBodyHospitalName];
    [mutableDict setValue:self.departmentNameText forKey:kLBLoginBodyDepartmentNameText];
    [mutableDict setValue:self.province forKey:kLBLoginBodyProvince];
    [mutableDict setValue:self.birthday forKey:kLBLoginBodyBirthday];
    [mutableDict setValue:self.city forKey:kLBLoginBodyCity];
    [mutableDict setValue:self.positionText forKey:kLBLoginBodyPositionText];
    [mutableDict setValue:self.signature forKey:kLBLoginBodySignature];
    [mutableDict setValue:self.perSpacil forKey:kLBLoginBodyPerSpacil];
    [mutableDict setValue:[NSNumber numberWithDouble:self.perSex] forKey:kLBLoginBodyPerSex];
    [mutableDict setValue:self.departmentName forKey:kLBLoginBodyDepartmentName];

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

    self.qrcodePath = [aDecoder decodeObjectForKey:kLBLoginBodyQrcodePath];
    self.perName = [aDecoder decodeObjectForKey:kLBLoginBodyPerName];
    self.position = [aDecoder decodeObjectForKey:kLBLoginBodyPosition];
    self.qrcodeId = [aDecoder decodeObjectForKey:kLBLoginBodyQrcodeId];
    self.perRealPhotoS = [aDecoder decodeObjectForKey:kLBLoginBodyPerRealPhotoS];
    self.perRealPhoto = [aDecoder decodeObjectForKey:kLBLoginBodyPerRealPhoto];
    self.hospitalNameText = [aDecoder decodeObjectForKey:kLBLoginBodyHospitalNameText];
    self.doctorId = [aDecoder decodeObjectForKey:kLBLoginBodyDoctorId];
    self.hospitalName = [aDecoder decodeObjectForKey:kLBLoginBodyHospitalName];
    self.departmentNameText = [aDecoder decodeObjectForKey:kLBLoginBodyDepartmentNameText];
    self.province = [aDecoder decodeObjectForKey:kLBLoginBodyProvince];
    self.birthday = [aDecoder decodeObjectForKey:kLBLoginBodyBirthday];
    self.city = [aDecoder decodeObjectForKey:kLBLoginBodyCity];
    self.positionText = [aDecoder decodeObjectForKey:kLBLoginBodyPositionText];
    self.signature = [aDecoder decodeObjectForKey:kLBLoginBodySignature];
    self.perSpacil = [aDecoder decodeObjectForKey:kLBLoginBodyPerSpacil];
    self.perSex = [aDecoder decodeDoubleForKey:kLBLoginBodyPerSex];
    self.departmentName = [aDecoder decodeObjectForKey:kLBLoginBodyDepartmentName];
    self.CheckStatus = [aDecoder decodeObjectForKey:kLBLoginBodyCheckStatus];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_qrcodePath forKey:kLBLoginBodyQrcodePath];
    [aCoder encodeObject:_perName forKey:kLBLoginBodyPerName];
    [aCoder encodeObject:_position forKey:kLBLoginBodyPosition];
    [aCoder encodeObject:_qrcodeId forKey:kLBLoginBodyQrcodeId];
    [aCoder encodeObject:_perRealPhotoS forKey:kLBLoginBodyPerRealPhotoS];
    [aCoder encodeObject:_perRealPhoto forKey:kLBLoginBodyPerRealPhoto];
    [aCoder encodeObject:_hospitalNameText forKey:kLBLoginBodyHospitalNameText];
    [aCoder encodeObject:_doctorId forKey:kLBLoginBodyDoctorId];
    [aCoder encodeObject:_hospitalName forKey:kLBLoginBodyHospitalName];
    [aCoder encodeObject:_departmentNameText forKey:kLBLoginBodyDepartmentNameText];
    [aCoder encodeObject:_province forKey:kLBLoginBodyProvince];
    [aCoder encodeObject:_birthday forKey:kLBLoginBodyBirthday];
    [aCoder encodeObject:_city forKey:kLBLoginBodyCity];
    [aCoder encodeObject:_positionText forKey:kLBLoginBodyPositionText];
    [aCoder encodeObject:_signature forKey:kLBLoginBodySignature];
    [aCoder encodeObject:_perSpacil forKey:kLBLoginBodyPerSpacil];
    [aCoder encodeDouble:_perSex forKey:kLBLoginBodyPerSex];
    [aCoder encodeObject:_departmentName forKey:kLBLoginBodyDepartmentName];
    [aCoder encodeObject:_CheckStatus forKey:kLBLoginBodyCheckStatus];
    
}

- (id)copyWithZone:(NSZone *)zone
{
    LBLoginBody *copy = [[LBLoginBody alloc] init];
    
    if (copy) {

        copy.qrcodePath = [self.qrcodePath copyWithZone:zone];
        copy.perName = [self.perName copyWithZone:zone];
        copy.position = [self.position copyWithZone:zone];
        copy.qrcodeId = [self.qrcodeId copyWithZone:zone];
        copy.perRealPhotoS = [self.perRealPhotoS copyWithZone:zone];
        copy.perRealPhoto = [self.perRealPhoto copyWithZone:zone];
        copy.hospitalNameText = [self.hospitalNameText copyWithZone:zone];
        copy.doctorId = [self.doctorId copyWithZone:zone];
        copy.hospitalName = [self.hospitalName copyWithZone:zone];
        copy.departmentNameText = [self.departmentNameText copyWithZone:zone];
        copy.province = [self.province copyWithZone:zone];
        copy.birthday = [self.birthday copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.positionText = [self.positionText copyWithZone:zone];
        copy.signature = [self.signature copyWithZone:zone];
        copy.perSpacil = [self.perSpacil copyWithZone:zone];
        copy.perSex = self.perSex;
        copy.departmentName = [self.departmentName copyWithZone:zone];
        copy.CheckStatus = [self.CheckStatus copyWithZone:zone];
    }
    
    return copy;
}


@end
