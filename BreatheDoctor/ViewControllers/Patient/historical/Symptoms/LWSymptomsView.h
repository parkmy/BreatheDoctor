//
//  LWSymptomsView.h
//  BreatheDoctor
//
//  Created by comv on 16/3/16.
//  Copyright © 2016年 lwh. All rights reserved.
// 症状

#import "LWBaseHistoricalView.h"

@interface LWSymptomsView : LWBaseHistoricalView

- (void)setLogDateText:(NSString *)string;
- (void)reloadSymptomsViewData:(KLPatientLogBodyModel *)model;

@end
