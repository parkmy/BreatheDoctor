//
//  LWTool.h
//  BreatheDoctor
//
//  Created by comv on 15/11/12.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWPersonalMessageCell.h"

@interface LWTool : NSObject


//控制级别分析
+ (void)atientControlLevel:(double)controLevel withLayoutConstraint:(NSLayoutConstraint *)traint withLabel:(id)objc;

//便利排序对话
+ (void)traverseChatMessage:(NSMutableArray *)array;

//患者档案分析
+ (CGFloat)personalMessageSource:(NSString *)title WithLabel:(LWPersonalMessageCell *)cell WithModel:(LWPatientRecordsBaseModel *)model;

//分组遍历
+ (NSMutableArray *)forGrouping:(NSMutableArray *)array;

//患者ACT分析
+ (void)ACTAssessmentChangeWithModel:(LWACTModel *)model withArray:(NSMutableArray *)array;

//患者日志 控制分析
+ (NSMutableArray *)toDealWithAsthmaAssessLogModel:(LWAsthmaAssessLogModel *)model;
//患者PEF时间段走势分析
+ (NSDictionary *)patientPEFDateLineSx:(NSString *)date;

//卡片类型对话消息处理
+ (NSDictionary *)chatMessageCardModel:(LWChatModel *)model;

//表单数据分析
+ (LWTheFromBaseModel *)BiaoDanDataFenXiModel:(LWPatientBiaoDanBody *)model;

@end
