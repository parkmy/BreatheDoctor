//
//  LWPEFListView.h
//  BreatheDoctor
//
//  Created by comv on 16/3/15.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWPEFListView : UIView
/**
 *  最佳值
 */
@property (nonatomic, assign) double pefPredictedValue;
/**
 *  设置列表数据
 *
 *  @param array 资源
 */
- (void)setPefHistorical:(NSMutableArray *)array;
/**
 *  设置红黄绿值
 *
 *  @param pefPredictedValue 最佳值
 */
- (void)setLineViewYnumber:(double)pefPredictedValue;
/**
 *  PEF时间改变
 *
 *  @param dateCount 传入的时间
 */
- (void)changePefDateList:(NSInteger)dateCount;
/**
 *  设置线条
 *
 *  @param body 资源
 */
- (void)setItmLineView:(KLPatientLogBodyModel *)body;
@end
