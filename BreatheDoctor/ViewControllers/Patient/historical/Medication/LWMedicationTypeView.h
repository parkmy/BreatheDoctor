//
//  LWMedicationTypeView.h
//  BreatheDoctor
//
//  Created by comv on 16/3/17.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KLPatientLogModel;

@interface LWMedicationTypeView : UIView

- (void)setTimerString:(NSString *)string;
- (void)setControlButtonType:(NSInteger)type;
- (void)setEmergencyButtonType:(NSInteger)type;
@end
