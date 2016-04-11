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
/**
 *  时间设置
 *
 *  @param string 时间
 */
- (void)setTimerString:(NSString *)string;
/**
 *  设置控制用药的样式
 *
 *  @param type 类型
 */
- (void)setControlButtonType:(NSInteger)type;
/**
 *  设置紧急用药的样式
 *
 *  @param type 类型
 */
- (void)setEmergencyButtonType:(NSInteger)type;
@end
