//
//  LWAssessmentModel.h
//  BreatheDoctor
//
//  Created by comv on 15/11/27.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWAssessmentModel : NSObject
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, assign) double type;

@property (nonatomic, copy) NSString *starDate;
@property (nonatomic, copy) NSString *endDate;

@property (nonatomic, strong) NSDate *xdate;
@end
