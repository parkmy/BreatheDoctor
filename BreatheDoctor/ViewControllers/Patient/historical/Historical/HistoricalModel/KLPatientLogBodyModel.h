//
//  KLPatientLogBodyModel.h
//  BreatheDoctor
//
//  Created by comv on 16/3/25.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLPatientLogBodyModel : NSObject

@property (nonatomic, assign) double pefPredictedValue;
@property (nonatomic, strong) NSMutableArray *recordList;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
