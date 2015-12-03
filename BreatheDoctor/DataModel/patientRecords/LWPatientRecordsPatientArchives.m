//
//  LWPatientRecordsPatientArchives.m
//
//  Created by   on 15/11/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LWPatientRecordsPatientArchives.h"


NSString *const kLWPatientRecordsPatientArchivesAllergenTest = @"allergenTest";
NSString *const kLWPatientRecordsPatientArchivesAllergicHistory = @"allergicHistory";
NSString *const kLWPatientRecordsPatientArchivesSymptomFactor = @"symptomFactor";
NSString *const kLWPatientRecordsPatientArchivesPatientPhone = @"patientPhone";
NSString *const kLWPatientRecordsPatientArchivesRemark = @"remark";
NSString *const kLWPatientRecordsPatientArchivesPefPredictedValue = @"pefPredictedValue";
NSString *const kLWPatientRecordsPatientArchivesSyndrome = @"syndrome";
NSString *const kLWPatientRecordsPatientArchivesImageUrlList = @"imageUrlList";
NSString *const kLWPatientRecordsPatientArchivesResultImageUrlStr = @"resultImageUrlStr";
NSString *const kLWPatientRecordsPatientArchivesFinishQuestionnaire = @"finishQuestionnaire";
NSString *const kLWPatientRecordsPatientArchivesFvc = @"fvc";
NSString *const kLWPatientRecordsPatientArchivesSymptomFactorRemark = @"symptomFactorRemark";
NSString *const kLWPatientRecordsPatientArchivesFeno = @"feno";
NSString *const kLWPatientRecordsPatientArchivesPatientName = @"patientName";
NSString *const kLWPatientRecordsPatientArchivesFamilyHistoryParent = @"familyHistoryParent";
NSString *const kLWPatientRecordsPatientArchivesMedicalHistory = @"medicalHistory";
NSString *const kLWPatientRecordsPatientArchivesDiastoleTest = @"diastoleTest";
NSString *const kLWPatientRecordsPatientArchivesSex = @"sex";
NSString *const kLWPatientRecordsPatientArchivesBirthday = @"birthday";
NSString *const kLWPatientRecordsPatientArchivesSyndromeRemark = @"syndromeRemark";
NSString *const kLWPatientRecordsPatientArchivesHeight = @"height";
NSString *const kLWPatientRecordsPatientArchivesInsertDt = @"insertDt";
NSString *const kLWPatientRecordsPatientArchivesProvocationTest = @"provocationTest";
NSString *const kLWPatientRecordsPatientArchivesFamilyHistoryOther = @"familyHistoryOther";
NSString *const kLWPatientRecordsPatientArchivesIsValid = @"isValid";
NSString *const kLWPatientRecordsPatientArchivesFev1Percent = @"fev1_percent";
NSString *const kLWPatientRecordsPatientArchivesModifyDt = @"modifyDt";
NSString *const kLWPatientRecordsPatientArchivesFev1 = @"fev1";
NSString *const kLWPatientRecordsPatientArchivesSymptom = @"symptom";
NSString *const kLWPatientRecordsPatientArchivesOpenId = @"openId";
NSString *const kLWPatientRecordsPatientArchivesControlLevel = @"controlLevel";
NSString *const kLWPatientRecordsPatientArchivesPatientId = @"patientId";
NSString *const kLWPatientRecordsPatientArchivesFvcPercent = @"fvc_percent";
NSString *const kLWPatientRecordsPatientArchivesIsComplete = @"isComplete";
NSString *const kLWPatientRecordsPatientArchivesWeight = @"weight";
NSString *const kLWPatientRecordsPatientArchivesHeadImgUrl = @"headImgUrl";


@interface LWPatientRecordsPatientArchives ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWPatientRecordsPatientArchives

@synthesize allergenTest = _allergenTest;
@synthesize allergicHistory = _allergicHistory;
@synthesize symptomFactor = _symptomFactor;
@synthesize patientPhone = _patientPhone;
@synthesize remark = _remark;
@synthesize pefPredictedValue = _pefPredictedValue;
@synthesize syndrome = _syndrome;
@synthesize imageUrlList = _imageUrlList;
@synthesize resultImageUrlStr = _resultImageUrlStr;
@synthesize finishQuestionnaire = _finishQuestionnaire;
@synthesize fvc = _fvc;
@synthesize symptomFactorRemark = _symptomFactorRemark;
@synthesize feno = _feno;
@synthesize patientName = _patientName;
@synthesize familyHistoryParent = _familyHistoryParent;
@synthesize medicalHistory = _medicalHistory;
@synthesize diastoleTest = _diastoleTest;
@synthesize sex = _sex;
@synthesize birthday = _birthday;
@synthesize syndromeRemark = _syndromeRemark;
@synthesize height = _height;
@synthesize insertDt = _insertDt;
@synthesize provocationTest = _provocationTest;
@synthesize familyHistoryOther = _familyHistoryOther;
@synthesize isValid = _isValid;
@synthesize fev1Percent = _fev1Percent;
@synthesize modifyDt = _modifyDt;
@synthesize fev1 = _fev1;
@synthesize symptom = _symptom;
@synthesize openId = _openId;
@synthesize controlLevel = _controlLevel;
@synthesize patientId = _patientId;
@synthesize fvcPercent = _fvcPercent;
@synthesize isComplete = _isComplete;
@synthesize weight = _weight;
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
            self.allergenTest = [self objectOrNilForKey:kLWPatientRecordsPatientArchivesAllergenTest fromDictionary:dict];
            self.allergicHistory = [self objectOrNilForKey:kLWPatientRecordsPatientArchivesAllergicHistory fromDictionary:dict];
            self.symptomFactor = [self objectOrNilForKey:kLWPatientRecordsPatientArchivesSymptomFactor fromDictionary:dict];
            self.patientPhone = [self objectOrNilForKey:kLWPatientRecordsPatientArchivesPatientPhone fromDictionary:dict];
            self.remark = [self objectOrNilForKey:kLWPatientRecordsPatientArchivesRemark fromDictionary:dict];
            self.pefPredictedValue = [[self objectOrNilForKey:kLWPatientRecordsPatientArchivesPefPredictedValue fromDictionary:dict] doubleValue];
            self.syndrome = [self objectOrNilForKey:kLWPatientRecordsPatientArchivesSyndrome fromDictionary:dict];
            self.imageUrlList = [self objectOrNilForKey:kLWPatientRecordsPatientArchivesImageUrlList fromDictionary:dict];
            self.resultImageUrlStr = [self objectOrNilForKey:kLWPatientRecordsPatientArchivesResultImageUrlStr fromDictionary:dict];
            self.finishQuestionnaire = [[self objectOrNilForKey:kLWPatientRecordsPatientArchivesFinishQuestionnaire fromDictionary:dict] doubleValue];
            self.fvc = [self objectOrNilForKey:kLWPatientRecordsPatientArchivesFvc fromDictionary:dict];
            self.symptomFactorRemark = [self objectOrNilForKey:kLWPatientRecordsPatientArchivesSymptomFactorRemark fromDictionary:dict];
            self.feno = [self objectOrNilForKey:kLWPatientRecordsPatientArchivesFeno fromDictionary:dict];
            self.patientName = [self objectOrNilForKey:kLWPatientRecordsPatientArchivesPatientName fromDictionary:dict];
            self.familyHistoryParent = [self objectOrNilForKey:kLWPatientRecordsPatientArchivesFamilyHistoryParent fromDictionary:dict];
            self.medicalHistory = [self objectOrNilForKey:kLWPatientRecordsPatientArchivesMedicalHistory fromDictionary:dict];
            self.diastoleTest = [[self objectOrNilForKey:kLWPatientRecordsPatientArchivesDiastoleTest fromDictionary:dict] doubleValue];
            self.sex = [[self objectOrNilForKey:kLWPatientRecordsPatientArchivesSex fromDictionary:dict] doubleValue];
            self.birthday = [self objectOrNilForKey:kLWPatientRecordsPatientArchivesBirthday fromDictionary:dict];
            self.syndromeRemark = [self objectOrNilForKey:kLWPatientRecordsPatientArchivesSyndromeRemark fromDictionary:dict];
            self.height = [[self objectOrNilForKey:kLWPatientRecordsPatientArchivesHeight fromDictionary:dict] doubleValue];
            self.insertDt = [self objectOrNilForKey:kLWPatientRecordsPatientArchivesInsertDt fromDictionary:dict];
            self.provocationTest = [[self objectOrNilForKey:kLWPatientRecordsPatientArchivesProvocationTest fromDictionary:dict] doubleValue];
            self.familyHistoryOther = [self objectOrNilForKey:kLWPatientRecordsPatientArchivesFamilyHistoryOther fromDictionary:dict];
            self.isValid = [[self objectOrNilForKey:kLWPatientRecordsPatientArchivesIsValid fromDictionary:dict] doubleValue];
            self.fev1Percent = [self objectOrNilForKey:kLWPatientRecordsPatientArchivesFev1Percent fromDictionary:dict];
            self.modifyDt = [self objectOrNilForKey:kLWPatientRecordsPatientArchivesModifyDt fromDictionary:dict];
            self.fev1 = [self objectOrNilForKey:kLWPatientRecordsPatientArchivesFev1 fromDictionary:dict];
            self.symptom = [self objectOrNilForKey:kLWPatientRecordsPatientArchivesSymptom fromDictionary:dict];
            self.openId = [self objectOrNilForKey:kLWPatientRecordsPatientArchivesOpenId fromDictionary:dict];
            self.controlLevel = [self objectOrNilForKey:kLWPatientRecordsPatientArchivesControlLevel fromDictionary:dict];
            self.patientId = [self objectOrNilForKey:kLWPatientRecordsPatientArchivesPatientId fromDictionary:dict];
            self.fvcPercent = [self objectOrNilForKey:kLWPatientRecordsPatientArchivesFvcPercent fromDictionary:dict];
            self.isComplete = [[self objectOrNilForKey:kLWPatientRecordsPatientArchivesIsComplete fromDictionary:dict] doubleValue];
            self.weight = [[self objectOrNilForKey:kLWPatientRecordsPatientArchivesWeight fromDictionary:dict] doubleValue];
            self.headImgUrl = [self objectOrNilForKey:kLWPatientRecordsPatientArchivesHeadImgUrl fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.allergenTest forKey:kLWPatientRecordsPatientArchivesAllergenTest];
    [mutableDict setValue:self.allergicHistory forKey:kLWPatientRecordsPatientArchivesAllergicHistory];
    [mutableDict setValue:self.symptomFactor forKey:kLWPatientRecordsPatientArchivesSymptomFactor];
    [mutableDict setValue:self.patientPhone forKey:kLWPatientRecordsPatientArchivesPatientPhone];
    [mutableDict setValue:self.remark forKey:kLWPatientRecordsPatientArchivesRemark];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pefPredictedValue] forKey:kLWPatientRecordsPatientArchivesPefPredictedValue];
    [mutableDict setValue:self.syndrome forKey:kLWPatientRecordsPatientArchivesSyndrome];
    NSMutableArray *tempArrayForImageUrlList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.imageUrlList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForImageUrlList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForImageUrlList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForImageUrlList] forKey:kLWPatientRecordsPatientArchivesImageUrlList];
    [mutableDict setValue:self.resultImageUrlStr forKey:kLWPatientRecordsPatientArchivesResultImageUrlStr];
    [mutableDict setValue:[NSNumber numberWithDouble:self.finishQuestionnaire] forKey:kLWPatientRecordsPatientArchivesFinishQuestionnaire];
    [mutableDict setValue:self.fvc forKey:kLWPatientRecordsPatientArchivesFvc];
    [mutableDict setValue:self.symptomFactorRemark forKey:kLWPatientRecordsPatientArchivesSymptomFactorRemark];
    [mutableDict setValue:self.feno forKey:kLWPatientRecordsPatientArchivesFeno];
    [mutableDict setValue:self.patientName forKey:kLWPatientRecordsPatientArchivesPatientName];
    [mutableDict setValue:self.familyHistoryParent forKey:kLWPatientRecordsPatientArchivesFamilyHistoryParent];
    [mutableDict setValue:self.medicalHistory forKey:kLWPatientRecordsPatientArchivesMedicalHistory];
    [mutableDict setValue:[NSNumber numberWithDouble:self.diastoleTest] forKey:kLWPatientRecordsPatientArchivesDiastoleTest];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sex] forKey:kLWPatientRecordsPatientArchivesSex];
    [mutableDict setValue:self.birthday forKey:kLWPatientRecordsPatientArchivesBirthday];
    [mutableDict setValue:self.syndromeRemark forKey:kLWPatientRecordsPatientArchivesSyndromeRemark];
    [mutableDict setValue:[NSNumber numberWithDouble:self.height] forKey:kLWPatientRecordsPatientArchivesHeight];
    [mutableDict setValue:self.insertDt forKey:kLWPatientRecordsPatientArchivesInsertDt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.provocationTest] forKey:kLWPatientRecordsPatientArchivesProvocationTest];
    [mutableDict setValue:self.familyHistoryOther forKey:kLWPatientRecordsPatientArchivesFamilyHistoryOther];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isValid] forKey:kLWPatientRecordsPatientArchivesIsValid];
    [mutableDict setValue:self.fev1Percent forKey:kLWPatientRecordsPatientArchivesFev1Percent];
    [mutableDict setValue:self.modifyDt forKey:kLWPatientRecordsPatientArchivesModifyDt];
    [mutableDict setValue:self.fev1 forKey:kLWPatientRecordsPatientArchivesFev1];
    [mutableDict setValue:self.symptom forKey:kLWPatientRecordsPatientArchivesSymptom];
    [mutableDict setValue:self.openId forKey:kLWPatientRecordsPatientArchivesOpenId];
    [mutableDict setValue:self.controlLevel forKey:kLWPatientRecordsPatientArchivesControlLevel];
    [mutableDict setValue:self.patientId forKey:kLWPatientRecordsPatientArchivesPatientId];
    [mutableDict setValue:self.fvcPercent forKey:kLWPatientRecordsPatientArchivesFvcPercent];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isComplete] forKey:kLWPatientRecordsPatientArchivesIsComplete];
    [mutableDict setValue:[NSNumber numberWithDouble:self.weight] forKey:kLWPatientRecordsPatientArchivesWeight];
    [mutableDict setValue:self.headImgUrl forKey:kLWPatientRecordsPatientArchivesHeadImgUrl];

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

    self.allergenTest = [aDecoder decodeObjectForKey:kLWPatientRecordsPatientArchivesAllergenTest];
    self.allergicHistory = [aDecoder decodeObjectForKey:kLWPatientRecordsPatientArchivesAllergicHistory];
    self.symptomFactor = [aDecoder decodeObjectForKey:kLWPatientRecordsPatientArchivesSymptomFactor];
    self.patientPhone = [aDecoder decodeObjectForKey:kLWPatientRecordsPatientArchivesPatientPhone];
    self.remark = [aDecoder decodeObjectForKey:kLWPatientRecordsPatientArchivesRemark];
    self.pefPredictedValue = [aDecoder decodeDoubleForKey:kLWPatientRecordsPatientArchivesPefPredictedValue];
    self.syndrome = [aDecoder decodeObjectForKey:kLWPatientRecordsPatientArchivesSyndrome];
    self.imageUrlList = [aDecoder decodeObjectForKey:kLWPatientRecordsPatientArchivesImageUrlList];
    self.resultImageUrlStr = [aDecoder decodeObjectForKey:kLWPatientRecordsPatientArchivesResultImageUrlStr];
    self.finishQuestionnaire = [aDecoder decodeDoubleForKey:kLWPatientRecordsPatientArchivesFinishQuestionnaire];
    self.fvc = [aDecoder decodeObjectForKey:kLWPatientRecordsPatientArchivesFvc];
    self.symptomFactorRemark = [aDecoder decodeObjectForKey:kLWPatientRecordsPatientArchivesSymptomFactorRemark];
    self.feno = [aDecoder decodeObjectForKey:kLWPatientRecordsPatientArchivesFeno];
    self.patientName = [aDecoder decodeObjectForKey:kLWPatientRecordsPatientArchivesPatientName];
    self.familyHistoryParent = [aDecoder decodeObjectForKey:kLWPatientRecordsPatientArchivesFamilyHistoryParent];
    self.medicalHistory = [aDecoder decodeObjectForKey:kLWPatientRecordsPatientArchivesMedicalHistory];
    self.diastoleTest = [aDecoder decodeDoubleForKey:kLWPatientRecordsPatientArchivesDiastoleTest];
    self.sex = [aDecoder decodeDoubleForKey:kLWPatientRecordsPatientArchivesSex];
    self.birthday = [aDecoder decodeObjectForKey:kLWPatientRecordsPatientArchivesBirthday];
    self.syndromeRemark = [aDecoder decodeObjectForKey:kLWPatientRecordsPatientArchivesSyndromeRemark];
    self.height = [aDecoder decodeDoubleForKey:kLWPatientRecordsPatientArchivesHeight];
    self.insertDt = [aDecoder decodeObjectForKey:kLWPatientRecordsPatientArchivesInsertDt];
    self.provocationTest = [aDecoder decodeDoubleForKey:kLWPatientRecordsPatientArchivesProvocationTest];
    self.familyHistoryOther = [aDecoder decodeObjectForKey:kLWPatientRecordsPatientArchivesFamilyHistoryOther];
    self.isValid = [aDecoder decodeDoubleForKey:kLWPatientRecordsPatientArchivesIsValid];
    self.fev1Percent = [aDecoder decodeObjectForKey:kLWPatientRecordsPatientArchivesFev1Percent];
    self.modifyDt = [aDecoder decodeObjectForKey:kLWPatientRecordsPatientArchivesModifyDt];
    self.fev1 = [aDecoder decodeObjectForKey:kLWPatientRecordsPatientArchivesFev1];
    self.symptom = [aDecoder decodeObjectForKey:kLWPatientRecordsPatientArchivesSymptom];
    self.openId = [aDecoder decodeObjectForKey:kLWPatientRecordsPatientArchivesOpenId];
    self.controlLevel = [aDecoder decodeObjectForKey:kLWPatientRecordsPatientArchivesControlLevel];
    self.patientId = [aDecoder decodeObjectForKey:kLWPatientRecordsPatientArchivesPatientId];
    self.fvcPercent = [aDecoder decodeObjectForKey:kLWPatientRecordsPatientArchivesFvcPercent];
    self.isComplete = [aDecoder decodeDoubleForKey:kLWPatientRecordsPatientArchivesIsComplete];
    self.weight = [aDecoder decodeDoubleForKey:kLWPatientRecordsPatientArchivesWeight];
    self.headImgUrl = [aDecoder decodeObjectForKey:kLWPatientRecordsPatientArchivesHeadImgUrl];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_allergenTest forKey:kLWPatientRecordsPatientArchivesAllergenTest];
    [aCoder encodeObject:_allergicHistory forKey:kLWPatientRecordsPatientArchivesAllergicHistory];
    [aCoder encodeObject:_symptomFactor forKey:kLWPatientRecordsPatientArchivesSymptomFactor];
    [aCoder encodeObject:_patientPhone forKey:kLWPatientRecordsPatientArchivesPatientPhone];
    [aCoder encodeObject:_remark forKey:kLWPatientRecordsPatientArchivesRemark];
    [aCoder encodeDouble:_pefPredictedValue forKey:kLWPatientRecordsPatientArchivesPefPredictedValue];
    [aCoder encodeObject:_syndrome forKey:kLWPatientRecordsPatientArchivesSyndrome];
    [aCoder encodeObject:_imageUrlList forKey:kLWPatientRecordsPatientArchivesImageUrlList];
    [aCoder encodeObject:_resultImageUrlStr forKey:kLWPatientRecordsPatientArchivesResultImageUrlStr];
    [aCoder encodeDouble:_finishQuestionnaire forKey:kLWPatientRecordsPatientArchivesFinishQuestionnaire];
    [aCoder encodeObject:_fvc forKey:kLWPatientRecordsPatientArchivesFvc];
    [aCoder encodeObject:_symptomFactorRemark forKey:kLWPatientRecordsPatientArchivesSymptomFactorRemark];
    [aCoder encodeObject:_feno forKey:kLWPatientRecordsPatientArchivesFeno];
    [aCoder encodeObject:_patientName forKey:kLWPatientRecordsPatientArchivesPatientName];
    [aCoder encodeObject:_familyHistoryParent forKey:kLWPatientRecordsPatientArchivesFamilyHistoryParent];
    [aCoder encodeObject:_medicalHistory forKey:kLWPatientRecordsPatientArchivesMedicalHistory];
    [aCoder encodeDouble:_diastoleTest forKey:kLWPatientRecordsPatientArchivesDiastoleTest];
    [aCoder encodeDouble:_sex forKey:kLWPatientRecordsPatientArchivesSex];
    [aCoder encodeObject:_birthday forKey:kLWPatientRecordsPatientArchivesBirthday];
    [aCoder encodeObject:_syndromeRemark forKey:kLWPatientRecordsPatientArchivesSyndromeRemark];
    [aCoder encodeDouble:_height forKey:kLWPatientRecordsPatientArchivesHeight];
    [aCoder encodeObject:_insertDt forKey:kLWPatientRecordsPatientArchivesInsertDt];
    [aCoder encodeDouble:_provocationTest forKey:kLWPatientRecordsPatientArchivesProvocationTest];
    [aCoder encodeObject:_familyHistoryOther forKey:kLWPatientRecordsPatientArchivesFamilyHistoryOther];
    [aCoder encodeDouble:_isValid forKey:kLWPatientRecordsPatientArchivesIsValid];
    [aCoder encodeObject:_fev1Percent forKey:kLWPatientRecordsPatientArchivesFev1Percent];
    [aCoder encodeObject:_modifyDt forKey:kLWPatientRecordsPatientArchivesModifyDt];
    [aCoder encodeObject:_fev1 forKey:kLWPatientRecordsPatientArchivesFev1];
    [aCoder encodeObject:_symptom forKey:kLWPatientRecordsPatientArchivesSymptom];
    [aCoder encodeObject:_openId forKey:kLWPatientRecordsPatientArchivesOpenId];
    [aCoder encodeObject:_controlLevel forKey:kLWPatientRecordsPatientArchivesControlLevel];
    [aCoder encodeObject:_patientId forKey:kLWPatientRecordsPatientArchivesPatientId];
    [aCoder encodeObject:_fvcPercent forKey:kLWPatientRecordsPatientArchivesFvcPercent];
    [aCoder encodeDouble:_isComplete forKey:kLWPatientRecordsPatientArchivesIsComplete];
    [aCoder encodeDouble:_weight forKey:kLWPatientRecordsPatientArchivesWeight];
    [aCoder encodeObject:_headImgUrl forKey:kLWPatientRecordsPatientArchivesHeadImgUrl];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWPatientRecordsPatientArchives *copy = [[LWPatientRecordsPatientArchives alloc] init];
    
    if (copy) {

        copy.allergenTest = [self.allergenTest copyWithZone:zone];
        copy.allergicHistory = [self.allergicHistory copyWithZone:zone];
        copy.symptomFactor = [self.symptomFactor copyWithZone:zone];
        copy.patientPhone = [self.patientPhone copyWithZone:zone];
        copy.remark = [self.remark copyWithZone:zone];
        copy.pefPredictedValue = self.pefPredictedValue;
        copy.syndrome = [self.syndrome copyWithZone:zone];
        copy.imageUrlList = [self.imageUrlList copyWithZone:zone];
        copy.resultImageUrlStr = [self.resultImageUrlStr copyWithZone:zone];
        copy.finishQuestionnaire = self.finishQuestionnaire;
        copy.fvc = [self.fvc copyWithZone:zone];
        copy.symptomFactorRemark = [self.symptomFactorRemark copyWithZone:zone];
        copy.feno = [self.feno copyWithZone:zone];
        copy.patientName = [self.patientName copyWithZone:zone];
        copy.familyHistoryParent = [self.familyHistoryParent copyWithZone:zone];
        copy.medicalHistory = [self.medicalHistory copyWithZone:zone];
        copy.diastoleTest = self.diastoleTest;
        copy.sex = self.sex;
        copy.birthday = [self.birthday copyWithZone:zone];
        copy.syndromeRemark = [self.syndromeRemark copyWithZone:zone];
        copy.height = self.height;
        copy.insertDt = [self.insertDt copyWithZone:zone];
        copy.provocationTest = self.provocationTest;
        copy.familyHistoryOther = [self.familyHistoryOther copyWithZone:zone];
        copy.isValid = self.isValid;
        copy.fev1Percent = [self.fev1Percent copyWithZone:zone];
        copy.modifyDt = [self.modifyDt copyWithZone:zone];
        copy.fev1 = [self.fev1 copyWithZone:zone];
        copy.symptom = [self.symptom copyWithZone:zone];
        copy.openId = [self.openId copyWithZone:zone];
        copy.controlLevel = [self.controlLevel copyWithZone:zone];
        copy.patientId = [self.patientId copyWithZone:zone];
        copy.fvcPercent = [self.fvcPercent copyWithZone:zone];
        copy.isComplete = self.isComplete;
        copy.weight = self.weight;
        copy.headImgUrl = [self.headImgUrl copyWithZone:zone];
    }
    
    return copy;
}


@end
