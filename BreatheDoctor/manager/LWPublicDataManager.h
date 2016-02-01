//
//  LWPublicDataManager.h
//  BreatheDoctor
//
//  Created by comv on 15/11/12.
//  Copyright © 2015年 lwh. All rights reserved.
//  公共数据管理者

#import <Foundation/Foundation.h>
#import "CDPromptView.h"

@interface LWPublicDataManager : NSObject

#pragma mark - 日志
@property (nonatomic, copy) NSString *starDate; //开始时间
@property (nonatomic, copy) NSString *endDate; //结束时间
@property (nonatomic, copy) LWPEFLineModel *logModle;

@property (nonatomic, copy) NSString *yer;
@property (nonatomic, copy) NSString *month;
@property (nonatomic, strong) NSDate *changeDate;

@property (nonatomic, strong) CDPromptView * alther;
@property (nonatomic, assign) BOOL ifRemoveFromSuperview;
//当前对话ID
@property (nonatomic, copy) NSString *currentPatientID;

+ (LWPublicDataManager *)shareInstance;


+ (BOOL)IntoTheBackGroundtimeIsMoreThan:(NSInteger)time WithKey:(NSString *)key;

- (void)cloesCurrentPatientID;

NSString * stringJudgeNull(NSString *string);

//隐藏多余的tableview 分割线
void setExtraCellLineHidden(UITableView *tableView);

//添加患者
+ (void)AcceptButtonEventClick:(LWMainRows *)row
                       success:(void(^)())success
                       failure:(void(^)(NSString *errorMes))failure;


@end
