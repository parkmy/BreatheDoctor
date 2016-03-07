//
//  LWOrderListModel.h
//  BreatheDoctor
//
//  Created by comv on 16/2/24.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWOrderListModel : NSObject

@property (nonatomic, copy) NSString *orderDate;

@property (nonatomic, copy) NSString *date;
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger orderSum;
@property (nonatomic, assign) NSInteger phoneOrderNum;
@property (nonatomic, assign) NSInteger graphicOrderNum;
@property (nonatomic, assign) NSInteger productOrderNum;

- (id)initWithOrderLisetModelDic:(NSDictionary *)dic;

@end
