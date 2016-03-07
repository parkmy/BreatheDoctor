
//
//  LWDetailedOrderListModel.m
//  BreatheDoctor
//
//  Created by comv on 16/3/1.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWDetailedOrderListModel.h"

@implementation LWDetailedOrderListModel
- (id)initWithDetailedOrderlistModelDic:(NSDictionary *)dic
{
    if ([super init]) {
        
        _quantity       = [dic objectForKey:@"quantity"];
        _accountPaid    = [dic objectForKey:@"accountPaid"];
        _patientName    = [dic objectForKey:@"patientName"];
        _imageUrl       = [dic objectForKey:@"imageUrl"];
        _fullName       = [dic objectForKey:@"fullName"];
        _createDt       = [dic objectForKey:@"createDt"];

    }
    return self;
}
@end
