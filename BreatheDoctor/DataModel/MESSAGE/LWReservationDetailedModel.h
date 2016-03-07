//
//  LWReservationDetailedModel.h
//  BreatheDoctor
//
//  Created by comv on 16/3/3.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWReservationDetailedModel : NSObject

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *doctorName;
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *hospitalName;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *startTime;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
