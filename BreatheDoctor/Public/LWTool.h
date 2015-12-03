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
+ (void)atientControlLevel:(double)controLevel withLayoutConstraint:(NSLayoutConstraint *)traint withLabel:(UILabel *)label;

//便利排序对话
+ (void)traverseChatMessage:(NSMutableArray *)array;

//患者档案分析
+ (CGFloat)personalMessageSource:(NSString *)title WithLabel:(LWPersonalMessageCell *)cell WithModel:(LWPatientRecordsBaseModel *)model;

+ (NSMutableArray *)forGrouping:(NSMutableArray *)array;

+ (void)ACTAssessmentChangeWithModel:(LWACTModel *)model withArray:(NSMutableArray *)array;


+ (NSMutableArray *)LogrowsCount;
+ (NSMutableArray *)LoglabelsCount:(LWPEFRecordList *)model;


+ (NSMutableArray *)toDealWithAsthmaAssessLogModel:(LWAsthmaAssessLogModel *)model;

@end
