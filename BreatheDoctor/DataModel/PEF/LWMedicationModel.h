//
//  LWMedicationModel.h
//  BreatheDoctor
//
//  Created by comv on 15/11/26.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWMedicationModel : NSObject
@property (nonatomic, assign) double pharmacyUrgency;//用药记录--紧急用药
@property (nonatomic, assign) double pharmacyControl;//用药记录--控制用药

@property (nonatomic, assign) BOOL isOne;

@property (nonatomic, copy)  NSString *recordDt;

@property (nonatomic, assign) double morningPharmacyUrgency;
@property (nonatomic, assign) double morningPharmacyControl;

@property (nonatomic, assign) double afternoonPharmacyUrgency;
@property (nonatomic, assign) double afternoonPharmacyControl;

@property (nonatomic, assign) double timeFrame;

@property (nonatomic, assign) double morningpefValue;
@property (nonatomic, assign) double eveningpefValue;


@end
