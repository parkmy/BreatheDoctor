//
//  LWSymptomsView.h
//  BreatheDoctor
//
//  Created by comv on 16/3/16.
//  Copyright © 2016年 lwh. All rights reserved.
// 症状

#import "LWBaseHistoricalView.h"

@interface LWSymptomsView : LWBaseHistoricalView
/**
 *  设置日志时间
 *
 *  @param string 时间
 */
- (void)setLogDateText:(NSString *)string;
/**
 *  刷新症状
 *
 *  @param model 数据资源
 */
- (void)reloadSymptomsViewData:(KLPatientLogBodyModel *)model;

@end
