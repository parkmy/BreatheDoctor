//
//  LWMedicationView.h
//  BreatheDoctor
//
//  Created by comv on 16/3/16.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWBaseHistoricalView.h"
@interface LWMedicationView : LWBaseHistoricalView

- (void)setLogDateText:(NSString *)string;
- (void)reloadMedicationViewData:(KLPatientLogBodyModel *)model;

@end
