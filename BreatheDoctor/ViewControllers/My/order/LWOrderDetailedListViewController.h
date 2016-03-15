//
//  LWOrderListDetailedViewController.h
//  BreatheDoctor
//
//  Created by comv on 16/2/25.
//  Copyright © 2016年 lwh. All rights reserved.
// 订单详情列表

#import "BaseViewController.h"
#import "LWOrderListModel.h"
#import "LWOrderDetailedLisetCell.h"


@interface LWOrderDetailedListViewController : BaseViewController
@property (nonatomic, assign) ProductType productType;
@property (nonatomic, strong) LWOrderListModel *model;
@end
