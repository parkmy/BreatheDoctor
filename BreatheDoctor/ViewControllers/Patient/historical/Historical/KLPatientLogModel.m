//
//  KLPatientLogBody.m
//
//  Created by   on 16/3/24
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "KLPatientLogModel.h"


NSString *const kKLPatientLogBodySymptomOthers = @"symptomOthers";
NSString *const kKLPatientLogBodySymptomDyspnea = @"symptomDyspnea";
NSString *const kKLPatientLogBodyRecordDt = @"recordDt";
NSString *const kKLPatientLogBodyRemark = @"remark";
NSString *const kKLPatientLogBodyInducementBlubbered = @"inducementBlubbered";
NSString *const kKLPatientLogBodyControlRate = @"controlRate";
NSString *const kKLPatientLogBodyInducementSports = @"inducementSports";
NSString *const kKLPatientLogBodySymptomChestdistress = @"symptomChestdistress";
NSString *const kKLPatientLogBodySymptomRhinocnesmus = @"symptomRhinocnesmus";
NSString *const kKLPatientLogBodyPefValue = @"pefValue";
NSString *const kKLPatientLogBodyInducementFabricPlush = @"inducementFabricPlush";
NSString *const kKLPatientLogBodyPharmacyControl = @"pharmacyControl";
NSString *const kKLPatientLogBodyInducementPollen = @"inducementPollen";
NSString *const kKLPatientLogBodyRecordId = @"recordId";
NSString *const kKLPatientLogBodySymptomNightWoke = @"symptomNightWoke";
NSString *const kKLPatientLogBodyInducementSpecialSmell = @"inducementSpecialSmell";
NSString *const kKLPatientLogBodyInsertDt = @"insertDt";
NSString *const kKLPatientLogBodyInducementCold = @"inducementCold";
NSString *const kKLPatientLogBodySymptomRunny = @"symptomRunny";
NSString *const kKLPatientLogBodyInducementOthers = @"inducementOthers";
NSString *const kKLPatientLogBodyModifyDt = @"modifyDt";
NSString *const kKLPatientLogBodyInducementPet = @"inducementPet";
NSString *const kKLPatientLogBodySymptomActLimited = @"symptomActLimited";
NSString *const kKLPatientLogBodySymptomCough = @"symptomCough";
NSString *const kKLPatientLogBodyInducementSmoking = @"inducementSmoking";
NSString *const kKLPatientLogBodyPharmacyUrgency = @"pharmacyUrgency";
NSString *const kKLPatientLogBodySymptomSneeze = @"symptomSneeze";
NSString *const kKLPatientLogBodyInducementFeverCold = @"inducementFeverCold";
NSString *const kKLPatientLogBodyPatientId = @"patientId";
NSString *const kKLPatientLogBodyPerfValue = @"perfValue";
NSString *const kKLPatientLogBodyTimeFrame = @"timeFrame";
NSString *const kKLPatientLogBodySymptomGasp = @"symptomGasp";
NSString *const kKLPatientLogBodySymptomEczema = @"symptomEczema";
NSString *const kKLPatientLogBodySymptomGood = @"symptomGood";


@interface KLPatientLogModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation KLPatientLogModel

@synthesize symptomOthers = _symptomOthers;
@synthesize symptomDyspnea = _symptomDyspnea;
@synthesize recordDt = _recordDt;
@synthesize remark = _remark;
@synthesize inducementBlubbered = _inducementBlubbered;
@synthesize controlRate = _controlRate;
@synthesize inducementSports = _inducementSports;
@synthesize symptomChestdistress = _symptomChestdistress;
@synthesize symptomRhinocnesmus = _symptomRhinocnesmus;
@synthesize pefValue = _pefValue;
@synthesize inducementFabricPlush = _inducementFabricPlush;
@synthesize pharmacyControl = _pharmacyControl;
@synthesize inducementPollen = _inducementPollen;
@synthesize recordId = _recordId;
@synthesize symptomNightWoke = _symptomNightWoke;
@synthesize inducementSpecialSmell = _inducementSpecialSmell;
@synthesize insertDt = _insertDt;
@synthesize inducementCold = _inducementCold;
@synthesize symptomRunny = _symptomRunny;
@synthesize inducementOthers = _inducementOthers;
@synthesize modifyDt = _modifyDt;
@synthesize inducementPet = _inducementPet;
@synthesize symptomActLimited = _symptomActLimited;
@synthesize symptomCough = _symptomCough;
@synthesize inducementSmoking = _inducementSmoking;
@synthesize pharmacyUrgency = _pharmacyUrgency;
@synthesize symptomSneeze = _symptomSneeze;
@synthesize inducementFeverCold = _inducementFeverCold;
@synthesize patientId = _patientId;
@synthesize perfValue = _perfValue;
@synthesize timeFrame = _timeFrame;
@synthesize symptomGasp = _symptomGasp;
@synthesize symptomEczema = _symptomEczema;
@synthesize symptomGood = _symptomGood;


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
        self.symptomOthers = [[self objectOrNilForKey:kKLPatientLogBodySymptomOthers fromDictionary:dict] doubleValue];
        self.symptomDyspnea = [[self objectOrNilForKey:kKLPatientLogBodySymptomDyspnea fromDictionary:dict] doubleValue];
        self.recordDt = [self objectOrNilForKey:kKLPatientLogBodyRecordDt fromDictionary:dict];
        self.remark = [self objectOrNilForKey:kKLPatientLogBodyRemark fromDictionary:dict];
        self.inducementBlubbered = [[self objectOrNilForKey:kKLPatientLogBodyInducementBlubbered fromDictionary:dict] doubleValue];
        self.controlRate = [[self objectOrNilForKey:kKLPatientLogBodyControlRate fromDictionary:dict] doubleValue];
        self.inducementSports = [[self objectOrNilForKey:kKLPatientLogBodyInducementSports fromDictionary:dict] doubleValue];
        self.symptomChestdistress = [[self objectOrNilForKey:kKLPatientLogBodySymptomChestdistress fromDictionary:dict] doubleValue];
        self.symptomRhinocnesmus = [[self objectOrNilForKey:kKLPatientLogBodySymptomRhinocnesmus fromDictionary:dict] doubleValue];
        self.pefValue = [[self objectOrNilForKey:kKLPatientLogBodyPefValue fromDictionary:dict] doubleValue];
        self.inducementFabricPlush = [[self objectOrNilForKey:kKLPatientLogBodyInducementFabricPlush fromDictionary:dict] doubleValue];
        if ([dict objectForKey:kKLPatientLogBodyPharmacyControl]) {
            self.pharmacyControl = [[self objectOrNilForKey:kKLPatientLogBodyPharmacyControl fromDictionary:dict] doubleValue];
        }else
        {
            self.pharmacyControl = 2;
        }
        self.inducementPollen = [[self objectOrNilForKey:kKLPatientLogBodyInducementPollen fromDictionary:dict] doubleValue];
        self.recordId = [self objectOrNilForKey:kKLPatientLogBodyRecordId fromDictionary:dict];
        self.symptomNightWoke = [[self objectOrNilForKey:kKLPatientLogBodySymptomNightWoke fromDictionary:dict] doubleValue];
        self.inducementSpecialSmell = [[self objectOrNilForKey:kKLPatientLogBodyInducementSpecialSmell fromDictionary:dict] doubleValue];
        self.insertDt = [self objectOrNilForKey:kKLPatientLogBodyInsertDt fromDictionary:dict];
        self.inducementCold = [[self objectOrNilForKey:kKLPatientLogBodyInducementCold fromDictionary:dict] doubleValue];
        self.symptomRunny = [[self objectOrNilForKey:kKLPatientLogBodySymptomRunny fromDictionary:dict] doubleValue];
        self.inducementOthers = [[self objectOrNilForKey:kKLPatientLogBodyInducementOthers fromDictionary:dict] doubleValue];
        self.modifyDt = [self objectOrNilForKey:kKLPatientLogBodyModifyDt fromDictionary:dict];
        self.inducementPet = [[self objectOrNilForKey:kKLPatientLogBodyInducementPet fromDictionary:dict] doubleValue];
        self.symptomActLimited = [[self objectOrNilForKey:kKLPatientLogBodySymptomActLimited fromDictionary:dict] doubleValue];
        self.symptomCough = [[self objectOrNilForKey:kKLPatientLogBodySymptomCough fromDictionary:dict] doubleValue];
        self.inducementSmoking = [[self objectOrNilForKey:kKLPatientLogBodyInducementSmoking fromDictionary:dict] doubleValue];
        
        if ([dict objectForKey:kKLPatientLogBodyPharmacyUrgency]) {
            self.pharmacyUrgency = [[self objectOrNilForKey:kKLPatientLogBodyPharmacyUrgency fromDictionary:dict] doubleValue];
        }else
        {
            self.pharmacyUrgency = 2;
        }
        self.symptomSneeze = [[self objectOrNilForKey:kKLPatientLogBodySymptomSneeze fromDictionary:dict] doubleValue];
        self.inducementFeverCold = [[self objectOrNilForKey:kKLPatientLogBodyInducementFeverCold fromDictionary:dict] doubleValue];
        self.patientId = [self objectOrNilForKey:kKLPatientLogBodyPatientId fromDictionary:dict];
        self.perfValue = [[self objectOrNilForKey:kKLPatientLogBodyPerfValue fromDictionary:dict] doubleValue];
        self.timeFrame = [[self objectOrNilForKey:kKLPatientLogBodyTimeFrame fromDictionary:dict] doubleValue];
        self.symptomGasp = [[self objectOrNilForKey:kKLPatientLogBodySymptomGasp fromDictionary:dict] doubleValue];
        self.symptomEczema = [[self objectOrNilForKey:kKLPatientLogBodySymptomEczema fromDictionary:dict] doubleValue];
        self.symptomGood = [[self objectOrNilForKey:kKLPatientLogBodySymptomGood fromDictionary:dict] doubleValue];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.symptomOthers] forKey:kKLPatientLogBodySymptomOthers];
    [mutableDict setValue:[NSNumber numberWithDouble:self.symptomDyspnea] forKey:kKLPatientLogBodySymptomDyspnea];
    [mutableDict setValue:self.recordDt forKey:kKLPatientLogBodyRecordDt];
    [mutableDict setValue:self.remark forKey:kKLPatientLogBodyRemark];
    [mutableDict setValue:[NSNumber numberWithDouble:self.inducementBlubbered] forKey:kKLPatientLogBodyInducementBlubbered];
    [mutableDict setValue:[NSNumber numberWithDouble:self.controlRate] forKey:kKLPatientLogBodyControlRate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.inducementSports] forKey:kKLPatientLogBodyInducementSports];
    [mutableDict setValue:[NSNumber numberWithDouble:self.symptomChestdistress] forKey:kKLPatientLogBodySymptomChestdistress];
    [mutableDict setValue:[NSNumber numberWithDouble:self.symptomRhinocnesmus] forKey:kKLPatientLogBodySymptomRhinocnesmus];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pefValue] forKey:kKLPatientLogBodyPefValue];
    [mutableDict setValue:[NSNumber numberWithDouble:self.inducementFabricPlush] forKey:kKLPatientLogBodyInducementFabricPlush];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pharmacyControl] forKey:kKLPatientLogBodyPharmacyControl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.inducementPollen] forKey:kKLPatientLogBodyInducementPollen];
    [mutableDict setValue:self.recordId forKey:kKLPatientLogBodyRecordId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.symptomNightWoke] forKey:kKLPatientLogBodySymptomNightWoke];
    [mutableDict setValue:[NSNumber numberWithDouble:self.inducementSpecialSmell] forKey:kKLPatientLogBodyInducementSpecialSmell];
    [mutableDict setValue:self.insertDt forKey:kKLPatientLogBodyInsertDt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.inducementCold] forKey:kKLPatientLogBodyInducementCold];
    [mutableDict setValue:[NSNumber numberWithDouble:self.symptomRunny] forKey:kKLPatientLogBodySymptomRunny];
    [mutableDict setValue:[NSNumber numberWithDouble:self.inducementOthers] forKey:kKLPatientLogBodyInducementOthers];
    [mutableDict setValue:self.modifyDt forKey:kKLPatientLogBodyModifyDt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.inducementPet] forKey:kKLPatientLogBodyInducementPet];
    [mutableDict setValue:[NSNumber numberWithDouble:self.symptomActLimited] forKey:kKLPatientLogBodySymptomActLimited];
    [mutableDict setValue:[NSNumber numberWithDouble:self.symptomCough] forKey:kKLPatientLogBodySymptomCough];
    [mutableDict setValue:[NSNumber numberWithDouble:self.inducementSmoking] forKey:kKLPatientLogBodyInducementSmoking];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pharmacyUrgency] forKey:kKLPatientLogBodyPharmacyUrgency];
    [mutableDict setValue:[NSNumber numberWithDouble:self.symptomSneeze] forKey:kKLPatientLogBodySymptomSneeze];
    [mutableDict setValue:[NSNumber numberWithDouble:self.inducementFeverCold] forKey:kKLPatientLogBodyInducementFeverCold];
    [mutableDict setValue:self.patientId forKey:kKLPatientLogBodyPatientId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.perfValue] forKey:kKLPatientLogBodyPerfValue];
    [mutableDict setValue:[NSNumber numberWithDouble:self.timeFrame] forKey:kKLPatientLogBodyTimeFrame];
    [mutableDict setValue:[NSNumber numberWithDouble:self.symptomGasp] forKey:kKLPatientLogBodySymptomGasp];
    [mutableDict setValue:[NSNumber numberWithDouble:self.symptomEczema] forKey:kKLPatientLogBodySymptomEczema];
    [mutableDict setValue:[NSNumber numberWithDouble:self.symptomGood] forKey:kKLPatientLogBodySymptomGood];
    
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
    
    self.symptomOthers = [aDecoder decodeDoubleForKey:kKLPatientLogBodySymptomOthers];
    self.symptomDyspnea = [aDecoder decodeDoubleForKey:kKLPatientLogBodySymptomDyspnea];
    self.recordDt = [aDecoder decodeObjectForKey:kKLPatientLogBodyRecordDt];
    self.remark = [aDecoder decodeObjectForKey:kKLPatientLogBodyRemark];
    self.inducementBlubbered = [aDecoder decodeDoubleForKey:kKLPatientLogBodyInducementBlubbered];
    self.controlRate = [aDecoder decodeDoubleForKey:kKLPatientLogBodyControlRate];
    self.inducementSports = [aDecoder decodeDoubleForKey:kKLPatientLogBodyInducementSports];
    self.symptomChestdistress = [aDecoder decodeDoubleForKey:kKLPatientLogBodySymptomChestdistress];
    self.symptomRhinocnesmus = [aDecoder decodeDoubleForKey:kKLPatientLogBodySymptomRhinocnesmus];
    self.pefValue = [aDecoder decodeDoubleForKey:kKLPatientLogBodyPefValue];
    self.inducementFabricPlush = [aDecoder decodeDoubleForKey:kKLPatientLogBodyInducementFabricPlush];
    self.pharmacyControl = [aDecoder decodeDoubleForKey:kKLPatientLogBodyPharmacyControl];
    self.inducementPollen = [aDecoder decodeDoubleForKey:kKLPatientLogBodyInducementPollen];
    self.recordId = [aDecoder decodeObjectForKey:kKLPatientLogBodyRecordId];
    self.symptomNightWoke = [aDecoder decodeDoubleForKey:kKLPatientLogBodySymptomNightWoke];
    self.inducementSpecialSmell = [aDecoder decodeDoubleForKey:kKLPatientLogBodyInducementSpecialSmell];
    self.insertDt = [aDecoder decodeObjectForKey:kKLPatientLogBodyInsertDt];
    self.inducementCold = [aDecoder decodeDoubleForKey:kKLPatientLogBodyInducementCold];
    self.symptomRunny = [aDecoder decodeDoubleForKey:kKLPatientLogBodySymptomRunny];
    self.inducementOthers = [aDecoder decodeDoubleForKey:kKLPatientLogBodyInducementOthers];
    self.modifyDt = [aDecoder decodeObjectForKey:kKLPatientLogBodyModifyDt];
    self.inducementPet = [aDecoder decodeDoubleForKey:kKLPatientLogBodyInducementPet];
    self.symptomActLimited = [aDecoder decodeDoubleForKey:kKLPatientLogBodySymptomActLimited];
    self.symptomCough = [aDecoder decodeDoubleForKey:kKLPatientLogBodySymptomCough];
    self.inducementSmoking = [aDecoder decodeDoubleForKey:kKLPatientLogBodyInducementSmoking];
    self.pharmacyUrgency = [aDecoder decodeDoubleForKey:kKLPatientLogBodyPharmacyUrgency];
    self.symptomSneeze = [aDecoder decodeDoubleForKey:kKLPatientLogBodySymptomSneeze];
    self.inducementFeverCold = [aDecoder decodeDoubleForKey:kKLPatientLogBodyInducementFeverCold];
    self.patientId = [aDecoder decodeObjectForKey:kKLPatientLogBodyPatientId];
    self.perfValue = [aDecoder decodeDoubleForKey:kKLPatientLogBodyPerfValue];
    self.timeFrame = [aDecoder decodeDoubleForKey:kKLPatientLogBodyTimeFrame];
    self.symptomGasp = [aDecoder decodeDoubleForKey:kKLPatientLogBodySymptomGasp];
    self.symptomEczema = [aDecoder decodeDoubleForKey:kKLPatientLogBodySymptomEczema];
    self.symptomGood = [aDecoder decodeDoubleForKey:kKLPatientLogBodySymptomGood];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeDouble:_symptomOthers forKey:kKLPatientLogBodySymptomOthers];
    [aCoder encodeDouble:_symptomDyspnea forKey:kKLPatientLogBodySymptomDyspnea];
    [aCoder encodeObject:_recordDt forKey:kKLPatientLogBodyRecordDt];
    [aCoder encodeObject:_remark forKey:kKLPatientLogBodyRemark];
    [aCoder encodeDouble:_inducementBlubbered forKey:kKLPatientLogBodyInducementBlubbered];
    [aCoder encodeDouble:_controlRate forKey:kKLPatientLogBodyControlRate];
    [aCoder encodeDouble:_inducementSports forKey:kKLPatientLogBodyInducementSports];
    [aCoder encodeDouble:_symptomChestdistress forKey:kKLPatientLogBodySymptomChestdistress];
    [aCoder encodeDouble:_symptomRhinocnesmus forKey:kKLPatientLogBodySymptomRhinocnesmus];
    [aCoder encodeDouble:_pefValue forKey:kKLPatientLogBodyPefValue];
    [aCoder encodeDouble:_inducementFabricPlush forKey:kKLPatientLogBodyInducementFabricPlush];
    [aCoder encodeDouble:_pharmacyControl forKey:kKLPatientLogBodyPharmacyControl];
    [aCoder encodeDouble:_inducementPollen forKey:kKLPatientLogBodyInducementPollen];
    [aCoder encodeObject:_recordId forKey:kKLPatientLogBodyRecordId];
    [aCoder encodeDouble:_symptomNightWoke forKey:kKLPatientLogBodySymptomNightWoke];
    [aCoder encodeDouble:_inducementSpecialSmell forKey:kKLPatientLogBodyInducementSpecialSmell];
    [aCoder encodeObject:_insertDt forKey:kKLPatientLogBodyInsertDt];
    [aCoder encodeDouble:_inducementCold forKey:kKLPatientLogBodyInducementCold];
    [aCoder encodeDouble:_symptomRunny forKey:kKLPatientLogBodySymptomRunny];
    [aCoder encodeDouble:_inducementOthers forKey:kKLPatientLogBodyInducementOthers];
    [aCoder encodeObject:_modifyDt forKey:kKLPatientLogBodyModifyDt];
    [aCoder encodeDouble:_inducementPet forKey:kKLPatientLogBodyInducementPet];
    [aCoder encodeDouble:_symptomActLimited forKey:kKLPatientLogBodySymptomActLimited];
    [aCoder encodeDouble:_symptomCough forKey:kKLPatientLogBodySymptomCough];
    [aCoder encodeDouble:_inducementSmoking forKey:kKLPatientLogBodyInducementSmoking];
    [aCoder encodeDouble:_pharmacyUrgency forKey:kKLPatientLogBodyPharmacyUrgency];
    [aCoder encodeDouble:_symptomSneeze forKey:kKLPatientLogBodySymptomSneeze];
    [aCoder encodeDouble:_inducementFeverCold forKey:kKLPatientLogBodyInducementFeverCold];
    [aCoder encodeObject:_patientId forKey:kKLPatientLogBodyPatientId];
    [aCoder encodeDouble:_perfValue forKey:kKLPatientLogBodyPerfValue];
    [aCoder encodeDouble:_timeFrame forKey:kKLPatientLogBodyTimeFrame];
    [aCoder encodeDouble:_symptomGasp forKey:kKLPatientLogBodySymptomGasp];
    [aCoder encodeDouble:_symptomEczema forKey:kKLPatientLogBodySymptomEczema];
    [aCoder encodeDouble:_symptomGood forKey:kKLPatientLogBodySymptomGood];
}

- (id)copyWithZone:(NSZone *)zone
{
    KLPatientLogModel *copy = [[KLPatientLogModel alloc] init];
    
    if (copy) {
        
        copy.symptomOthers = self.symptomOthers;
        copy.symptomDyspnea = self.symptomDyspnea;
        copy.recordDt = [self.recordDt copyWithZone:zone];
        copy.remark = [self.remark copyWithZone:zone];
        copy.inducementBlubbered = self.inducementBlubbered;
        copy.controlRate = self.controlRate;
        copy.inducementSports = self.inducementSports;
        copy.symptomChestdistress = self.symptomChestdistress;
        copy.symptomRhinocnesmus = self.symptomRhinocnesmus;
        copy.pefValue = self.pefValue;
        copy.inducementFabricPlush = self.inducementFabricPlush;
        copy.pharmacyControl = self.pharmacyControl;
        copy.inducementPollen = self.inducementPollen;
        copy.recordId = [self.recordId copyWithZone:zone];
        copy.symptomNightWoke = self.symptomNightWoke;
        copy.inducementSpecialSmell = self.inducementSpecialSmell;
        copy.insertDt = [self.insertDt copyWithZone:zone];
        copy.inducementCold = self.inducementCold;
        copy.symptomRunny = self.symptomRunny;
        copy.inducementOthers = self.inducementOthers;
        copy.modifyDt = [self.modifyDt copyWithZone:zone];
        copy.inducementPet = self.inducementPet;
        copy.symptomActLimited = self.symptomActLimited;
        copy.symptomCough = self.symptomCough;
        copy.inducementSmoking = self.inducementSmoking;
        copy.pharmacyUrgency = self.pharmacyUrgency;
        copy.symptomSneeze = self.symptomSneeze;
        copy.inducementFeverCold = self.inducementFeverCold;
        copy.patientId = [self.patientId copyWithZone:zone];
        copy.perfValue = self.perfValue;
        copy.timeFrame = self.timeFrame;
        copy.symptomGasp = self.symptomGasp;
        copy.symptomEczema = self.symptomEczema;
        copy.symptomGood = self.symptomGood;
    }
    
    return copy;
}


@end
