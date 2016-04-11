//
//  KLTimerRemindViewOperation.h
//  BreatheDoctor
//
//  Created by comv on 16/4/8.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLTimerRemindViewOperation : NSObject
/**
 *  保存设置回复时间
 *
 *  @param array        数据模型数组
 *  @param successBlock 返回设置回调
 */
+ (void)saveTimerRemindSetingWithArray:(NSMutableArray *)array
                               success:(void(^)(BOOL isSuccess))successBlock;


/**
 *  得到重复周期数组
 *
 *  @param string 周期字符串
 *
 *  @return 周期数组
 */
+ (NSArray *)weekArray:(NSString *)string;

/**
 *  得到周期星期字符串
 *
 *  @param array 周期数组
 *
 *  @return 字符串
 */
+ (NSString *)getWeekString:(NSArray *)array;

/**
 *  设置周期标签
 *
 *  @param label  标签
 *  @param string 数据
 */
+ (void)setWeekLabelWithLabel:(UILabel *)label data:(NSString *)string;

@end
