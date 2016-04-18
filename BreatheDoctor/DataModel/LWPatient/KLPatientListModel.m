//
//  KLPatientListModel.m
//  BreatheDoctor
//
//  Created by comv on 16/4/14.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLPatientListModel.h"
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

@implementation KLPatientListModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    
    if ([super init])
    {
     
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

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}
@end
