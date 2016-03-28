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

+ (UIColor *)normalColor;
+ (UIColor *)abnormalColor;
+ (UIColor *)warningColor;
+ (UIColor *)noMeColor;
+ (NSMutableArray *)historicalType:(showHistoricalType)type;
- (NSMutableAttributedString *)historicalCountAttributedString;

@end
