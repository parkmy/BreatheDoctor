//
//  LWReservationDetailedModel.m
//  BreatheDoctor
//
//  Created by comv on 16/3/3.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWReservationDetailedModel.h"

@implementation LWReservationDetailedModel

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if ([super init])
    {
        _phone          = [dict objectForKey:@"phone"];
        _doctorName     = [dict objectForKey:@"doctorName"];
        _orderId        = [dict objectForKey:@"orderId"];
        _endTime        = [dict objectForKey:@"endTime"];
        _hospitalName   = [dict objectForKey:@"hospitalName"];
        _date           = [dict objectForKey:@"date"];
        _startTime      = [dict objectForKey:@"startTime"];
        
    }
    return self;
}

@end
