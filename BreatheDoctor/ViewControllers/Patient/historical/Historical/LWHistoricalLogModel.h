//
//  LWHistoricalLogModel.h
//  BreatheDoctor
//
//  Created by comv on 16/3/22.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger ,HistoricalLogType) {
    HistoricalLogTypeTheBest = 0,//正常
    HistoricalLogTypeGeneral ,//异常
    HistoricalLogTypePoor ,//警告
};

@interface LWHistoricalLogModel : NSObject

@property (nonatomic, assign) HistoricalLogType historicalLogType;
@property (nonatomic, assign) double pefValue;
@property (nonatomic, copy)  NSString *recordDt;
@property (nonatomic, assign) double pefPredictedValue;
@property (nonatomic, strong) KLPatientLogModel *logModel;

@property (nonatomic, strong) NSMutableArray *symptoms;
@property (nonatomic, strong) NSMutableArray *medication;

@property (nonatomic, assign) CGFloat rowHeight;


+ (UIColor *)theBestDeepColor;
+ (UIColor *)theBestShallowColor;
+ (UIColor *)generalDeepColor;
+ (UIColor *)generalShallowColor;
+ (UIColor *)poorDeepColor;
+ (UIColor *)poorShallowColor;

+ (NSMutableArray *)historicalLogModelArrayInfo:(KLPatientLogBodyModel *)model;
@end
