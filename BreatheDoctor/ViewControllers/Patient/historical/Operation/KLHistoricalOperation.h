//
//  KLHistoricalOperation.h
//  BreatheDoctor
//
//  Created by comv on 16/3/25.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLHistoricalOperation : NSObject

/**
 *  记录次数
 *
 *  @param array 记录数组
 *
 *  @return 次数
 */
+ (NSInteger)historicalCountInfo:(NSMutableArray *)array;
/**
 *  各个区域次数
 *
 *  @param body 记录对象
 *
 *  @return 各个区域的字典
 */
+ (NSDictionary *)historicalPefRecordCoutInfo:(KLPatientLogBodyModel *)body
                              thepefDataArray:(NSMutableArray *)pefArray;

/**
 *  症状区域次数
 *
 *  @param array    记录次数
 *  @param logArray 症状数组
 *
 *  @return 各个次数
 */
+ (NSDictionary *)historicalSymptomsRecordCountInfo:(NSMutableArray *)array
                                theSymptomsLogArray:(NSMutableArray *)logArray
                             thehistoricalDataArray:(NSMutableArray *)historicalArray;

/**
 *  用药记录
 *
 *  @param array           array description
 *  @param historicalArray historicalArray description
 *
 *  @return
 */
+ (NSDictionary *)historicalMedicationRecordCountInfo:(NSMutableArray *)array
                               thehistoricalDataArray:(NSMutableArray *)historicalArray;


/**
 *  用药表统计
 *
 *  @param array array description
 *
 *  @return return value description
 */
+ (NSMutableArray *)mergeHistoricalListInfo:(NSMutableArray *)array;

/**
 *  得到pef颜色
 *
 *  @param pefPredictedValue pefPredictedValue description
 *
 *  @return return value description
 */
+ (UIColor *)pefColorInfo:(double)pefPredictedValue thePefValue:(double)value;

+ (BOOL)areaAbnormalValueInfo:(double)pefPredictedValue thePefValue:(double)pefValue;
+ (BOOL)areaWarningValueInfo:(double)pefPredictedValue thePefValue:(double)pefValue;
+ (BOOL)areaNormalValueInfo:(double)pefPredictedValue thePefValue:(double)pefValue;

@end
