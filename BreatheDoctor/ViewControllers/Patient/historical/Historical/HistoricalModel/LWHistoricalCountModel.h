//
//  LWHistoricalCountModel.h
//  BreatheDoctor
//
//  Created by comv on 16/3/18.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWHistoricalHeardView.h"

@interface LWHistoricalCountModel : NSObject
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy)  NSString *typeTitle;
@property (nonatomic, strong) UIColor  *countColor;
@property (nonatomic, assign) NSInteger typeTag;
/**
 *  安全颜色
 *
 *  @return 颜色
 */
+ (UIColor *)normalColor;
/**
 *  警告颜色
 *
 *  @return 颜色
 */
+ (UIColor *)abnormalColor;
/**
 *  危险颜色
 *
 *  @return 颜色
 */
+ (UIColor *)warningColor;
/**
 *  无
 *
 *  @return 颜色
 */
+ (UIColor *)noMeColor;
/**
 *  得到历史记录各个界面的次数标题对象数组
 *
 *  @param type 界面类型
 *
 *  @return 数组
 */
+ (NSMutableArray *)historicalType:(showHistoricalType)type;
/**
 *  得到Attributed字符串
 *
 *  @return 字符串
 */
- (NSMutableAttributedString *)historicalCountAttributedStringInfoDataArray:(NSMutableArray *)array;

@end
