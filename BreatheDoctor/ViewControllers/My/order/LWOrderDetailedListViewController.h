//
//  LWOrderListDetailedViewController.h
//  BreatheDoctor
//
//  Created by comv on 16/2/25.
//  Copyright © 2016年 lwh. All rights reserved.
// 订单详情列表

#import "BaseViewController.h"
#import "LWOrderListModel.h"

typedef NS_ENUM(NSInteger ,ProductType) {
    ProductTypeProductOrder  = 1,
    ProductTypeGraphicOrder = 2,
    ProductTypePhoneOrder   = 3,
};
@interface LWOrderDetailedListViewController : BaseViewController
@property (nonatomic, assign) ProductType productType;
@property (nonatomic, strong) LWOrderListModel *model;
@end
