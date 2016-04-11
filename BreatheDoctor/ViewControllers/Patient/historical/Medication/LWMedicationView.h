//
//  LWMedicationView.h
//  BreatheDoctor
//
//  Created by comv on 16/3/16.
//  Copyright © 2016年 lwh. All rights reserved.
// 用药

#import "LWBaseHistoricalView.h"
@interface LWMedicationView : LWBaseHistoricalView
/**
 *  设置日期
 *
 *  @param string 日期
 */
- (void)setLogDateText:(NSString *)string;
- (void)reloadMedicationViewData:(KLPatientLogBodyModel *)model;

@end
