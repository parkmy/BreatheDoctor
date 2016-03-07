//
//  LWOrderListModel.m
//  BreatheDoctor
//
//  Created by comv on 16/2/24.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWOrderListModel.h"

@implementation LWOrderListModel
- (id)initWithOrderLisetModelDic:(NSDictionary *)dic
{
    if ([super init])
    {
        _date = [dic objectForKey:@"date"];
        _graphicOrderNum    = [dic[@"graphicOrderNum"] integerValue];
        _phoneOrderNum      = [dic[@"phoneOrderNum"] integerValue];
        _productOrderNum    = [dic[@"productOrderNum"] integerValue];
        _orderSum = _graphicOrderNum + _productOrderNum + _phoneOrderNum;
    }
    return self;
}
@end
